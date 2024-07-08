import base64
import json
import os
from io import BytesIO
from pathlib import Path
from dagster import ( 
    MaterializeResult,
    MetadataValue,
    asset,
    RunRequest
)

from dagster_dbt import get_asset_key_for_model
from dagster import AutoMaterializePolicy, AutoMaterializeRule, SkipReason

# =================================================================================================
# 検証中
# asset_sample07の検証内容
# センサーでのS3検知は検証済み。アセットにコードを適応して検証する
# 1. S3検知を複数用意しすべてのフォルダが更新されたら最後のアセットを実行することを検証する
#    asset_sample07を繰り返し実行する
#    asset07_01,asset07_03でS3検知する
#    更新されたことを判別するパラメータを持たせ、更新されていた場合はasset07_02,asset07_04を実行する
#    asset07_02,asset07_04がMaterializeされたらasset07_05を実行する
# =================================================================================================

# MY_DIRECTORY = "D:\\Users\\da-misawa-04.00\\dagster\\da-dxpf-edp-dagster-edp_infra_ope-sample\\dxpf_edp_dagster_edp_infra_ope_sample02"

@asset(
    group_name="asset_sample07", 
    description="S3検知用アセット", 
    key_prefix=[os.getenv("layer_sample02")])
def asset07_01() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

# def asset07_01(context):
#     bucket_name = EnvVar("S3_BUCKET_NAME").get_value()
#     bucket_prefix_name = EnvVar("S3_BUCKET_PREFIX_NAME").get_value()
#     # カーソルに初期値を与える機能がDagsterには存在してなさそうなので、外部（環境変数）から読み取るようにしてみた
#     init_cursor_value = EnvVar("INIT_CURSOR_VALUE").get_value()
#     asset_keys = [ "asset_s3_03" ]
#     s3ObjectsFilter = { "Prefix" : EnvVar("S3_BUCKET_PREFIX_NAME").get_value() } if EnvVar("S3_BUCKET_PREFIX_NAME").get_value() else {}
#     return s3_trigger_sensor_process(context, None, bucket_name, init_cursor_value, asset_keys, **s3ObjectsFilter)

    # has_files = False
    # for filename in os.listdir(MY_DIRECTORY):
    #     filepath = os.path.join(MY_DIRECTORY, filename)
    #     if os.path.isfile(filepath):
    #         return RunRequest(
    #             run_key=filename,
    #         )
    #         has_files = True
    #     if not has_files:
    #         print("skipReasonに入る")
    #         raise notfounderror("errorにする")

@asset(
    group_name="asset_sample07", 
    description="アップストリームのパラメータ検知",
    key_prefix=[os.getenv("layer_sample02")],
    deps=["asset07_01"])
def asset07_02() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(
    group_name="asset_sample07",
    description="S3検知用アセット",
    key_prefix=[os.getenv("layer_sample02")])
def asset07_03() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(
    group_name="asset_sample07", 
    description="アップストリームのパラメータ検知",
    key_prefix=[os.getenv("layer_sample02")],
    deps=["asset07_03"])
def asset07_04() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

# 待ち行列検証用コード(調査中のためコメントアウト)
wait_for_all_parents_policy = AutoMaterializePolicy.eager().with_rules(
    AutoMaterializeRule.skip_on_not_all_parents_updated()
)
@asset(
    group_name="asset_sample07", 
    description="アップストリームが更新されたことを検知し実行するアセット",
    key_prefix=[os.getenv("layer_sample02")],
    deps=["asset07_02", "asset07_04"], 
    auto_materialize_policy=wait_for_all_parents_policy)

# @asset(group_name="asset_sample07", deps=["asset07_02", "asset07_04"])
def asset07_05() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )



