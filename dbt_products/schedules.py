"""
To add a daily schedule that materializes your dbt assets, uncomment the following lines.
"""

""" D """
""" administration """
from .schedules_items.administration.public.schedule_stg_mikado_nyutaijo import schedule_stg_mikado_nyutaijo
from .schedules_items.administration.public.schedule_stg_mikado_jnet_bu import schedule_stg_mikado_jnet_bu
from .schedules_items.administration.public.schedule_stg_mikado_jnet_bumon import schedule_stg_mikado_jnet_bumon
from .schedules_items.administration.public.schedule_stg_mikado_jnet_businesstrip import schedule_stg_mikado_jnet_businesstrip
from .schedules_items.administration.public.schedule_stg_mikado_jnet_employee_shumu import schedule_stg_mikado_jnet_employee_shumu
from .schedules_items.administration.public.schedule_stg_mikado_jnet_kakarigroup import schedule_stg_mikado_jnet_kakarigroup
from .schedules_items.administration.public.schedule_stg_mikado_jnet_kintai_daily import schedule_stg_mikado_jnet_kintai_daily
from .schedules_items.administration.public.schedule_stg_mikado_jnet_kintai_monthly import schedule_stg_mikado_jnet_kintai_monthly
from .schedules_items.administration.public.schedule_stg_mikado_jnet_kyumurigyo import schedule_stg_mikado_jnet_kyumurigyo
from .schedules_items.administration.public.schedule_stg_mikado_jnet_kyumurigyo_haken import schedule_stg_mikado_jnet_kyumurigyo_haken
from .schedules_items.administration.public.schedule_stg_mikado_jnet_kyumurigyo_sk import schedule_stg_mikado_jnet_kyumurigyo_sk
from .schedules_items.administration.public.schedule_stg_mikado_jnet_name_history import schedule_stg_mikado_jnet_name_history
from .schedules_items.administration.public.schedule_stg_mikado_jnet_organization_english import schedule_stg_mikado_jnet_organization_english
from .schedules_items.administration.public.schedule_stg_mikado_jnet_pclog import schedule_stg_mikado_jnet_pclog
from .schedules_items.administration.public.schedule_stg_mikado_jnet_shikaku import schedule_stg_mikado_jnet_shikaku
from .schedules_items.administration.public.schedule_stg_mikado_jnet_shitsuka import schedule_stg_mikado_jnet_shitsuka
from .schedules_items.administration.public.schedule_stg_mikado_jnet_syagaisya import schedule_stg_mikado_jnet_syagaisya
from .schedules_items.administration.public.schedule_stg_mikado_jnet_syokui import schedule_stg_mikado_jnet_syokui
from .schedules_items.administration.public.schedule_stg_mikado_jnet_syokusyu import schedule_stg_mikado_jnet_syokusyu
from .schedules_items.administration.public.schedule_stg_mikado_jnet_syokutakupart import schedule_stg_mikado_jnet_syokutakupart
from .schedules_items.administration.public.schedule_stg_mikado_jnet_syoninkubun import schedule_stg_mikado_jnet_syoninkubun
from .schedules_items.administration.public.schedule_stg_mikado_jnet_syozoku import schedule_stg_mikado_jnet_syozoku
""" customerservice """
from .schedules_items.customerservice.public.schedule_stg_warranty import schedule_stg_warranty
""" engineering """
from .schedules_items.engineering.public.schedule_stg_paint_iot import schedule_stg_paint_iot
""" marketing """
from .schedules_items.marketing.public.schedule_stg_mashotoroku import schedule_stg_mashotoroku
from .schedules_items.marketing.public.schedule_stg_yohinhinbanmeisai import schedule_stg_yohinhinbanmeisai
""" supplydemand """
from .schedules_items.supplydemand.public.schedule_stg_aqua import schedule_stg_aqua
from .schedules_items.supplydemand.public.schedule_stg_syaryoindex import schedule_stg_syaryoindex
from .schedules_items.supplydemand.public.schedule_stg_vlt_ord import schedule_stg_vlt_ord
""" valuechain """
from .schedules_items.valuechain.public.schedule_d_epc import schedule_d_epc
from .schedules_items.valuechain.public.schedule_stg_t_linx_epc import schedule_stg_t_linx_epc

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
# MIKADO JNET
schedules.append(schedule_stg_mikado_jnet_bu)
schedules.append(schedule_stg_mikado_jnet_bumon)
schedules.append(schedule_stg_mikado_jnet_businesstrip)
schedules.append(schedule_stg_mikado_jnet_employee_shumu)
schedules.append(schedule_stg_mikado_jnet_kakarigroup)
schedules.append(schedule_stg_mikado_jnet_kintai_daily)
schedules.append(schedule_stg_mikado_jnet_kintai_monthly)
schedules.append(schedule_stg_mikado_jnet_kyumurigyo)
schedules.append(schedule_stg_mikado_jnet_kyumurigyo_haken)
schedules.append(schedule_stg_mikado_jnet_kyumurigyo_sk)
schedules.append(schedule_stg_mikado_jnet_name_history)
schedules.append(schedule_stg_mikado_jnet_organization_english)
schedules.append(schedule_stg_mikado_jnet_pclog)
schedules.append(schedule_stg_mikado_jnet_shikaku)
schedules.append(schedule_stg_mikado_jnet_shitsuka)
schedules.append(schedule_stg_mikado_jnet_syagaisya)
schedules.append(schedule_stg_mikado_jnet_syokui)
schedules.append(schedule_stg_mikado_jnet_syokusyu)
schedules.append(schedule_stg_mikado_jnet_syokutakupart)
schedules.append(schedule_stg_mikado_jnet_syoninkubun)
schedules.append(schedule_stg_mikado_jnet_syozoku)
""" customerservice """
# ワランティ
schedules.append(schedule_stg_warranty)
""" engineering """
# TMK塗装IoT
schedules.append(schedule_stg_paint_iot)
""" marketing """
# RISM連携IF変更
schedules.append(schedule_stg_mashotoroku)
# 用品品番明細
schedules.append(schedule_stg_yohinhinbanmeisai)
""" supplydemand """
# AQUA
schedules.append(schedule_stg_aqua)
# 車両INDEX
schedules.append(schedule_stg_syaryoindex)
# VLTオーダー確定日チェックEUC
schedules.append(schedule_stg_vlt_ord)
""" valuechain """
# 補給品番基本情報提供
schedules.append(schedule_d_epc)
# T-LINX_EPC
schedules.append(schedule_stg_t_linx_epc)

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