with stg_jyuchuzan_dec_test_syaryosys as (
    select
        dlrcd::varchar(5) as dlrcd, 
        chumon::varchar(10) as chumon, 
        jyucyubi::varchar(8) as jyucyubi, 
        kndate::varchar(8) as kndate, 
        dfsc::varchar(5) as dfsc, 
        iff(rtrim(odjun, '  ') = '', null, hex_encode(upper(odjun)))::varchar(10) as bytes,
        to_number((to_number(substr(bytes, 9, 2), 'XX') - 65) * pow(26, 0) +
            (to_number(substr(bytes, 7, 2), 'XX') - 65) * pow(26, 1) +
            (to_number(substr(bytes, 5, 2), 'XX') - 65) * pow(26, 2) +
            (to_number(substr(bytes, 3, 2), 'XX') - 65) * pow(26, 3) +
            (to_number(substr(bytes, 1, 2), 'XX') - 65) * pow(26, 4), 8) as odjun,
        farmgroup::varchar(8) as farmgroup, 
        null::varchar(11) as dummy, 
        ldts
    from {{ ref('substr_da34b11') }}
)
select * exclude(bytes) from stg_jyuchuzan_dec_test_syaryosys
where ldts = (select max(ldts) from stg_jyuchuzan_dec_test_syaryosys)