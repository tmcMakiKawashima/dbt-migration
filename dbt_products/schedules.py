"""
To add a daily schedule that materializes your dbt assets, uncomment the following lines.
"""

""" D """
""" administration """
from .schedules_items.administration.public.schedule_stg_mikado_nyutaijo import schedule_stg_mikado_nyutaijo
""" customerservice """
from .schedules_items.customerservice.public.schedule_stg_warranty import schedule_stg_warranty
""" marketing """
from .schedules_items.marketing.public.schedule_stg_mashotoroku import schedule_stg_mashotoroku
from .schedules_items.marketing.public.schedule_stg_yohinhinbanmeisai import schedule_stg_yohinhinbanmeisai
""" supplydemand """
from .schedules_items.supplydemand.public.schedule_stg_syaryoindex import schedule_stg_syaryoindex
from .schedules_items.supplydemand.public.schedule_stg_vlt_ord import schedule_stg_vlt_ord
""" valuechain """
from .schedules_items.valuechain.public.schedule_d_epc import schedule_d_epc

""" E """
""" vinhis maint """
from .schedules_items.vinhis.maint.schedule_dm_vinhis_maint import schedule_dm_vinhis_maint
""" vinhis spec """
from .schedules_items.vinhis.spec.schedule_dm_vinhis_specification_kaigai import schedule_dm_vinhis_specification_kaigai
from .schedules_items.vinhis.spec.schedule_dm_vinhis_specification_kokunai import schedule_dm_vinhis_specification_kokunai
from .schedules_items.vinhis.spec.schedule_dm_vinhis_specification_oem import schedule_dm_vinhis_specification_oem
""" vinhis yohin """
from .schedules_items.vinhis.yohin.schedule_dm_vinhis_yohin import schedule_dm_vinhis_yohin

""" F """
""" datamart """
from .schedules_items.datamart.public.schedule_hokyunoki_mieruka import schedule_hokyunoki_mieruka

""" snapshot """
from .schedules_items.schedule_snapshot import schedule_snapshot


schedules = []

""" D層作成ジョブ """
""" administration """
# MIKADO
schedules.append(schedule_stg_mikado_nyutaijo)
""" customerservice """
# ワランティ
schedules.append(schedule_stg_warranty)
""" marketing """
# RISM連携IF変更
schedules.append(schedule_stg_mashotoroku)
# 用品品番明細
schedules.append(schedule_stg_yohinhinbanmeisai)
""" supplydemand """
# 車両INDEX
schedules.append(schedule_stg_syaryoindex)
# VLTオーダー確定日チェックEUC
schedules.append(schedule_stg_vlt_ord)
""" valuechain """
# 補給品番基本情報提供
schedules.append(schedule_d_epc)

""" E層作成ジョブ """
""" vinhis maint """
# VIN整備
schedules.append(schedule_dm_vinhis_maint)
""" vinhis spec """
# VIN装備
schedules.append(schedule_dm_vinhis_specification_kaigai)
schedules.append(schedule_dm_vinhis_specification_kokunai)
schedules.append(schedule_dm_vinhis_specification_oem)
""" vinhis yohin """
# VIN用品
schedules.append(schedule_dm_vinhis_yohin)

""" F層作成ジョブ """
""" datamart """
# 補給納期視える化
schedules.append(schedule_hokyunoki_mieruka)

""" snapshot """
schedules.append(schedule_snapshot)