{{
    config (
        materialized = 'incremental',
        unique_key = ['vin','compositekey1'],
        incremental_strategy = 'merge',
        post_hook ="
            update {{ this }} as t
            set t.delflg = true, t.ldts = current_timestamp
            from (
            select vin,compositekey1,event_name,
              row_number() over (
                partition by
                    vin,
                    compositekey1
                order by
                    ldts desc,
                    event_time desc,
                    line_number desc
            ) aggkey 
            from {{ ref('extract_swvarireprorireki_vin') }}
            where ldts > dateadd(hour, -12, current_timestamp())
            ) as s
              where t.vin = s.vin
              and t.compositekey1 = s.compositekey1
              and s.aggkey = 1
              and s.event_name = 'DELETE'
        "
    )
}}
--event_name:deleteで連携されてきたデータを論理削除する
with stg_swvarireprorireki_vin_aisac as (
    select
        vin::varchar(17) as vin,
        compositekey1::varchar(16) as compositekey1,
        rireki_renban::numeric(5) as rireki_renban,
        sw_vari_id::varchar(10) as sw_vari_id,
        sw_vari_ver::varchar(3) as sw_vari_ver,
        write_kbn::varchar(1) as write_kbn,
        write_means::varchar(1) as write_means,
        write_code::varchar(5) as write_code,
        local_write_time::varchar(15) as local_write_time,
        su_ninsho_irai_no::varchar(12) as su_ninsho_irai_no,
        sys_toroku_datetime::varchar(15) as sys_toroku_datetime,
        sys_toroku_aplid::varchar(30) as sys_toroku_aplid,
        sys_koshin_datetime::varchar(15) as sys_koshin_datetime,
        sys_koshin_aplid::varchar(30) as sys_koshin_aplid,
        false::boolean as delflg,
        ldts,  -- B層のldts
        row_number() over (
            partition by
                vin,
                compositekey1
            order by
                ldts desc,
                event_time desc,
                line_number desc
        ) aggkey
    from {{ ref('extract_swvarireprorireki_vin') }}
    where (event_name = 'INSERT' or event_name = 'UPDATE')

    {% if is_incremental() %}
        and ldts > (select coalesce(max(ldts), '1970-01-01 00:00:00.000') from {{ this }})
    {% endif %}

)
select * exclude(aggkey)
from stg_swvarireprorireki_vin_aisac
where aggkey = 1