from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# D層TOPACS_0600
schedule_d_topacs_0600 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_topacs_0600",
    schedule_name="D_SOU_TOPACS_0600",
    cron_schedule="00 06 * * 0,2,3,4,5,6",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_catalog_topacs +stg_hakkokatasiki_topacs +stg_katasikihyogenjiki_topacs +stg_katasikipattern_topacs +stg_hinmeicodemeisyo_topacs",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_topacs_0600"},
                                    source_test_list=["source:*,+stg_catalog_topacs",
                                                      "source:*,+stg_hakkokatasiki_topacs",
                                                      "source:*,+stg_katasikihyogenjiki_topacs",
                                                      "source:*,+stg_katasikipattern_topacs",
                                                      "source:*,+stg_hinmeicodemeisyo_topacs"])
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_d_topacs_0600"},
)
