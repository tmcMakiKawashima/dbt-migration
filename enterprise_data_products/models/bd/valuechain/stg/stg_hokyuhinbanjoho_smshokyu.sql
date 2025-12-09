with stg_hokyuhinbanjoho_smshokyu as (
    select
        trim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 左右ブランク
        trim(hinban, ' 　')::varchar(10) as hinban, -- 左右ブランク
        trim(ruibetu, ' 　')::varchar(2) as ruibetu, -- 左右ブランク
        trim(kerekijun,' 　')::varchar(5) as kerekijun, -- 左右ブランク
        sepnok::varchar(10) as sepnok,
        sepnom::varchar(10) as sepnom,
        trim(hokyukbn, ' 　')::varchar(2) as hokyukbn, -- 左右ブランク
        trim(genkyu, ' 　')::varchar(1) as genkyu, -- 左右ブランク
        trim(tekikara, ' 　')::varchar(8) as tekikara, -- 左右ブランク
        trim(tekimade, ' 　')::varchar(8) as tekimade, -- 左右ブランク
        trim(mukoflg, ' 　')::varchar(1) as mukoflg, -- 左右ブランク
        trim(torokud, ' 　')::varchar(8) as torokud, -- 左右ブランク
        trim(torokut, ' 　')::varchar(6) as torokut, -- 左右ブランク
        trim(kosind, ' 　')::varchar(8) as kosind, -- 左右ブランク
        trim(kosint, ' 　')::varchar(6) as kosint, -- 左右ブランク
        trim(kosinsya, ' 　')::varchar(16) as kosinsya, -- 左右ブランク
        _fivetran_synced::timestamp_ntz as ldts
    from {{source('fivetran_database_idr_hokyu_sms_dxpfy2d', 'raw_cvf13hohinban')}}
    where _fivetran_deleted = 'false'
)

select * from stg_hokyuhinbanjoho_smshokyu