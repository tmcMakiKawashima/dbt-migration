# ==== const ======================================================================================
# dev env value
$DEV_DIR = "$HOME\dev"

# dbt env value
$DBT_PROJECT_DIR = "$HOME\dev\kestra_dbt_project\enterprise_data_products"



# ==== dev project deps install ===============================================================
# dev dir
cd $DEV_DIR

# PowerShell executionPolicy setting
Set-ExecutionPolicy RemoteSigned -Scope Process -force

# Python venv activate for dev
venv\Scripts\activate

# dbt dir
cd $DBT_PROJECT_DIR

# dbt deps install
dbt deps

# Python venv deactivate for dev
deactivate
