import os
from dagster_dbt import DbtProject
from pathlib import Path

from dagster_dbt import DbtCliResource

def get_env():
    if os.getenv("DAGSTER_CLOUD_IS_BRANCH_DEPLOYMENT", "") == "1":
        return "dev"
    if os.getenv("DAGSTER_CLOUD_DEPLOYMENT_NAME", "") == "data-eng-prod":
        return "dev"
    return "dev"


dbt_project_path = Path(__file__).joinpath("..", "dbt_products", "enterprise_data_products").resolve()
# dbt_project_path = Path(__file__).parent.parent.joinpath("dagster_dbt")
# DBT_PROJECT_DIR = os.fspath(dbt_project_path)

dbt = DbtCliResource(project_dir=os.fspath(dbt_project_path))
dbt.cli(["deps"]).wait()


dbt_project = DbtProject(
    project_dir=dbt_project_path,
    state_path="target/slim_ci",
    target=get_env(),
)