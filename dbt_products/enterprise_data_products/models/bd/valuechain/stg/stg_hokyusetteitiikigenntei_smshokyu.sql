with stg_hokyusetteitiikigenntei_smshokyu as (
    select
        trim(syasyu, ' 　')::varchar(4) as syasyu,  -- 右左ブランク
        trim(kumitate, ' 　')::varchar(4) as kumitate,  -- 右左ブランク
        trim(bui, ' 　')::varchar(2) as bui,  -- 右左ブランク
        trim(vari, ' 　')::varchar(2) as vari,  -- 右左ブランク
        trim(oyahin, ' 　')::varchar(10) as oyahin,  -- 右左ブランク
        trim(gc, ' 　')::varchar(2) as gc,
        trim(kohin, ' 　')::varchar(10) as kohin,  -- 右左ブランク
        sepjunk::varchar(9) as sepjunk,
        trim(gentetiki, ' 　')::varchar(20) as gentetiki,  -- 右左ブランク
        sepjunm::varchar(9) as sepjunm,  -- 右左ブランク
        trim(hikihokbn, ' 　')::varchar(2) as hikihokbn,  -- 右左ブランク
        trim(tekikara, ' 　')::varchar(8) as tekikara,  -- 右左ブランク
        trim(tekimade, ' 　')::varchar(8) as tekimade,  -- 右左ブランク
        trim(gentekbn, ' 　')::varchar(1) as gentekbn,  -- 右左ブランク
        trim(torokud, ' 　')::varchar(8) as torokud,  -- 右左ブランク
        trim(torokut, ' 　')::varchar(6) as torokut,  -- 右左ブランク
        trim(kosind, ' 　')::varchar(8) as kosind,  -- 右左ブランク
        trim(kosint, ' 　')::varchar(6) as kosint,  -- 右左ブランク
        trim(kosinsya, ' 　')::varchar(16) as kosinsya,  -- 右左ブランク
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_idr_hokyu_sms_dxpfy2d', 'raw_cvf03hosetugen') }}
    where _fivetran_deleted = 'false'
)
select *
from stg_hokyusetteitiikigenntei_smshokyu