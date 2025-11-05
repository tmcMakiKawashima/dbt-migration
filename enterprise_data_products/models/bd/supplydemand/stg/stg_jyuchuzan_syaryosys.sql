with stg_jyuchuzan_syaryosys as (
    select
        dlrcd::varchar(5) as dlrcd, 
        chumon::varchar(10) as chumon, 
        jyucyubi::varchar(8) as jyucyubi, 
        kndate::varchar(8) as kndate, 
        dfsc::varchar(5) as dfsc, 
        odjun::varchar(5) as odjun, 
        farmgroup::varchar(8) as farmgroup, 
        null::varchar(11) as dummy, 
        ldts
    from {{ ref('substr_da34b11') }}
)
select * from stg_jyuchuzan_syaryosys
where ldts = (select max(ldts) from stg_jyuchuzan_syaryosys)