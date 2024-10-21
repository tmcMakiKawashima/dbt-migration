from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# T-LINX_EPC
schedule_stg_t_linx_epc = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_t_linx_epc",
    schedule_name="T-LINX_EPC",
    cron_schedule="00 00 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_bunkaizukensaku +stg_bunkaizuimagekanri +stg_daitaihinbanjoho +stg_emokujikensaku +stg_figkensaku +stg_figmeisyo +stg_hinmei +stg_illustcomment +stg_katashikipattern +stg_syaryoshiyosobijoho +stg_syamei +stg_tactihinbanjoho",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_t_linx_epc"},
                                    source_test_list=["source:*,+stg_bunkaizukensaku",
                                                      "source:*,+stg_bunkaizuimagekanri",
                                                      "source:*,+stg_daitaihinbanjoho",
                                                      "source:*,+stg_emokujikensaku",
                                                      "source:*,+stg_figkensaku",
                                                      "source:*,+stg_figmeisyo",
                                                      "source:*,+stg_hinmei",
                                                      "source:*,+stg_illustcomment",
                                                      "source:*,+stg_katashikipattern",
                                                      "source:*,+stg_syaryoshiyosobijoho",
                                                      "source:*,+stg_syamei",
                                                      "source:*,+stg_tactihinbanjoho"])
                          }
                     ),
    default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_t_linx_epc"},
)
