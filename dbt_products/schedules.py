"""
To add a daily schedule that materializes your dbt assets, uncomment the following lines.
"""

""" D """
""" administration """
from .schedules_items.administration.public.schedule_stg_mikado_nyutaijo import schedule_stg_mikado_nyutaijo
from .schedules_items.administration.public.schedule_stg_mikado_jnet_0645 import schedule_stg_mikado_jnet_0645
from .schedules_items.administration.public.schedule_stg_mikado_jnet_0715 import schedule_stg_mikado_jnet_0715
from .schedules_items.administration.public.schedule_stg_mikado_judgev import schedule_stg_mikado_judgev
""" customerservice """
from .schedules_items.customerservice.public.schedule_d_sias import schedule_d_sias
from .schedules_items.customerservice.public.schedule_stg_warranty import schedule_stg_warranty
""" engineering """
from .schedules_items.engineering.public.schedule_stg_aisac import schedule_stg_aisac
from .schedules_items.engineering.public.schedule_stg_paint_iot import schedule_stg_paint_iot
from .schedules_items.engineering.public.schedule_tmp_sms_api_parts_info_req_json import schedule_tmp_sms_api_parts_info_req_json
""" manufacturing """
from .schedules_items.manufacturing.public.schedule_stg_kojoiotpf import schedule_stg_kojoiotpf
from .schedules_items.manufacturing.public.schedule_stg_maps import schedule_stg_maps
""" marketing """
from .schedules_items.marketing.public.schedule_stg_mashotoroku import schedule_stg_mashotoroku
from .schedules_items.marketing.public.schedule_stg_yohinhinbanmeisai import schedule_stg_yohinhinbanmeisai
""" supplydemand """
from .schedules_items.supplydemand.public.schedule_d_jyukyujyoho_0130 import schedule_d_jyukyujyoho_0130
from .schedules_items.supplydemand.public.schedule_d_jyukyujyoho_0530 import schedule_d_jyukyujyoho_0530
from .schedules_items.supplydemand.public.schedule_d_jyukyujyoho_cam2204 import schedule_d_jyukyujyoho_cam2204
from .schedules_items.supplydemand.public.schedule_d_jyukyujyoho_cam2501 import schedule_d_jyukyujyoho_cam2501
from .schedules_items.supplydemand.public.schedule_d_jyukyujyoho_cam2502 import schedule_d_jyukyujyoho_cam2502
from .schedules_items.supplydemand.public.schedule_d_syaryosys_0200 import schedule_d_syaryosys_0200
from .schedules_items.supplydemand.public.schedule_d_syaryosys_0500 import schedule_d_syaryosys_0500
from .schedules_items.supplydemand.public.schedule_d_vlc_0130 import schedule_d_vlc_0130
from .schedules_items.supplydemand.public.schedule_d_vlc_0500 import schedule_d_vlc_0500
from .schedules_items.supplydemand.public.schedule_stg_aqua import schedule_stg_aqua
from .schedules_items.supplydemand.public.schedule_stg_dly_rpt_mst import schedule_stg_dly_rpt_mst
from .schedules_items.supplydemand.public.schedule_stg_dly_rpt import schedule_stg_dly_rpt
from .schedules_items.supplydemand.public.schedule_stg_galc_kpi import schedule_stg_galc_kpi
from .schedules_items.supplydemand.public.schedule_stg_jpass import schedule_stg_jpass
from .schedules_items.supplydemand.public.schedule_stg_jyukyujyoho_0730 import schedule_stg_jyukyujyoho_0730
from .schedules_items.supplydemand.public.schedule_stg_kodomo import schedule_stg_kodomo
from .schedules_items.supplydemand.public.schedule_stg_siyou_soubi_siyoumst import schedule_stg_siyou_soubi_siyoumst
from .schedules_items.supplydemand.public.schedule_stg_siyou_soubi_syasyu_siyousyo import schedule_stg_siyou_soubi_syasyu_siyousyo
from .schedules_items.supplydemand.public.schedule_stg_syaryoindex import schedule_stg_syaryoindex
from .schedules_items.supplydemand.public.schedule_stg_vlt_ord import schedule_stg_vlt_ord
""" valuechain """
from .schedules_items.valuechain.public.schedule_d_epc import schedule_d_epc
from .schedules_items.valuechain.public.schedule_d_gsps import schedule_d_gsps
from .schedules_items.valuechain.public.schedule_d_gsps_0600 import schedule_d_gsps_0600
from .schedules_items.valuechain.public.schedule_d_hokyusms_0600 import schedule_d_hokyusms_0600
from .schedules_items.valuechain.public.schedule_d_topacs_0600 import schedule_d_topacs_0600
from .schedules_items.valuechain.public.schedule_stg_smshokyu import schedule_stg_smshokyu

