with
    tmp40_dm_vinhis_yohin as (
        select * from {{ ref('tmp40_dm_vinhis_yohin') }}
    ),
    stg_yohinmaster_pixy as (
        select
            rtrim(tuikou) as tuikou, -- 追工ｺｰﾄﾞ
            tuimei, -- 追工名称
            hinmei, -- 品名
            tekimd, -- 適用期間ﾏﾃﾞ
            sakujo, --削除フラグ
            syameino -- 用品車名No
        from {{ ref('stg_yohinmaster_pixy') }} -- DX用品マスター
        where rtrim(tekimd) = '' and rtrim(sakujo) = '' -- 有効行のみを抽出
    )
select
     tmp40_dm_vinhis_yohin.syadai_kt, -- 車台型式 stg_shinsyameisai
     tmp40_dm_vinhis_yohin.frmno as frm_no, -- フレーム連番 stg_shinsyameisai
     tmp40_dm_vinhis_yohin.syasyu_cd, -- 車種コード stg_kokunaiseisan
     tmp40_dm_vinhis_yohin.haisya_kt, -- 配車型式 stg_kokunaiseisan
     tmp40_dm_vinhis_yohin.tkcd as tk_cd, --  追工コード stg_yohinmeisai
     tmp40_dm_vinhis_yohin.cdyouhinban as yohinban_cd, -- 用品品番コード stg_yohinsotyakureki
     stg_yohinmaster_pixy.tuimei as tsuiko_name, -- 追工名称 stg_yohinmaster_pixy
     stg_yohinmaster_pixy.hinmei as yohinban_name, -- 用品名称 stg_yohinmaster_pixy
     current_timestamp::timestamp_ntz as ldts -- Load Date
from tmp40_dm_vinhis_yohin
left outer join stg_yohinmaster_pixy
    on tmp40_dm_vinhis_yohin.syameino = stg_yohinmaster_pixy.syameino
    and tmp40_dm_vinhis_yohin.tkcd = stg_yohinmaster_pixy.tuikou