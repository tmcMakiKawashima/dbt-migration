import base64
import json
import os
from io import BytesIO
from pathlib import Path
from dagster import (
    MaterializeResult,
    MetadataValue,
    asset,
    get_dagster_logger
)

# ログ出力
logger = get_dagster_logger()

# =================================================================================================
# asset_sample04の検証内容
# 1. dagster独自アセットをデータパイプライン化する方法
# 2. データパイプラインをJob化する方法
# 3. センサー定義方法
# 4. Jobをセンサーで定期実行する方法
# =================================================================================================

# 1. dagster独自アセット(先発)
@asset(
    group_name="asset_sample04", 
    description="センサー実行サンプル用1", 
    key_prefix=[os.getenv("layer_sample01")])
def asset04_01() -> MaterializeResult:
    logger.info('asset04_01 trace log1')
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

# 1. dagster独自アセット(後発) ※ アノテーションの「deps」に先発アセットを設定する記述がポイント
@asset(
    group_name="asset_sample04", 
    description="センサー実行サンプル用2", 
    key_prefix=[os.getenv("layer_sample01")],
    deps=[asset04_01])
def asset04_02() -> MaterializeResult:
    logger.info('asset04_02 trace log1')
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

# 2. データパイプラインをJob化する方法
#    プロジェクトルートフォルダ直下の「__init__.py」参照のこと

# 3. センサー定義方法
#    プロジェクトルートフォルダ直下の「__init__.py」参照のこと

# 4. Jobをセンサーで定期実行する方法
#    WebUI > Deployment > 対象のコードロケーション > Sensors > 対象のセンサーのRunnning項目のスイッチをONにする