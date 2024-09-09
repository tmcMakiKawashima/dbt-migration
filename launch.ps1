# ==== const ======================================================================================
# dagster env value
$DAGSTER_DIR = "$HOME\dagster"

# my command path
$CURRENT_DIR = $PSScriptRoot



# ==== dagster project launch =====================================================================

# dagster dir
cd $DAGSTER_DIR\

# PowerShell executionPolicy setting
Set-ExecutionPolicy RemoteSigned -Scope Process -force

# Python venv activate for dagster
venv\Scripts\activate

# open new dagster project
start "http://localhost:3000/locations"

# dagster project dir
cd $CURRENT_DIR

# dagster project launch
$env:DAGSTER_DBT_PARSE_PROJECT_ON_LOAD=1; dagster dev -m dbt_products.definitions

# dagster dir
cd $DAGSTER_DIR

# Python venv deactivate for dagster
deactivate
