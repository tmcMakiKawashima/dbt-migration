"""
To add a daily schedule that materializes your dbt assets, uncomment the following lines.
"""
""" D """
from .schedules_items.valuechain.public.schedule_d_epc import schedule_d_epc
from .schedules_items.marketing.public.schedule_stg_mashotoroku import schedule_stg_mashotoroku
from .schedules_items.administration.public.schedule_stg_mikado_nyutaijo import schedule_stg_mikado_nyutaijo
""" E """
from .schedules_items.vinhis.maint.schedule_dm_vinhis_maint import schedule_dm_vinhis_maint
from .schedules_items.vinhis.spec.schedule_dm_vinhis_specification_kaigai import schedule_dm_vinhis_specification_kaigai
from .schedules_items.vinhis.spec.schedule_dm_vinhis_specification_kokunai import schedule_dm_vinhis_specification_kokunai
from .schedules_items.vinhis.spec.schedule_dm_vinhis_specification_oem import schedule_dm_vinhis_specification_oem
""" F """
from .schedules_items.datamart.public.schedule_hokyunoki_mieruka import schedule_hokyunoki_mieruka
""" snapshot """
from .schedules_items.schedule_snapshot import schedule_snapshot


schedules = []

""" D層作成ジョブ """
# 補給品番基本情報提供
schedules.append(schedule_d_epc)
# RISM連携IF変更
schedules.append(schedule_stg_mashotoroku)
# MIKADO
schedules.append(schedule_stg_mikado_nyutaijo)

""" E層作成ジョブ """
# VIN整備
schedules.append(schedule_dm_vinhis_maint)
# VIN装備
schedules.append(schedule_dm_vinhis_specification_kaigai)
schedules.append(schedule_dm_vinhis_specification_kokunai)
schedules.append(schedule_dm_vinhis_specification_oem)

""" F層作成ジョブ """
# 補給納期視える化
schedules.append(schedule_hokyunoki_mieruka)

""" snapshot """
schedules.append(schedule_snapshot)