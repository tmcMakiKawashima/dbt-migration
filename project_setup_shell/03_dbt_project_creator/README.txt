■利用方法
    以下を実行する
    01_project_creator.bat
        1. 実行すると「please input target dagster project full path here.」と表示されるので、「02_dagster_project_creator」で作成したdagsterプロジェクトのパスを入力する
            (例)「D:\Users\{ユーザー名}\dagster\sample_project\」

        2. 続いて「please input new dbt project name here.」と表示されるので、任意のdbtプロジェクトの名前を入力する
            (例)「dagster_dbt」

        実行が完了すると、今回作成したプロジェクトのフォルダが自動で開く
            (例)「D:\Users\{ユーザー名}\dagster\sample_project\dagster_dbt\」

■dbtプロジェクト作成時の入力値について
    PowerShell上にDB設定の問い合わせが表示されるため、以下のように設定すること。

    [設問]
        01.base would you like to use? [1] snowflake Enter a number:
            → 「1」と入力する

        02.account:
            → snowflakeのアカウントを入力する
            → (例)「nw21470.ap-northeast-1.aws」※非本番snowflakeアカウント

        03.user:
            → snowflakeで使用するシステムユーザーidを入力する(申請必要/過去プロジェクトにて申請されたもので流用できる可能性もあるため要確認のこと)

        04.[1] password
          [2] keypair
          [3] sso
          Desired authentication type option:
              → 「1」と入力する

        05.password:
            → snowflakeで使用するシステムユーザーパスワードを入力する(申請必要)

        06.role:
            → snowflakeで使用するロール名を入力する(申請必要/過去プロジェクトにて申請されたもので流用できる可能性もあるため要確認のこと)

        07.warehouse:
            → snowflakeで使用するウェアハウス名を入力する(申請必要/過去プロジェクトにて申請されたもので流用できる可能性もあるため要確認のこと)

        08.database:
            → snowflakeで使用するデータベース名を入力する(申請必要/過去プロジェクトにて申請されたもので流用できる可能性もあるため要確認のこと)

        09.schema:
            → snowflakeの使用するスキーマ名を入力する(申請必要/過去プロジェクトにて申請されたもので流用できる可能性もあるため要確認のこと)

        10.threads:
            → 「1」と入力する

    上記設問にて設定された情報ははユーザのホームフォルダ「\users\<user_name>\.dbt」の「profiles.yml」ファイルに定義されているため、
    これを「\users\<user_name>\dagster\{任意のdagsterプロジェクトフォルダ}\{任意のdbtプロジェクトフォルダ}\」の中にコピーする。

■バッチ起動がうまくいかない場合の回避方法
    以下のようにスクリプトを修正し、PowerShellのコンソールに直接コピペして実行してください。
        〇01_project_create.ps1
            修正前 : $CURRENT_DIR = Split-Path $MyInvocation.MyCommand.Path
            修正後 : $CURRENT_DIR = D:\{ユーザー名}\{展開先のパス}\{02_dagster_project_creator}\

■その他のファイルについて
    以下の2つは「01_project_creator.bat」にてdbtプロジェクトを作成した際、dbtプロジェクト内にコピーされるバッチとなる。
    実行する場合はdbtプロジェクト内にコピーされた方を実行すること。
        〇compile.ps1
        〇compile_runner.bat ← 実行対象

以上