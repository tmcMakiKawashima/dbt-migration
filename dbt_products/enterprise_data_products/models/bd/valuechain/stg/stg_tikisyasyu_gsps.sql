with stg_tikisyasyu_gsps as (
    select
        trim(donyutiiki, ' 　')::varchar(3) as donyutiiki, -- 左右ブランク
        trim(syasyu, ' 　')::varchar(4) as syasyu, -- 左右ブランク
        trim(kosincompid, ' 　')::varchar(5) as kosincompid, -- 左右ブランク
        trim(kosinuserid, ' 　')::varchar(10) as kosinuserid, -- 左右ブランク
        trim(kosintime, ' 　')::varchar(16) as kosintime, -- 左右ブランク
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_gsps_dxpfy2d', 'raw_cvk02tksyasyu' )}}
    where _fivetran_deleted = 'false'
)

select * from stg_tikisyasyu_gsps