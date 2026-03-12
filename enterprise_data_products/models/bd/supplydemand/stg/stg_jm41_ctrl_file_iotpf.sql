{{
    config (
        materialized = 'incremental',
        unique_key = ['sfkey'],
        incremental_strategy = 'merge' 
    )
}}

with stg_jm41_ctrl_file_iotpf as (
    select
        trim(sfkey, ' 　')::varchar(16) as sfkey,  -- 右左ブランク
        to_timestamp_ntz(trim(file_date, ' 　')) as file_date,  -- 右左ブランク
        trim(timezone, ' 　')::varchar(16777216) as timezone,  -- 右左ブランク
        trim(alc_ver, ' 　')::varchar(16777216) as alc_ver,  -- 右左ブランク
        to_timestamp_ntz(trim(db_reg_date, ' 　'))::timestamp_ntz(6) as db_reg_date,  -- 右左ブランク
        to_timestamp_ntz(trim(db_upd_date, ' 　'))::timestamp_ntz(6) as db_upd_date,  -- 右左ブランク
        to_timestamp_ntz(trim(__created_at, ' 　'))::timestamp_ntz(6) as __created_at,  -- 右左ブランク
        to_timestamp_ntz(trim(__updated_at, ' 　'))::timestamp_ntz(6) as __updated_at,  -- 右左ブランク
        ldts,  -- B層のldts
        row_number() over (
                partition by
                    sfkey
                order by
                    ldts desc,line_number desc
        ) aggkey
    from {{ ref('extract_iotalcjm41g4ctr') }}

    {% if is_incremental() %}
        where ldts > (select coalesce(max(ldts), '1970-01-01 00:00:00.000') from {{ this }})
    {% endif %}

)
select * exclude(aggkey) from stg_jm41_ctrl_file_iotpf
where aggkey = 1