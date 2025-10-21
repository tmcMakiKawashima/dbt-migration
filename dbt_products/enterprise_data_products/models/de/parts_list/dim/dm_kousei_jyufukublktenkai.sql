{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'append',
        transient = false,
        pre_hook = "
            {% if is_incremental() %}
                delete from {{this}} th
                using (
                    select distinct 
                        syasyu,
                        kumitate,
                        bui
                    from {{ ref('tmp08_dm_kousei_jyufukublktenkai')}}
                ) zt
                where th.syasyu = zt.syasyu
                  and th.kumitate = zt.kumitate
                  and th.bui = zt.bui;
            {% endif %}
        "
    )
}}
-- 車種,組立番号,部位の単位で置き換える
with tmp08_dm_kousei_jyufukublktenkai as (
    select
        syasyu, -- 車種コード
        siyoubui, -- 使用部位
        kumitate, -- 組立番号
        bui, -- 部位
        motosiyoubui, -- 元使用部位
        shusiyoubui, -- 主側使用部位
        vari, -- バリエーション
        oyahin, -- 親品番
        lv, -- レベル
        kouseijyun, -- 構成順
        gc, -- GC
        kohin, -- 品番／BLKコード
        kohinmei, -- 品名／BLKコード名称
        kosu, -- 使用個数
        sentaku, -- 選択符号
        tyohuku, -- 重複記載
        tyohuku_flg, -- 重複FLG
        torokujunk, -- 登録／生認順カラ
        torokujunm, -- 登録／生認順マデ
        seppennok, -- 設変No.カラ
        seppennom, -- 設変No.マデ
        torokutimek, -- LOAD TIMEカラ
        torokutimem -- LOAD TIMEマデ
    from {{ref('tmp08_dm_kousei_jyufukublktenkai')}}
)
select
    tmp8.*,
    current_timestamp()::timestamp_ntz(9) as ldts
from tmp08_dm_kousei_jyufukublktenkai as tmp8