{{
    config (
        materialized = 'incremental',
        unique_key = ['ym', 'caltimingkbn', 'shamei', 'sno', 'shinq','datarbn_7keta'],
        incremental_strategy = 'merge',
        post_hook = "
                delete from {{this}} where try_to_timestamp_ntz(ym,'yyyymm') < dateadd(month, -36, (select try_to_timestamp_ntz(max(ym),'yyyymm') from {{this}}))             
        "
    )
}}
-- 直近3年のみ保持する為post_hookによる削除処理を実装
with stg_jyuchu_seiyakukinosyukei_seiyakukakunin_jpass as (
    select
        rtrim(ym,' 　')::varchar(6) as ym
        ,rtrim(caltimingkbn,' 　')::varchar(2) as caltimingkbn
        ,rtrim(shamei,' 　')::varchar(2) as shamei
        ,rtrim(sno,' 　')::varchar(2) as sno
        ,rtrim(shinq,' 　')::varchar(3) as shinq
        ,rtrim(datarbn_7keta,' 　')::varchar(7) as datarbn_7keta
        ,rtrim(dlrcd,' 　')::varchar(5) as dlrcd
        ,rtrim(dlrcd_smksk,' 　')::varchar(5) as dlrcd_smksk
        ,rtrim(odno,' 　')::varchar(12) as odno
        ,rtrim(kncodewk,' 　')::varchar(7) as kncodewk
        ,rtrim(seiriyomaxym,' 　')::varchar(6) as seiriyomaxym
        ,rtrim(fulllank,' 　')::varchar(3) as fulllank
        ,rtrim(dummy,' 　')::varchar(20) as dummy
        ,ldts
        ,row_number() over (
            partition by ym ,caltimingkbn ,shamei ,sno ,shinq ,datarbn_7keta
            order by ldts desc, line_number desc
        ) aggkey 
    from {{ ref('substr_ktrla038zz0kaddb02') }}    
    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{this}})
    {% endif %}
)
select * exclude(aggkey) from stg_jyuchu_seiyakukinosyukei_seiyakukakunin_jpass
where aggkey = 1
