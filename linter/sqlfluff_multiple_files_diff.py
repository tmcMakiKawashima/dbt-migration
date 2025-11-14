# import
import os
import glob
import subprocess
import shutil
from pprint import pprint
from datetime import datetime
import sys
import time


def getpath():
    dir = os.getcwd()
    template_name = "{}/linter/result/sqlfluff-result-diff_{}_{}.txt"
    branch_name = subprocess.run(
        ["git", "rev-parse", "--abbrev-ref", "HEAD"], capture_output=True, text=True
    ).stdout
    current_time = datetime.now().strftime("%Y%m%d-%H%M%S")
    result_name = template_name.format(dir, branch_name, current_time)
    result_name = result_name.replace("\n", "")
    return result_name


# 結果用変数
total_cnt = 0
pass_cnt = 0
fail_cnt = 0
target_branch = ""
# 引数なしの場合origin/mainと比較する
if len(sys.argv) <= 1:
    target_branch = "origin"
    print("orign/main と比較し、静的解析を行います")
    time.sleep(2)
else:
    target_branch = sys.argv[1]

# コマンドライン引数を取得
print("引数のリスト:", sys.argv)
# 一時ファイルの作成
os.makedirs("tmp", exist_ok=True)
# 結果ファイルの作成
os.makedirs("linter/result", exist_ok=True)
# 結果ファイル名：sqlfluff-result-diff_ブランチ名_yyyyMMdd-HHmmss.txt
resultpath = getpath()

# 差分ファイル一覧を取得
print("#ファイル読み込み中...\n対象ファイル：")
list = subprocess.run(
    ["git", "diff", target_branch, "--name-only"], capture_output=True, text=True
)
# 改行ごとに分割
sp = list.stdout.split("\n")
pprint(sp)
try:
    print("静的解析開始...")
    for index, i in enumerate(sp[:-1]):
        # sqlファイルのみを対象にする
        if ".sql" not in i:
            continue
        # 差分ファイルとディレクトリのファイルを突き合わせて
        # ディレクトリ内に存在しているファイルのみ静的解析を行う
        if os.path.exists(i):
            tmpcount = f"tmp/{index + 1}.txt"
            res = subprocess.run(
                [
                    "sqlfluff",
                    "lint",
                    i,
                    "--processes",
                    "0",
                    "--write-output",
                    tmpcount,
                    "--nocolor",
                ]
            )
            # コマンド実行失敗時（returncode=2）
            if res.returncode == 2:
                continue
            # 静的解析結果がFAILの場合
            if res.returncode == 1:
                fail_cnt += 1
            # 静的解析結果がPASSの場合
            if res.returncode == 0:
                pass_cnt += 1
                # PASSの結果を追記する（初期状態だと記載されないため）
                with open(tmpcount, mode="w") as f:
                    f.write(f"== {i} PASS\n")
            total_cnt += 1

    print("静的解析完了")
    # サマリ出力
    summary = (
        "==================================\n"
        f"[SQL Fluff Scan Result Summary]\n"
        f"Scanned: {total_cnt} files\n"
        f"Success: {pass_cnt} files\n"
        f"Failure: {fail_cnt} files\n"
        "==================================\n"
    )
    print(summary)
    print("結果出力中...")
    # tmpに存在するファイルを結合する
    # 結合対象ファイルリスト取得: 'tmp'内の全ての.txtファイルを取得
    file_list = glob.glob("tmp/*.txt")
    # 出力ファイルを書き込みモードで開く
    with open(resultpath, "w") as outfile:
        # サマリを書き込む
        outfile.write(summary)
        # 各ファイルを読み込み、出力ファイルに書き込む
        for file_name in file_list:
            with open(file_name, "r") as infile:
                outfile.write(infile.read())
    print("ファイルの出力が完了しました")

except Exception as e:
    print("実行時にエラーが発生しました")
    print(e)

finally:
    # tmpディレクトリを削除する
    shutil.rmtree("tmp")
