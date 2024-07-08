# ==== const ======================================================================================
# dagster env value
$DAGSTER_DIR = "$HOME\dagster"

# my command path
$CURRENT_DIR = Split-Path $MyInvocation.MyCommand.Path



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
dagster dev -m dxpf_edp_dagster_edp_infra_ope_sample01 -m dxpf_edp_dagster_edp_infra_ope_sample02

# dagster dir
cd $DAGSTER_DIR

# Python venv deactivate for dagster
deactivate
