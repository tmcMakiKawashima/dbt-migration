# ==== const ======================================================================================
# dagster env value
$DAGSTER_DIR = "$HOME\dagster"

# my command path
$CURRENT_DIR = Split-Path $MyInvocation.MyCommand.Path



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

# dagster dir
cd $DAGSTER_DIR

# Python venv deactivate for dagster
deactivate
