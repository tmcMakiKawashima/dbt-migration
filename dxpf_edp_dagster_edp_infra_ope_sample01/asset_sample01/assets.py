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
# asset_sample01の検証内容
# 1. dagster独自アセットを定義する方法
# 2. dagster独自アセットを実行対象に含める方法
# 3. アセットを手動実行する方法
# =================================================================================================

# 1. dagster独自アセットを定義する方法
@asset(
    group_name="asset_sample01", 
    description="dagster独自アセット及びマテリアライズ結果をリネージュとして反映するサンプル",
    key_prefix=[os.getenv("layer_sample01")])
def asset01() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,1,3"
        }
    )

# 2. dagster独自アセットを実行対象に含める方法
# プロジェクトルートフォルダ直下の「__init__.py」にてDifinitionsを定義する ※「__init__.py」参照のこと
#    すべてのアセットは「__init__.py」のDefinitionsに定義することで初めて実行可能となる

# 3. アセットを手動実行する方法
#    WebUI > Assets > View global asset linage > 任意のアセットを選択 > Materializeボタンを押下する