from .schedules_items.valuechain.public.schedule_stg_yui_cpos import schedule_stg_yui_cpos
""" E """
""" employee """
from .schedules_items.employee.organization.schedule_dm_jugyoinjoho import schedule_dm_jugyoinjoho
""" model repair """
from .schedules_items.model.repair.schedule_dm_cataloghinmei import schedule_dm_cataloghinmei
from .schedules_items.model.repair.schedule_dm_figbunkaiinfo import schedule_dm_figbunkaiinfo
from .schedules_items.model.repair.schedule_dm_vehicle_generation import schedule_dm_vehicle_generation
""" parts_list """
from .schedules_items.parts_list.public.schedule_dm_kousei_plantjiseki_kata import schedule_dm_kousei_plantjiseki_kata
""" parts_list seppen """
from .schedules_items.parts_list.seppen.schedule_dm_seppen_bunseki import schedule_dm_seppen_bunseki
""" parts_list sms"""
from .schedules_items.parts_list.sms.schedule_dm_kousei_blktenkai import schedule_dm_kousei_blktenkai
from .schedules_items.parts_list.sms.schedule_dm_legacy_kousei_blktenkai import schedule_dm_legacy_kousei_blktenkai
from .schedules_items.parts_list.sms.schedule_tmp_kousei03_blktenkai import schedule_tmp_kousei03_blktenkai
from .schedules_items.parts_list.sms.schedule_tmp_legacy_kousei03_blktenkai import schedule_tmp_legacy_kousei03_blktenkai
""" vinhis maint """
from .schedules_items.vinhis.maint.schedule_dm_vinhis_maint import schedule_dm_vinhis_maint
""" vinhis model """
from .schedules_items.vinhis.model.schedule_dm_vin_model import schedule_dm_vin_model
from .schedules_items.vinhis.model.schedule_dm_vin_model_nonesyasyu import schedule_dm_vin_model_nonesyasyu
""" vinhis spec """
from .schedules_items.vinhis.spec.schedule_dm_vinhis_specification import schedule_dm_vinhis_specification
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
schedules.append(schedule_stg_mikado_jnet_0645)
schedules.append(schedule_stg_mikado_jnet_0715)
# MIKADO Judge-V
schedules.append(schedule_stg_mikado_judgev)
""" customerservice """
# D層SIAS
schedules.append(schedule_d_sias)
# ワランティ
schedules.append(schedule_stg_warranty)
""" engineering """
# AISAC
schedules.append(schedule_stg_aisac)
# TMK塗装IoT
schedules.append(schedule_stg_paint_iot)
# SMS API（品番情報） REQUEST
schedules.append(schedule_tmp_sms_api_parts_info_req_json)
""" manufacturing """
# 工場Iot
schedules.append(schedule_stg_kojoiotpf)
# 資材調達システム_UDC公開用
schedules.append(schedule_stg_maps)
""" marketing """
# RISM連携IF変更
schedules.append(schedule_stg_mashotoroku)
# 用品品番明細
schedules.append(schedule_stg_yohinhinbanmeisai)
""" supplydemand """
# 需給情報基盤_0130
schedules.append(schedule_d_jyukyujyoho_0130)
# 需給情報基盤(オーダーDB)
schedules.append(schedule_d_jyukyujyoho_0530)
# 需給情報基盤_月度VCT
schedules.append(schedule_d_jyukyujyoho_cam2204)
# 需給情報基盤_国マスタ
schedules.append(schedule_d_jyukyujyoho_cam2501)
# 需給情報基盤_地域マスタ
schedules.append(schedule_d_jyukyujyoho_cam2502)
# 車両システム_0200
schedules.append(schedule_d_syaryosys_0200)
# 車両システム_0500
schedules.append(schedule_d_syaryosys_0500)
# VLC本体_0130
schedules.append(schedule_d_vlc_0130)
# VLC本体_0500
schedules.append(schedule_d_vlc_0500)
# AQUA
schedules.append(schedule_stg_aqua)
# 生産日報STEP3
schedules.append(schedule_stg_dly_rpt_mst)
schedules.append(schedule_stg_dly_rpt)
# 物流管理KPI(GALC_KPI)
schedules.append(schedule_stg_galc_kpi)
# JPASS
schedules.append(schedule_stg_jpass)
# 需給情報基盤_0730
schedules.append(schedule_stg_jyukyujyoho_0730)
# コドモ
schedules.append(schedule_stg_kodomo)
# 仕様装備
schedules.append(schedule_stg_siyou_soubi_siyoumst)
schedules.append(schedule_stg_siyou_soubi_syasyu_siyousyo)
# 車両INDEX
schedules.append(schedule_stg_syaryoindex)
# VLTオーダー確定日チェックEUC
schedules.append(schedule_stg_vlt_ord)
""" valuechain """
# 補給品番基本情報提供
schedules.append(schedule_d_epc)
# D層GSPS
schedules.append(schedule_d_gsps)
# D層GSPS_0600
schedules.append(schedule_d_gsps_0600)
# D層補給SMS_0600
schedules.append(schedule_d_hokyusms_0600)
# D層TOPACS_0600
schedules.append(schedule_d_topacs_0600)
# D層補給SMS_出荷先
schedules.append(schedule_stg_smshokyu)
# YUI_CPOS
schedules.append(schedule_stg_yui_cpos)
""" E層作成ジョブ """
""" employee """
# 従業員情報
schedules.append(schedule_dm_jugyoinjoho)
""" model repair """
# EPCカタログ品名
schedules.append(schedule_dm_cataloghinmei)
# FIG分解情報
schedules.append(schedule_dm_figbunkaiinfo)
# 車種世代
schedules.append(schedule_dm_vehicle_generation)
""" parts_list """
# AREA35品番属性情報追加
schedules.append(schedule_dm_kousei_plantjiseki_kata)
""" parts_list seppen """
# 認証不正防止対応(設変分析)
schedules.append(schedule_dm_seppen_bunseki)
""" parts_list sms"""
#SMS構成
schedules.append(schedule_dm_kousei_blktenkai)
#部品表データ活用
schedules.append(schedule_dm_legacy_kousei_blktenkai)
#SMS構成
schedules.append(schedule_tmp_kousei03_blktenkai)
#部品表データ活用
schedules.append(schedule_tmp_legacy_kousei03_blktenkai)
""" vinhis maint """
# VIN整備
schedules.append(schedule_dm_vinhis_maint)
""" vinhis model """
# VIN x 車両情報
schedules.append(schedule_dm_vin_model)
# VIN x 車両情報（車種コード指定なし）
schedules.append(schedule_dm_vin_model_nonesyasyu)
""" vinhis spec """
# VIN装備
schedules.append(schedule_dm_vinhis_specification)
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