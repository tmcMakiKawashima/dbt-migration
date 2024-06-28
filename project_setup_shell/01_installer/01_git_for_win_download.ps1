# ==== 定数 =======================================================================================
$TOOLS_DIR = "D:\tools"
$GIT_DIR = "PortableGit"
$GIT_DL_NAME = "PortableGit.exe"


# ==== Git for Windows Portable インストール ======================================================
# download from (Portable) https://git-scm.com/download/win
wget https://github.com/git-for-windows/git/releases/download/v2.45.1.windows.1/PortableGit-2.45.1-64-bit.7z.exe -O $TOOLS_DIR\$GIT_DL_NAME

# 環境変数に追加
[Environment]::GetEnvironmentVariable("Path", "User").Split(";")
$new_path = [Environment]::GetEnvironmentVariable("Path", "User")
$new_path += "$TOOLS_DIR\$GIT_DIR\bin;"
[Environment]::SetEnvironmentVariable("Path", $new_path, "User")

# 環境変数読み直し
$Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# ダウンロードしたフォルダを開く
Invoke-Item $TOOLS_DIR
