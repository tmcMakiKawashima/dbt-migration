with stg_hinbantikibetsutaiouhinban_smshokyu as (
    select
        trim(hinban, ' 　')::varchar(10) as hinban,
        trim(ruibetu, ' 　')::varchar(2) as ruibetu, -- 左右ブランク
        trim(syaryoszoco, ' 　')::varchar(4) as syaryoszoco, -- 左右ブランク
        trim(dounyutiikicd, ' 　')::varchar(3) as dounyutiikicd, -- 左右ブランク
        trim(tkerekijun, ' 　')::varchar(5) as tkerekijun, -- 左右ブランク
        trim(hokyuhinban, ' 　')::varchar(10) as hokyuhinban, -- 左右ブランク
        trim(hokyuhinrui, ' 　')::varchar(2) as hokyuhinrui, -- 左右ブランク
        trim(hokyuhintekk, ' 　')::varchar(8) as hokyuhintekk, -- 左右ブランク
        trim(hokyuhintekm, ' 　')::varchar(8) as hokyuhintekm, -- 左右ブランク
        trim(sepjunk, ' 　')::varchar(10) as sepjunk, -- 左右ブランク
        trim(sepjunm, ' 　')::varchar(10) as sepjunm, -- 左右ブランク
        trim(mukoflg, ' 　')::varchar(1) as mukoflg, -- 左右ブランク
        trim(mflg, ' 　')::varchar(2) as mflg, -- 左右ブランク
        trim(torokud, ' 　')::varchar(8) as torokud, -- 左右ブランク
        trim(torokut, ' 　')::varchar(6) as torokut, -- 左右ブランク
        trim(kosind, ' 　')::varchar(8) as kosind, -- 左右ブランク
        trim(kosint, ' 　')::varchar(6) as kosint, -- 左右ブランク
        trim(kosinsya, ' 　')::varchar(16) as kosinsya,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_hokyu_sms_dxpfy2d', 'raw_cvh02taiohhinban') }}
    where _fivetran_deleted = 'false'
)

select * from stg_hinbantikibetsutaiouhinban_smshokyu