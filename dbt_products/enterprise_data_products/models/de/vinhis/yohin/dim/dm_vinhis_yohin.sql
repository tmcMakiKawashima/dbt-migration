with
    tmp40_dm_vinhis_yohin as (
        select * from {{ ref('tmp40_dm_vinhis_yohin') }}
    ),
    stg_genyohinmaster as (
        select
            tk_cd, -- ﾃﾞｰﾀ部1.追工ｺｰﾄﾞ
            tsuikou_name, -- ﾃﾞｰﾀ部1.追工名称
            data1_hinmei, -- ﾃﾞｰﾀ部1.品名
            data2_tekimd, -- ﾃﾞｰﾀ部2.適用期間ﾏﾃﾞ
            data2_delflg, -- ﾃﾞｰﾀ部2.削除FLG
            yohinsyamei -- 用品車名No
        from {{ ref('stg_genyohinmaster') }} -- 現用品マスタ
        where data2_tekimd = '' and data2_delflg = '' -- 有効行のみを抽出
    )
select
     tmp40_dm_vinhis_yohin.syadai_kt, -- 車台型式 stg_shinsyameisai
     tmp40_dm_vinhis_yohin.frmno as frm_no, -- フレーム連番 stg_shinsyameisai
     tmp40_dm_vinhis_yohin.syasyu_cd, -- 車種コード stg_kokunaiseisan
     tmp40_dm_vinhis_yohin.haisya_kt, -- 配車型式 stg_kokunaiseisan
     tmp40_dm_vinhis_yohin.tkcd as tk_cd, --  追工コード stg_yohinmeisai
     tmp40_dm_vinhis_yohin.cdyouhinban as yohinban_cd, -- 用品品番コード stg_yohinsotyakureki
     stg_genyohinmaster.tsuikou_name as tsuiko_name, -- 追工名称 stg_genyohinmaster
     stg_genyohinmaster.data1_hinmei as yohinban_name, -- 用品名称 stg_genyohinmaster
     current_timestamp::timestamp_ntz as ldts -- Load Date
from tmp40_dm_vinhis_yohin
left outer join stg_genyohinmaster
    on tmp40_dm_vinhis_yohin.syameino = stg_genyohinmaster.yohinsyamei
    and tmp40_dm_vinhis_yohin.tkcd = stg_genyohinmaster.tk_cd
