import os
from pathlib import Path

from dagster_dbt import DbtCliResource

dbt_project_dir = Path(__file__).joinpath("..", "..", "enterprise_data_products").resolve()
dbt = DbtCliResource(project_dir=os.fspath(dbt_project_dir))

# dbtのマニフェストを読み込む
# 読み込んだ「dbt_manifest_path」をasset.py側で参照する利用方法となる
# If DAGSTER_DBT_PARSE_PROJECT_ON_LOAD is set, a manifest will be created at runtime.
# Otherwise, we expect a manifest to be present in the project's target directory.
if os.getenv("DAGSTER_DBT_PARSE_PROJECT_ON_LOAD"):
    dbt_parse_invocation = dbt.cli(["parse"], manifest={}).wait()
    dbt_manifest_path = dbt_parse_invocation.target_path.joinpath("manifest.json")
else:
    dbt.cli(["deps"]).wait()
    dbt_manifest_path = dbt_project_dir.joinpath("target", "manifest.json")
