with stg_karikarifuri_syaryosys as (
    select
        dlrcd::varchar(5) as dlrcd,
        odno::varchar(12) as odno,
        odrjuri::varchar(8) as odrjuri,
        dlrcd2::varchar(5) as dlrcd2,
        chumon::varchar(10) as chumon,
        jyucyubi::varchar(8) as jyucyubi,
        null::varchar(12) as dummy,
        ldts
    from {{ ref('substr_da34b13') }}
)
select * from stg_karikarifuri_syaryosys
where ldts = (select max(ldts) from stg_karikarifuri_syaryosys)