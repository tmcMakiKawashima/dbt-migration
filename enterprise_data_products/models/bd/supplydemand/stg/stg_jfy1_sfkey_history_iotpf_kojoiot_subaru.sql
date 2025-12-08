{{
    config (
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = ['sfkey']
        
    )
}}

with stg_jfy1_sfkey_history_iotpf_kojoiot_subaru as (
    select
        trim(sf_kind, ' 　')::numeric(1) as sf_kind,  -- 右左ブランク
        trim(sfkey, ' 　')::varchar(16) as sfkey,  -- 右左ブランク
        trim(modtype, ' 　')::varchar(2) as modtype,  -- 右左ブランク
        trim(ref_sfkey, ' 　')::varchar(16) as ref_sfkey,  -- 右左ブランク
        trim(parent_sfkey, ' 　')::varchar(16) as parent_sfkey,  -- 右左ブランク
        trim(family_sfkey, ' 　')::varchar(16) as family_sfkey,  -- 右左ブランク
        trim(modno, ' 　')::varchar(8) as modno,  -- 右左ブランク
        trim(idno, ' 　')::varchar(10) as idno,  -- 右左ブランク
        trim(bdno, ' 　')::varchar(5) as bdno,  -- 右左ブランク
        trim(fr_code, ' 　')::varchar(3) as fr_code,  -- 右左ブランク
        trim(fr_seq, ' 　')::varchar(7) as fr_seq,  -- 右左ブランク
        trim(urn, ' 　')::varchar(10) as urn,  -- 右左ブランク
        trim(carrierno, ' 　')::varchar(10) as carrierno,  -- 右左ブランク
        trim(vinno, ' 　')::varchar(17) as vinno,  -- 右左ブランク
        trim(mod_serial_no, ' 　')::varchar(30) as mod_serial_no,  -- 右左ブランク
        try_to_timestamp_ntz(trim(__created_at, ' 　'))::timestamp_ntz(6) as __created_at,  -- 右左ブランク
        try_to_timestamp_ntz(trim(__updated_at, ' 　'))::timestamp_ntz(6) as __updated_at,  -- 右左ブランク
        ldts,  -- B層のldts
        row_number() over (
            partition by
                sfkey
            order by
                ldts desc,
                line_number desc
        ) aggkey
     from {{ ref('extract_iotalcjfy1g4sfk') }}

    {% if is_incremental() %}
        where ldts > (select coalesce(max(ldts), '1970-01-01 00:00:00.000') from {{ this }})
    {% endif %}

)
select * exclude(aggkey)
from stg_jfy1_sfkey_history_iotpf_kojoiot_subaru
where aggkey = 1