with stg_juchuzan_shiyoerr_syaryosys as (
    select
        dlrcd::varchar(5) as dlrcd,
        chumon::varchar(10) as chumon,
        hkata::varchar(20) as hkata,
        syamei::varchar(2) as syamei,
        skkubun::varchar(1) as skkubun,
        errbunrui::varchar(1) as errbunrui,
        kkbn::varchar(1) as kkbn,
        dummy::varchar(20) as dummy,
        ldts
    from {{ ref('substr_da34b16') }}
)
select * from stg_juchuzan_shiyoerr_syaryosys
where ldts = (select max(ldts) from stg_juchuzan_shiyoerr_syaryosys)