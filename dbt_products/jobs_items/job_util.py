from ..enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import define_asset_job, RunConfig
from dagster_dbt import build_dbt_asset_selection


ops_item = "dbt_products_assets"
tags_base = {"ecs/cpu": "512", "ecs/memory": "2048"}
job_name_base_build = "job_build_"
job_name_base_scd = "job_snapshot_"
job_name_base_call = "job_call_"
dbt_job_name = "DBT_JOB_NAME"


# 取得したmodelに対してbuildジョブを作成してリストで保持
def make_job_list_bd(model_list: list[dict]):
    
    test_base = "source:*,+"
    job_list = []
    for item in model_list:
        name = item["name"]
        scd = item["snapshot"]
        # job name
        name_item = job_name_base_build + name
        # --select
        select_item = "+" + name
        # vars テスト結果出力用スキーマ
        vars_item = {}
        vars_item[dbt_job_name] = "_" + name
        # tests sourceのlengthテスト
        test_item = []
        test_item.append(test_base + name)
        # tags
        tags_item_bd = tags_base.copy()
        tags_item_bd["job_name"] = name_item
        if scd is not None:
            tags_item_bd["scd_job"] = job_name_base_scd + scd
        else:
            tags_item_bd["scd_job"] = None

        # print(name, scd, select_item, tags_item_bd)
        job = define_asset_job(
            name=name_item,
            selection=build_dbt_asset_selection(
                [dbt_products_assets],
                # --select +stg_xxx
                dbt_select=select_item,
            ),
            config=RunConfig(ops={ops_item: DbtConfig(dbt_vars=vars_item, source_test_list=test_item)}),
            tags=tags_item_bd,
        )
        job_list.append(job)
    return job_list



# 取得したmodelに対してsnapshotジョブを作成してリストで保持
def make_job_list_scd(model_list: list[dict]):
    
    job_list = []
    for item in model_list:
        scd = item["snapshot"]
        if scd is not None:
            # job name
            name_item = job_name_base_scd + scd
            # --select
            select_item = scd
            # tags
            tags_item_scd = tags_base.copy()
            tags_item_scd["job_name"] = name_item
            # print(scd, select_item)

            job = define_asset_job(
                name=name_item,
                selection=build_dbt_asset_selection(
                    [dbt_products_assets],
                    # --select scd_xxx
                    dbt_select=select_item,
                ),
                tags=tags_item_scd,
            )
            job_list.append(job)
    return job_list