with stg_zissiziki_smshokyu as (
    select
        trim(syasyu32, ' 　')::varchar(2) as syasyu32,  -- 右左ブランク
        trim(syasyu, ' 　')::varchar(4) as syasyu,  -- 右左ブランク
        trim(kumitate, ' 　')::varchar(4) as kumitate,  -- 右左ブランク
        trim(bui, ' 　')::varchar(2) as bui,  -- 右左ブランク
        trim(kata, ' 　')::varchar(20) as kata,  -- 右左ブランク
        trim(sochaku, ' 　')::varchar(1) as sochaku,  -- 右左ブランク
        trim(vari, ' 　')::varchar(2) as vari,  -- 右左ブランク
        sepnok::varchar(10) as sepnok,
        sepnom::varchar(10) as sepnom,
        trim(tekikara, ' 　')::varchar(8) as tekikara,  -- 右左ブランク
        trim(tekimade, ' 　')::varchar(8) as tekimade,  -- 右左ブランク
        trim(ecikbn, ' 　')::varchar(3) as ecikbn,  -- 右左ブランク
        trim(torokud, ' 　')::varchar(8) as torokud,  -- 右左ブランク
        trim(torokut, ' 　')::varchar(6) as torokut,  -- 右左ブランク
        trim(kosind, ' 　')::varchar(8) as kosind,  -- 右左ブランク
        trim(kosint, ' 　')::varchar(6) as kosint,  -- 右左ブランク
        trim(kosinsya, ' 　')::varchar(16) as kosinsya,  -- 右左ブランク
        trim(hikisiyo, ' 　')::varchar(200) as hikisiyo,  -- 右左ブランク
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_idr_hokyu_sms_dxpfy2d', 'raw_cvf03jikimoku') }}
    where _fivetran_deleted = 'false'
)
select *
from stg_zissiziki_smshokyu