with stg_daitaijoho_smshokyu as (
    select
        trim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 左右ブランク
        trim(hinban, ' 　')::varchar(10) as hinban, -- 左右ブランク
        trim(ruibetu, ' 　')::varchar(2) as ruibetu, -- 左右ブランク
        trim(daihin, ' 　')::varchar(10) as daihin, -- 左右ブランク
        trim(daihinrui, ' 　')::varchar(2) as daihinrui, -- 差湯ブランク
        trim(kerekijun, ' 　')::varchar(5) as kerekijun,  -- 左右ブランク
        sepnok::varchar(10) as sepnok,
        sepnom::varchar(10) as sepnom,
        trim(daikbn, ' 　')::varchar(2) as daikbn, -- 左右ブランク
        trim(daikosu, ' 　')::varchar(2) as daikosu, -- 左右ブランク
        trim(sentakukbn, ' 　')::varchar(2) as sentakukbn, -- 左右ブランク
        trim(setm, ' 　')::varchar(2) as setm, -- 左右ブランク
        trim(daicmt, ' 　')::varchar(30) as daicmt, -- 左右ブランク
        trim(tekikara, ' 　')::varchar(8) as tekikara, -- 左右ブランク
        trim(tekimade, ' 　')::varchar(8) as tekimade, -- 左右ブランク
        trim(mukoflg, ' 　')::varchar(1) as mukoflg, -- 左右ブランク
        trim(mainhin30, ' 　')::varchar(12) as mainhin30, -- 左右ブランク
        trim(torokud, ' 　')::varchar(8) as torokud, -- 左右ブランク
        trim(torokut, ' 　')::varchar(6) as torokut, -- 左右ブランク
        trim(kosind, ' 　')::varchar(8) as kosind, -- 左右ブランク
        trim(kosint, ' 　')::varchar(6) as kosint, -- 左右ブランク
        trim(kosinsya, ' 　')::varchar(16) as kosinsya, -- 左右ブランク
        _fivetran_synced::timestamp_ntz as ldts
    from {{source('fivetran_database_idr_hokyu_sms_dxpfy2d', 'raw_cvf12daitai')}}
    where _fivetran_deleted = 'false'
)

select * from stg_daitaijoho_smshokyu