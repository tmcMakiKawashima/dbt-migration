# ==== 定数 =======================================================================================
# dbtインストール先
$DBT_DIR = "$HOME\dbt"

# dbtバージョン
$DBT_VER = "1.7.1"


# ==== dbtインストール ========================================================================
# dbtインストール先のフォルダを作成する
mkdir $DBT_DIR -force

# dbtインストールフォルダに移動する
cd $DBT_DIR

# dagster用仮想環境の作成
virtualenv venv

# PowerShellを実行できるように権限を設定する
Set-ExecutionPolicy RemoteSigned -Scope Process -force

# dagsterのPython仮想環境をアクティブにする
venv\Scripts\activate

# dbt-snowflakeインストール
pip install dbt-snowflake==$DBT_VER

# dagsterのPython仮想環境を非アクティブにする
deactivate
