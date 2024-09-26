{{ 
  config(
    materialized='incremental',
    unique_key = ['settle_date_y','settle_date_m','dealer_code','twc_no','frmkbn','frmno','wmi','vds','vis','seq_no_parts'],
    incremental_strategy = 'merge'
  )
 }}                                                                                               -- ① incrementalを指定

with stg_warranty_koukanhinban as (
    select
        settle_date_y::varchar(4) as settle_date_y, --なし
        settle_date_m::varchar(2) as settle_date_m, --なし
        dealer_code::varchar(5) as dealer_code, --なし
        twc_no::varchar(9) as twc_no, --なし
        frame_cls::varchar(6) as frmkbn, --なし
        frame_no::varchar(7) as frmno, --なし
        vin_wmi::varchar(3) as wmi, --なし
        vin_vds::varchar(6) as vds, --なし
        vin_vis::varchar(8) as vis, --なし
        seq_no_parts::varchar(3) as seq_no_parts, --なし
        repl_part_no::varchar(15) as repl_part_no, --なし
        repl_part_no_cnt::number(3) as repl_part_no_cnt, --なし
        repl_part_no_dn::number(9) as repl_part_no_dn, --なし
        local_flg::varchar(1) as local_flg, --なし
        mtuser::varchar(18) as mtuser, --なし
        mttime::timestamp_ntz as mttime, --timestamp型
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_oraclerds_orcl_iqas_osepcs0000db20', 'raw_cep0004parts') }}
     where _fivetran_deleted = 'false'

{% if is_incremental() %}                                                                                                              -- ② 増分の取り方を指定
    and _fivetran_synced > (select max(ldts) from {{this}})
{% endif %}

)
select * from stg_warranty_koukanhinban