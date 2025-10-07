from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# ワランティ
schedule_stg_warranty = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_warranty",
    schedule_name="WARRANTY",
    cron_schedule="00 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_warranty +stg_warranty_wcube +stg_warranty_comment +stg_warranty_chinesecomment +stg_warranty_goguchihinban +stg_warranty_koukanhinban +stg_warranty_kyusyo +stg_warranty_supplyer +stg_shijoho +stg_shijoho_syareki +stg_shijoho_tsuika +stg_shijoho_kanrentorokusheet +stg_shijoho_kokanbuhin +stg_shijoho_honbuntext +stg_shijoho_bugaihaihu",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_warranty"},
                                    source_test_list=["source:*,+stg_warranty",
                                                      "source:*,+stg_warranty_wcube",
                                                      "source:*,+stg_warranty_comment",
                                                      "source:*,+stg_warranty_chinesecomment",
                                                      "source:*,+stg_warranty_goguchihinban",
                                                      "source:*,+stg_warranty_koukanhinban",
                                                      "source:*,+stg_warranty_kyusyo",
                                                      "source:*,+stg_warranty_supplyer",
                                                      "source:*,+stg_shijoho",
                                                      "source:*,+stg_shijoho_syareki",
                                                      "source:*,+stg_shijoho_tsuika",
                                                      "source:*,+stg_shijoho_kanrentorokusheet",
                                                      "source:*,+stg_shijoho_kokanbuhin",
                                                      "source:*,+stg_shijoho_honbuntext",
                                                      "source:*,+stg_shijoho_bugaihaihu"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_warranty"},
)