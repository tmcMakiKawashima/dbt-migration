# ==== 定数 =======================================================================================
# dagsterインストール先
$DAGSTER_DIR = "$HOME\dagster"

# 実行時パス
$CURRENT_DIR = Split-Path $MyInvocation.MyCommand.Path

# プロジェクト別依存関係インストーラ
$DEPS_PS1 = "deps.ps1"
$DEPS_BAT = "deps_runner.bat"
$LAUNCH_PS1 = "launch.ps1"
$LAUNCH_BAT = "launch.bat"



# ==== ユーザー入力 ===============================================================================
# dagsterプロジェクト名
$PJ_NAME = Read-Host "please input new dagster project name here."

# ==== dagsterプロジェクト作成 ====================================================================
# dagsterフォルダに移動する
cd $DAGSTER_DIR

# PowerShellを実行できるように権限を設定する
Set-ExecutionPolicy RemoteSigned -Scope Process -force

# dagsterのPython仮想環境をアクティブにする
venv\Scripts\activate

# dagsterプロジェクトを作成する
dagster project scaffold --name $PJ_NAME

# プロジェクトごとの依存関係インストーラと起動Shellをプロジェクトフォルダにコピーする
cd $CURRENT_DIR
cp $DEPS_PS1   $DAGSTER_DIR\$PJ_NAME\$DEPS_PS1
cp $DEPS_BAT   $DAGSTER_DIR\$PJ_NAME\$DEPS_BAT
cp $LAUNCH_PS1 $DAGSTER_DIR\$PJ_NAME\$LAUNCH_PS1
cp $LAUNCH_BAT $DAGSTER_DIR\$PJ_NAME\$LAUNCH_BAT

# dagsterフォルダに移動する
cd $DAGSTER_DIR

# dagsterのPython仮想環境を非アクティブにする
deactivate

# 作成したdagsterプロジェクトを開く
Invoke-Item $DAGSTER_DIR\$PJ_NAME
