with stg_coorder_dec_syaryosys as (
    select
        dlrcd::varchar(5) as dlrcd, 
        odno::varchar(12) as odno, 
        odrjuri::varchar(8) as odrjuri, 
        kndate::varchar(8) as kndate, 
        dummy::varchar(27) as dummy, 
        dfsc::varchar(5) as dfsc, 
        iff(rtrim(odjun, '  ') = '', null, hex_encode(upper(odjun)))::varchar(10) as bytes,
        to_number((to_number(substr(bytes, 9, 2), 'XX') - 65) * pow(26, 0) +
            (to_number(substr(bytes, 7, 2), 'XX') - 65) * pow(26, 1) +
            (to_number(substr(bytes, 5, 2), 'XX') - 65) * pow(26, 2) +
            (to_number(substr(bytes, 3, 2), 'XX') - 65) * pow(26, 3) +
            (to_number(substr(bytes, 1, 2), 'XX') - 65) * pow(26, 4), 8) as odjun,
        ldts
    from {{ ref('stg_coorder_syaryosys') }}
)
select * exclude(bytes) from stg_coorder_dec_syaryosys