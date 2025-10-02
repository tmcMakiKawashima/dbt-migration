with stg_tikibetsuhokyutyotatsujoho_smshokyu as(
    select
        trim(hinban, ' 　')::varchar(10) as hinban, -- 左右ブランク
        trim(ruibetu, ' 　')::varchar(2) as ruibetu, -- 左右ブランク
        trim(syaryoszoco, ' 　')::varchar(4) as syaryoszoco, -- 左右ブランク
        trim(dounyutiikicd, ' 　')::varchar(3) as dounyutiikicd, -- 左右ブランク
        trim(kerekijun, ' 　')::varchar(5) as kerekijun, -- 左右ブランク
        trim(seisankyoku, ' 　')::varchar(3) as seisankyoku, -- 左右ブランク
        trim(hokyuyouhi, ' 　')::varchar(1) as hokyuyouhi, -- 左右ブランク
        trim(hokyuyouhik, ' 　')::varchar(8) as hokyuyouhik, -- 左右ブランク
        trim(hokyuyouhim, ' 　')::varchar(8) as hokyuyouhim, -- 左右ブランク
        trim(sepjunk, ' 　')::varchar(10) as sepjunk, -- 左右ブランク
        trim(sepjunm, ' 　')::varchar(10) as sepjunm, -- 左右ブランク
        trim(daitaiflg, ' 　')::varchar(1) as daitaiflg, -- 左右ブランク
        trim(taiouflg, ' 　')::varchar(1) as taiouflg, -- 左右ブランク
        trim(mukoflg, ' 　')::varchar(1) as mukoflg, -- 左右ブランク
        trim(mflg, ' 　')::varchar(2) as mflg, -- 左右ブランク
        trim(torokud, ' 　')::varchar(8) as torokud, -- 左右ブランク
        trim(torokut, ' 　')::varchar(6) as torokut, -- 左右ブランク
        trim(kosind, ' 　')::varchar(8) as kosind, -- 左右ブランク
        trim(kosint, ' 　')::varchar(6) as kosint, -- 左右ブランク
        trim(kosinsya, ' 　')::varchar(16) as kosinsya, -- 左右ブランク
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_hokyu_sms_dxpfy2d', 'raw_cvh02tikihokyu' )}}
    where _fivetran_deleted = 'false'
)

select * from stg_tikibetsuhokyutyotatsujoho_smshokyu