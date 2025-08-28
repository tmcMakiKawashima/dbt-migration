with stg_coorder_syaryosys as (
    select
        dlrcd::varchar(5) as dlrcd, 
        odno::varchar(12) as odno, 
        odrjuri::varchar(8) as odrjuri, 
        kndate::varchar(8) as kndate, 
        null::varchar(27) as dummy, 
        dfsc::varchar(5) as dfsc, 
        odjun::varchar(5) as odjun, 
        ldts
    from {{ ref('substr_da34b12') }}
)
select * from stg_coorder_syaryosys
where ldts = (select max(ldts) from stg_coorder_syaryosys)