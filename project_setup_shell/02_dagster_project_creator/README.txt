■利用方法
    以下を実行する
    01_project_creator.bat
    実行すると「please input new dagster project name here.」を表示されるので、任意のプロジェクト名を入力する
        (例)「sample_project」

    実行が完了すると、今回作成したプロジェクトのフォルダが自動で開く
        (例)「D:\Users\{ユーザー名}\dagster\sample_project\」

■バッチ起動がうまくいかない場合の回避方法
    以下のようにスクリプトを修正し、PowerShellのコンソールに直接コピペして実行してください。
        〇01_project_create.ps1
            修正前 : $CURRENT_DIR = Split-Path $MyInvocation.MyCommand.Path
            修正後 : $CURRENT_DIR = D:\{ユーザー名}\{展開先のパス}\{02_dagster_project_creator}\

■その他のファイルについて
    以下の4つは「01_project_creator.bat」にてdagsterプロジェクトを作成した際、dbtプロジェクト内にコピーされるバッチとなる。
    実行する場合はdagsterプロジェクト内にコピーされた方を実行すること。
        〇deps.ps1
        〇deps.bat   ← 実行対象
        〇launch.ps1
        〇launch.bat ← 実行対象

以上