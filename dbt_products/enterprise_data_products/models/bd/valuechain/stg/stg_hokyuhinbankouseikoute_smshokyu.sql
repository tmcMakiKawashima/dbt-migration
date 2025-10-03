with stg_hokyuhinbankouseikoute_smshokyu as (
    select
        trim(syusbetu, ' 　')::varchar(4) as syusbetu,  -- 右左ブランク
        trim(syutuhin, ' 　')::varchar(10) as syutuhin,  -- 右左ブランク
        trim(kyokucd, ' 　')::varchar(3) as kyokucd,  -- 右左ブランク
        trim(oyahin, ' 　')::varchar(10) as oyahin,  -- 右左ブランク
        trim(kohin, ' 　')::varchar(10) as kohin,  -- 右左ブランク
        trim(jikt1, ' 　')::varchar(6) as jikt1,  -- 右左ブランク
        trim(jikt2, ' 　')::varchar(6) as jikt2,  -- 右左ブランク
        trim(jikt3, ' 　')::varchar(6) as jikt3,  -- 右左ブランク
        trim(jikt4, ' 　')::varchar(6) as jikt4,  -- 右左ブランク
        trim(jikt5, ' 　')::varchar(6) as jikt5,  -- 右左ブランク
        trim(jikt6, ' 　')::varchar(6) as jikt6,  -- 右左ブランク
        trim(jikt7, ' 　')::varchar(6) as jikt7,  -- 右左ブランク
        trim(jikt8, ' 　')::varchar(6) as jikt8,  -- 右左ブランク
        trim(jikt9, ' 　')::varchar(6) as jikt9,  -- 右左ブランク
        trim(jikt10, ' 　')::varchar(6) as jikt10,  -- 右左ブランク
        trim(jikt11, ' 　')::varchar(6) as jikt11,  -- 右左ブランク
        trim(jikt12, ' 　')::varchar(6) as jikt12,  -- 右左ブランク
        trim(jikt13, ' 　')::varchar(6) as jikt13,  -- 右左ブランク
        trim(jikt14, ' 　')::varchar(6) as jikt14,  -- 右左ブランク
        trim(oyakt, ' 　')::varchar(6) as oyakt,  -- 右左ブランク
        trim(sepjunk, ' 　')::varchar(9) as sepjunk,  -- 右左ブランク
        trim(sepjunm, ' 　')::varchar(9) as sepjunm,  -- 右左ブランク
        trim(kosu, ' 　')::varchar(3) as kosu,  -- 右左ブランク
        trim(sentaku, ' 　')::varchar(2) as sentaku,  -- 右左ブランク
        trim(ktkbn, ' 　')::varchar(2) as ktkbn,  -- 右左ブランク
        trim(ktchk, ' 　')::varchar(1) as ktchk,  -- 右左ブランク
        trim(ktkosu, ' 　')::varchar(2) as ktkosu,  -- 右左ブランク
        trim(tekikara, ' 　')::varchar(8) as tekikara,  -- 右左ブランク
        trim(tekimade, ' 　')::varchar(8) as tekimade,  -- 右左ブランク
        trim(torokud, ' 　')::varchar(8) as torokud,  -- 右左ブランク
        trim(torokut, ' 　')::varchar(6) as torokut,  -- 右左ブランク
        trim(kosind, ' 　')::varchar(8) as kosind,  -- 右左ブランク
        trim(kosint, ' 　')::varchar(6) as kosint,  -- 右左ブランク
        trim(kosinsya, ' 　')::varchar(16) as kosinsya,  -- 右左ブランク
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_idr_hokyu_sms_dxpfy2d', 'raw_cvf21kyugata') }}
    where _fivetran_deleted = 'false'    )
select *
from stg_hokyuhinbankouseikoute_smshokyu