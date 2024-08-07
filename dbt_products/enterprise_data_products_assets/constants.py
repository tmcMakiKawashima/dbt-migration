import os
from pathlib import Path

from dagster_dbt import DbtCliResource

dbt_project_dir = Path(__file__).joinpath("..", "..", "enterprise_data_products").resolve()
dbt_profiles_dir = Path(__file__).joinpath("..").resolve()
dbt = DbtCliResource(project_dir=os.fspath(dbt_project_dir), profiles_dir=os.fspath(dbt_profiles_dir))

if not os.getenv("dbt_deploy_env", "") == "local":
        dbt.cli(["deps"]).wait()

# dbtのマニフェストを読み込む
# 読み込んだ「dbt_manifest_path」をasset.py側で参照する利用方法となる
# If DAGSTER_DBT_PARSE_PROJECT_ON_LOAD is set, a manifest will be created at runtime.
# Otherwise, we expect a manifest to be present in the project's target directory.
# https://github.com/dagster-io/dagster/discussions/18235
# dagster-dbt creates a separate target folder for each invocation to avoid issues with multiple concurrent dbt invocations (in separate processes) writing to the same output files.
# Generally, the manifest.json will be copied over into that temporary directory, so it will not actually be regenerated on each dbt invocation.
if os.getenv("DAGSTER_DBT_PARSE_PROJECT_ON_LOAD"):
    dbt_manifest_path = (
        dbt.cli(
            ["--quiet", "parse"],
            target_path=Path("target"),
        )
        .wait()
        .target_path.joinpath("manifest.json")
    )
else:
    dbt_manifest_path = dbt_project_dir.joinpath("target", "manifest.json")
