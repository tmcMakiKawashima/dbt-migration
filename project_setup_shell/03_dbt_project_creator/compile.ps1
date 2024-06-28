# ==== const ======================================================================================
# dagster and dbt env value
$DBT_DIR = "$HOME\dbt"

# current path
$CURRENT_DIR = Split-Path $MyInvocation.MyCommand.Path

# ==== dbt build ==================================================================================

# dbt dir
cd $DBT_DIR\

# PowerShell executionPolicy setting
Set-ExecutionPolicy RemoteSigned -Scope Process -force

# Python venv activate for dagster
venv\Scripts\activate

# dagster-dbt dir
cd $CURRENT_DIR

# dbt build
dbt compile

# dbt dir
cd $DBT_DIR\

# Python venv deactivate for dagster
deactivate
