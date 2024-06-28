■利用方法
    以下を順番に実行する(既にインストール済みか確認してください)
    01_git_for_win_downloader.bat(ダウンロード後実行し、ウィザードからインストールすること / ダウンロードしたexeファイルはインストール後削除すること)
    02_python_installer.bat
    03_dagster_installer.bat
    04_dbt_installer.bat

■Pythonが指定の位置に存在する場合(本インストーラで導入した場合「D:\python」にインストールされる)
    「01_python_installer.bat」の実行はスキップしてもOK

■Git for Windowsのウィザードにて入力する値について
    インストール先の設問があるので「D:\tools\PortableGit」と入力すること

■Git for Windowsのバージョンについて
    2024年05月現在 : https://github.com/git-for-windows/git/releases/download/v2.45.1.windows.1/PortableGit-2.45.1-64-bit.7z.exe
    変更する場合はShellの記述を書き換えてください

■バッチ起動がうまくいかない場合の回避方法
    01～04の「.ps1」側のスクリプトをPowerShellのコンソールに直接コピペして実行してください。

以上