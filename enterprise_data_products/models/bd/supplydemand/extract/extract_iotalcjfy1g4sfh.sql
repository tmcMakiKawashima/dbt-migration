with extract_jfy1g4_t_sfh_history as (
    select
        raw_data:sfkey::varchar(4) as sfkey,
        raw_data:line::varchar(4) as line,
        raw_data:tp::varchar(4) as tp,
        raw_data:keycount::varchar(4) as keycount,
        raw_data:addcnt::varchar(4) as addcnt,
        raw_data:bcseq::varchar(3) as bcseq,
        raw_data:count::varchar(1) as count,
        raw_data:pdate::varchar(15) as pdate,
        raw_data:cdate::varchar(14) as cdate,
        raw_data:dlytime::varchar(7) as dlytime,
        raw_data:spr_tp::varchar(7) as spr_tp,
        raw_data:spr_byo::varchar(7) as spr_byo,
        raw_data:spr_deli::varchar(7) as spr_deli,
        raw_data:ltresult::varchar(7) as ltresult,
        raw_data:ltresult_bs::varchar(7) as ltresult_bs,
        raw_data:result_seq::varchar(8) as result_seq,
        raw_data:__created_at::timestamp_ntz(6) as __created_at,
        raw_data:__updated_at::timestamp_ntz(6) as __updated_at,
        ldts,
        line_number
    from
        {{ source('snowpipe_db_supplydemand', 'raw_iotalcjfy1g4sfh') }}
    )
select * from extract_jfy1g4_t_sfh_history