with stg_hokyusyukkabasyo_smshokyu as (
    select
        trim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 左右ブランク
        trim(hinban, ' 　')::varchar(10) as hinban, -- 左右ブランク
        trim(ruibetu, ' 　')::varchar(2) as ruibetu, -- 左右ブランク
        trim(kyokucd, ' 　')::varchar(3) as kyokucd, -- 左右ブランク
        trim(kerekijun, ' 　')::varchar(5) as kerekijun, -- 左右ブランク
        sepnok::varchar(10) as sepnok,
        sepnom::varchar(10) as sepnom,
        trim(hokanjoho,' 　')::varchar(8) as hokanjoho, -- 左右ブランク
        trim(ktsyasyu, ' 　')::varchar(4) as ktsyasyu, -- 左右ブランク
        trim(ktsiyoubui, ' 　')::varchar(10) as ktsiyoubui, -- 左右ブランク
        trim(ktoyahin, ' 　')::varchar(10) as ktoyahin, -- 左右ブランク
        trim(ktgc, ' 　')::varchar(2) as ktgc, -- 左右ブランク
        trim(jigyoutai, ' 　')::varchar(2) as jigyoutai, -- 左右ブランク
        trim(tokuyukote, ' 　')::varchar(1) as tokuyukote, -- 左右ブランク
        trim(hosyukote1, ' 　')::varchar(6) as hosyukote1, -- 左右ブランク
        trim(hosyukote2, ' 　')::varchar(6) as hosyukote2, -- 左右ブランク
        trim(hosyukote3, ' 　')::varchar(6) as hosyukote3, -- 左右ブランク
        trim(hosyukote4, ' 　')::varchar(6) as hosyukote4, -- 左右ブランク
        trim(hosyukote5, ' 　')::varchar(6) as hosyukote5, -- 左右ブランク
        trim(hosyukote6, ' 　')::varchar(6) as hosyukote6, -- 左右ブランク
        trim(hosyukote7, ' 　')::varchar(6) as hosyukote7, -- 左右ブランク
        trim(hosyukote8, ' 　')::varchar(6) as hosyukote8, -- 左右ブランク
        trim(hosyukote9, ' 　')::varchar(6) as hosyukote9, -- 左右ブランク
        trim(hosyukote10, ' 　')::varchar(6) as hosyukote10, -- 左右ブランク
        trim(hosyukote11, ' 　')::varchar(6) as hosyukote11, -- 左右ブランク
        trim(hosyukote12, ' 　')::varchar(6) as hosyukote12, -- 左右ブランク
        trim(hosyukote13, ' 　')::varchar(6) as hosyukote13, -- 左右ブランク
        trim(hosyukote14, ' 　')::varchar(6) as hosyukote14, -- 左右ブランク
        trim(hosyubas, ' 　')::varchar(6) as hosyubas, -- 左右ブランク
        trim(tosobas, ' 　')::varchar(6) as tosobas, -- 左右ブランク
        trim(boubas, ' 　')::varchar(6) as boubas, -- 左右ブランク
        trim(tekikara, ' 　')::varchar(8) as tekikara, -- 左右ブランク
        trim(tekimade, ' 　')::varchar(8) as tekimade, -- 左右ブランク
        trim(mukoflg, ' 　')::varchar(1) as mukoflg, -- 左右ブランク
        trim(genkyu, ' 　')::varchar(1) as genkyu, -- 左右ブランク
        trim(hoseikbn, ' 　')::varchar(1) as hoseikbn, -- 左右ブランク
        trim(torokud, ' 　')::varchar(8) as torokud, -- 左右ブランク
        trim(torokut, ' 　')::varchar(6) as torokut, -- 左右ブランク
        trim(kosind, ' 　')::varchar(8) as kosind, -- 左右ブランク
        trim(kosint, ' 　')::varchar(6) as kosint, -- 左右ブランク
        trim(kosinsya, ' 　')::varchar(16) as kosinsya, --　左右ブランク
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_hokyu_sms_dxpfy2d', 'raw_cvg03hosyukka') }}
    where _fivetran_deleted = 'false'
)

select * from stg_hokyusyukkabasyo_smshokyu