# ==== const ======================================================================================
# dagster env value
$DAGSTER_DIR = "$HOME\dagster"

# dbt env value
$DBT_PROJECT_DIR = "$HOME\dagster\dagster_cloud_deploy\dbt_products\enterprise_data_products"

# my command path
$CURRENT_DIR = $PSScriptRoot



# ==== dagster project deps install ===============================================================
# dagster dir
cd $DAGSTER_DIR\

# PowerShell executionPolicy setting
Set-ExecutionPolicy RemoteSigned -Scope Process -force

# Python venv activate for dagster
venv\Scripts\activate

# dagster project dir
cd $CURRENT_DIR

# dagster project deps install
pip install -e ".[dev]"

# dbt dir
cd $DBT_PROJECT_DIR

# dbt deps install
dbt deps

# Python venv deactivate for dagster
deactivate
