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
with stg_jyuchu_shosai_seiyakukakunin_jpass as (
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
        ,rtrim(nijsym_all,' 　')::varchar(6) as nijsym_all
        ,rtrim(nijsym_seiyakuari,' 　')::varchar(6) as nijsym_seiyakuari
        ,rtrim(jkeijyotuki,' 　')::varchar(6) as jkeijyotuki
        ,rtrim(nosyakibotuki,' 　')::varchar(6) as nosyakibotuki
        ,rtrim(daisu,' 　')::varchar(5) as daisu
        ,hckata::varchar(20) as hckata
        ,hkata::varchar(20) as hkata
        ,gaicd::varchar(4) as gaicd
        ,rtrim(ucd,' 　')::varchar(4) as ucd
        ,rtrim(tire,' 　')::varchar(3) as tire
        ,hoption::varchar(80) as hoption
        ,rtrim(knkkbnzenkokudumari,' 　')::varchar(1) as knkkbnzenkokudumari
        ,rtrim(jkeijyobi,' 　')::varchar(8) as jkeijyobi
        ,rtrim(jrdate,' 　')::varchar(8) as jrdate
        ,rtrim(motokndate,' 　')::varchar(8) as motokndate
        ,rtrim(sstbi,' 　')::varchar(8) as sstbi
        ,rtrim(sstbihan,' 　')::varchar(1) as sstbihan
        ,rtrim(skkibonk,' 　')::varchar(8) as skkibonk
        ,rtrim(kibonk,' 　')::varchar(8) as kibonk
        ,rtrim(odkbn,' 　')::varchar(1) as odkbn
        ,rtrim(odtjun,' 　')::varchar(5) as odtjun
        ,rtrim(kibostukistipintome,' 　')::varchar(8) as kibostukistipintome
        ,rtrim(sydate,' 　')::varchar(8) as sydate
        ,rtrim(haiyouflg,' 　')::varchar(1) as haiyouflg
        ,rtrim(serrmflg,' 　')::varchar(1) as serrmflg
        ,rtrim(dummy,' 　')::varchar(22) as dummy
        ,ldts
        ,row_number() over (
            partition by ym ,caltimingkbn ,shamei ,sno ,shinq ,datarbn_7keta
            order by ldts desc, line_number desc
        ) aggkey 
    from {{ ref('substr_ktrla038zz0kaddb01') }}    
    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{this}})
    {% endif %}
)
select * exclude(aggkey) from stg_jyuchu_shosai_seiyakukakunin_jpass
where aggkey = 1
