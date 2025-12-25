{{
    config (
        materialized = 'incremental',
        incremental_strategy = 'append',
        pre_hook = "
            {% if is_incremental() %}
              delete from {{ this }} as t
              using {{ ref('extract_iotalcjfy1g4sfh') }} as s
              where t.sfkey = s.sfkey
            {% endif %}    
        "
    )
}}
--主キーとは異なるsfkey単位で削除したいためhookで実装

with stg_jfy1_sfh_history_iotpf as (
    select
        trim(sfkey, ' 　')::varchar(16) as sfkey,  -- 右左ブランク
        trim(line, ' 　')::varchar(1) as line,  -- 右左ブランク
        trim(tp, ' 　')::varchar(2) as tp,  -- 右左ブランク
        trim(keycount, ' 　')::varchar(1) as keycount,  -- 右左ブランク
        trim(addcnt, ' 　')::number(4, 0) as addcnt,  -- 右左ブランク
        trim(bcseq, ' 　')::varchar(3) as bcseq,  -- 右左ブランク
        trim(count, ' 　')::varchar(1) as count,  -- 右左ブランク
        trim(pdate, ' 　')::varchar(15) as pdate,  -- 右左ブランク
        trim(cdate, ' 　')::varchar(14) as cdate,  -- 右左ブランク
        trim(dlytime, ' 　')::varchar(7) as dlytime,  -- 右左ブランク
        trim(spr_tp, ' 　')::varchar(7) as spr_tp,  -- 右左ブランク
        trim(spr_byo, ' 　')::varchar(7) as spr_byo,  -- 右左ブランク
        trim(spr_deli, ' 　')::varchar(7) as spr_deli,  -- 右左ブランク
        trim(ltresult, ' 　')::varchar(7) as ltresult,  -- 右左ブランク
        trim(ltresult_bs, ' 　')::varchar(7) as ltresult_bs,  -- 右左ブランク
        trim(result_seq, ' 　')::varchar(8) as result_seq,  -- 右左ブランク
        to_timestamp_ntz(trim(__created_at, ' 　'))::timestamp_ntz(6) as __created_at,  -- 右左ブランク
        to_timestamp_ntz(trim(__updated_at, ' 　'))::timestamp_ntz(6) as __updated_at,  -- 右左ブランク
        ldts,  -- b層のldts
        row_number() over (
            partition by
                sfkey,
                line,
                tp,
                keycount
            order by
                ldts desc,
                line_number desc
        ) aggkey
    from {{ ref('extract_iotalcjfy1g4sfh') }}

    {% if is_incremental() %}
        where ldts > (select coalesce(max(ldts), '1970-01-01 00:00:00.000') from {{ this }})
    {% endif %}

)
select * exclude(aggkey)
from stg_jfy1_sfh_history_iotpf
where aggkey = 1