with stg_hokyuhinbancomment_smshokyu as (
    select
        trim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 左右ブランク
        trim(hinban, ' 　')::varchar(10) as hinban, -- 左右ブランク
        trim(ruibetu, ' 　')::varchar(2) as ruibetu, -- 左右ブランク
        trim(comkbn, ' 　')::varchar(2) as comkbn, -- 左右ブランク
        hinbancmt::varchar(40) as hinbancmt,
        trim(torokud, ' 　')::varchar(8) as torokud, -- 左右ブランク
        trim(torokut, ' 　')::varchar(6) as torokut, -- 左右ブランク
        trim(kosind, ' 　')::varchar(8) as kosind, -- 左右ブランク
        trim(kosint, ' 　')::varchar(6) as kosint, -- 左右ブランク
        trim(kosinsya, ' 　')::varchar(16) as kosinsya, -- 左右ブランク
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_hokyu_sms_dxpfy2d', 'raw_cvf13hohincmt' )}}
    where _fivetran_deleted = 'false'
)

select * from stg_hokyuhinbancomment_smshokyu