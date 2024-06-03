import base64
import json
import os
from io import BytesIO
from pathlib import Path
from dagster import ( 
    MaterializeResult,
    MetadataValue,
    asset
)

# =================================================================================================
# asset_sample02の検証内容
# 1. 名称重複確認のため、asset_sample01とは別のグループ名を指定し、同一名で別定義をして重複となるか確認する
# 2. フォルダ構成の検討
# =================================================================================================

# 1. 同一プロジェクト内はアセット名は一意である必要があるため以下のようには記述できない
# ※ group_nameの指定はプログラム的な名前空間ではなく、リネージュを表現する上でのグルーピングの指定となる
# @asset(group_name="asset_sample02")
# def asset01() -> MaterializeResult:
#   return MaterializeResult(
#       metadata={
#           "test": "1,2,3"
#       }
#   )
#
# ↓
#
# プロジェクト内で重複していない名称で定義する必要がある
@asset(group_name="asset_sample02", description="dagster独自アセット及びマテリアライズ結果をリネージュとして反映するサンプル")
def asset02() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )


# 2. フォルダの切り分けは、ある1つのデータパインプライン単位でまとめたほうが良い
#    または共通的なアセットがある場合もそれ用にフォルダでまとめると良い
