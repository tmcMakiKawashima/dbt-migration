with stg_systemmei_aisac as (
    select
        system::varchar(3) as system,
        systemmei::varchar(100) as systemmei,
        syssyubetu::varchar(1) as syssyubetu,
        lastmttime::varchar(17) as lastmttime,
        systorokutime::timestamp_ntz as systorokutime,
        systorokukaisyacode::varchar(5) as systorokukaisyacode,
        systorokuuserid::varchar(20) as systorokuuserid,
        systorokuaplid::varchar(25) as systorokuaplid,
        syskosintime::timestamp_ntz as syskosintime,
        syskosinkaisyacode::varchar(5) as syskosinkaisyacode,
        syskosinuserid::varchar(20) as syskosinuserid,
        syskosinaplid::varchar(25) as syskosinaplid,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_ogg_aisac_osqaeg0100db20', 'raw_cqa64jsystemmei') }}
    where _fivetran_deleted = 'false'
)
select * from stg_systemmei_aisac