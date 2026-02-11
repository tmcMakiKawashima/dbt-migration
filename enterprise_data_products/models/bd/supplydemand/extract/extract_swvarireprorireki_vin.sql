with extract_swvarireprorireki_vin as (
    select
        raw_data:event_name::varchar(6) as event_name,
        raw_data:event_time::varchar(9) as event_time,
        raw_data:vin::varchar(17) as vin,
        raw_data:compositekey1::varchar(16) as compositekey1,       
        raw_data:rireki_renban::numeric(5) as rireki_renban,
        raw_data:sw_vari_id::varchar(10) as sw_vari_id,
        raw_data:sw_vari_ver::varchar(3) as sw_vari_ver,
        raw_data:write_kbn::varchar(1) as write_kbn,
        raw_data:write_means::varchar(1) as write_means,
        raw_data:write_code::varchar(5) as write_code,
        raw_data:local_write_time::varchar(15) as local_write_time,
        raw_data:su_ninsho_irai_no::varchar(12) as su_ninsho_irai_no,
        raw_data:sys_toroku_datetime::varchar(15) as sys_toroku_datetime,
        raw_data:sys_toroku_aplid::varchar(30) as sys_toroku_aplid,
        raw_data:sys_koshin_datetime::varchar(15) as sys_koshin_datetime,
        raw_data:sys_koshin_aplid::varchar(30) as sys_koshin_aplid,
        ldts,
        line_number
    from
        {{ source('snowpipe_db_supplydemand', 'raw_swvarireprorireki_vin') }}
    )
select * from extract_swvarireprorireki_vin