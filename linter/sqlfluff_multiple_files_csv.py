# import
import os
import glob
import subprocess
import shutil
import sys
from pprint import pprint
from datetime import datetime

# 結果用変数
total_cnt = 0
pass_cnt = 0
fail_cnt = 0

# 一時ディレクトリの作成
os.makedirs("tmp", exist_ok=True)
# 結果ディレクトリの作成
os.makedirs("linter/result", exist_ok=True)
# 結果ファイル名：sqlfluff-result-csv_ブランチ名_yyyyMMdd-HHmmss.txt
dir = os.getcwd()
template_name = "{}/linter/result/sqlfluff-result-csv_{}_{}.txt"
branch_name = subprocess.run(
    ["git", "rev-parse", "--abbrev-ref", "HEAD"], capture_output=True, text=True
).stdout
current_time = datetime.now().strftime("%Y%m%d-%H%M%S")
result_name = template_name.format(dir, branch_name, current_time)
result_name = result_name.replace("\n", "")
csv = str(glob.glob(f"**/{sys.argv[1]}", recursive=True))
csv = csv.replace("'", "")
csv = csv.replace("[", "")
csv = csv.replace("]", "")
template_csv = "{}\{}"
target_csv = template_csv.format(dir, csv)

# ファイルを開く
with open(f"{target_csv}", "r", encoding="utf-8") as file:
    data = [line.strip().split(",") for line in file]  # 各行をカンマで分割
print("#ファイル読み込み中...\n対象ファイル：")
pprint(data)

try:
    print("静的解析開始...")
    # csvのファイル名からPATHを検索し、静的解析を行う
    for x, i in enumerate(data):
        for y, j in enumerate(i):
            # PATH検索
            res = glob.glob(f"**/{j}", recursive=True)
            strpath = str(res)
            if len(res) > 1:
                print("同名のファイルが存在しているため、PATHを追記してください")
                print(f"対象ファイル{strpath}")
                quit()
            path = strpath.replace("]", "")
            path = path.replace("[", "")
            path = path.replace("'", "")
            index = y + 1
            # 結果をtmpに格納する
            tmpcount = f"tmp\{x}{index}.txt"
            # 静的解析実行
            res = subprocess.run(
                [
                    "sqlfluff",
                    "lint",
                    path,
                    "--processes",
                    "0",
                    "--write-output",
                    tmpcount,
                    "--nocolor",
                ]
            )
            # コマンド実行失敗時（returncode=2）
            if res.returncode == 2:
                raise (Exception)
            # 静的解析結果がFAILの場合
            if res.returncode == 1:
                fail_cnt += 1
            # 静的解析結果がPASSの場合
            if res.returncode == 0:
                pass_cnt += 1
                # PASSの結果を追記する（初期状態だと記載されないため）
                with open(tmpcount, mode="w") as f:
                    f.write(f"== {strpath} PASS\n")
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
    with open(result_name, "w") as outfile:
        # サマリを書き込む
        outfile.write(summary)
        # 各ファイルを読み込み、出力ファイルに書き込む
        for file_name in file_list:
            with open(file_name, "r") as infile:
                outfile.write(infile.read())
                # print(file_name)
    print("静的解析が完了しました")

except Exception as e:
    print("実行時にエラーが発生しました")
    print(e)

finally:
    # tmpディレクトリを削除する
    shutil.rmtree("tmp")
