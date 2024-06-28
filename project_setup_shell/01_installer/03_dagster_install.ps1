# ==== 定数 =======================================================================================
# dagsterインストール先
$DAGSTER_DIR = "$HOME\dagster"



# ==== dagsterインストール ========================================================================
# dagsterインストール先のフォルダを作成する
mkdir $DAGSTER_DIR -force

# dagsterインストールフォルダに移動する
cd $DAGSTER_DIR

# dagster用仮想環境の作成
virtualenv venv

# PowerShellを実行できるように権限を設定する
Set-ExecutionPolicy RemoteSigned -Scope Process -force

# dagsterのPython仮想環境をアクティブにする
venv\Scripts\activate

# dagsterインストール
pip install dagster dagster-webserver
pip install dagster

# dagsterのPython仮想環境を非アクティブにする
deactivate
