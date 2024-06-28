# ==== 定数 =======================================================================================
$DBT_DIR = "$HOME\dbt"

# 実行時パス
$CURRENT_DIR = Split-Path $MyInvocation.MyCommand.Path

# ==== ユーザー入力 ===============================================================================
# dagsterプロジェクトパス
$DAGSTER_PJ_PATH = Read-Host "please input target dagster project full path here."

#dbtプロジェクト名
$DBT_PJ_NAME = Read-Host "please input new dbt project name here."

# dbt build用Shell
$BUILD_PS1 = "compile.ps1"
$BUILD_BAT = "compile_runner.bat"



# ==== dbtプロジェクト作成 ====================================================================
# dbtフォルダに移動する
cd $DBT_DIR

# PowerShellを実行できるように権限を設定する
Set-ExecutionPolicy RemoteSigned -Scope Process -force

# dbtのPython仮想環境をアクティブにする
venv\Scripts\activate

# dagster pj dir
cd $DAGSTER_PJ_PATH

# dbt init
dbt init $DBT_PJ_NAME

# check Configuration & Connection
cd $DBT_PJ_NAME
dbt debug

# dbtのPython仮想環境を非アクティブにする
deactivate

# dbtビルド用Shellをプロジェクトフォルダにコピーする
cd $CURRENT_DIR
cp $BUILD_PS1 $DAGSTER_PJ_PATH\$DBT_PJ_NAME\$BUILD_PS1
cp $BUILD_BAT $DAGSTER_PJ_PATH\$DBT_PJ_NAME\$BUILD_BAT

# 作成したdbtプロジェクトを開く
Invoke-Item $DAGSTER_PJ_PATH\$DBT_PJ_NAME