# ==== 定数 =======================================================================================
# Pythonインストールパス
$PYTHON_DIR = "D:\python"



# ==== Pythonインストール =========================================================================
# Pythonインストールフォルダを作成する
mkdir $PYTHON_DIR -force

# Pythonインストール先に移動する
cd $PYTHON_DIR

# Pythonダウンロード / 解凍 / ダウンロードした圧縮ファイルを削除
wget "https://www.python.org/ftp/python/3.10.11/python-3.10.11-embed-amd64.zip" -O python.zip # Ver3.10推奨？(2023/02時点)
Expand-Archive -Path python.zip -DestinationPath ./
rm python.zip

# Pythonのコンフィグ設定
$PTH_FILE = "python310._pth" # Ver3.10推奨？(2023/02時点)

# Pythonインストール先に移動する
cd $PYTHON_DIR

# notepad .\$PTH_FILE
# (変更前) #import site
# ↓
# (変更後) import site
(Get-Content .\$PTH_FILE) | foreach { $_ -replace "#import site", "import site" } | Set-Content .\$PTH_FILE



# ==== pipインストール ============================================================================
# Pythonインストール先に移動する
cd $PYTHON_DIR

# pipダウンロード / get pip.py実行 / get pip.py削除
wget "https://bootstrap.pypa.io/get-pip.py" -O get-pip.py
.\python .\get-pip.py
rm .\get-pip.py


# ==== 環境変数設定 ===============================================================================
[Environment]::GetEnvironmentVariable("Path", "User").Split(";")
$new_path = [Environment]::GetEnvironmentVariable("Path", "User")
$new_path += "$PYTHON_DIR;"
$new_path += "$PYTHON_DIR\Scripts;"
[Environment]::SetEnvironmentVariable("Path", $new_path, "User")

# 環境変数リロード
$Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")



# ==== virtualenvインストール =====================================================================
# Pythonインストール先に移動する
cd $PYTHON_DIR

# virtualenvをインストールする
.\python -m pip install virtualenv
