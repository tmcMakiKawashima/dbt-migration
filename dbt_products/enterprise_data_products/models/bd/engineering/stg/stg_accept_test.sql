{{ config(
       materialized ='incremental',
       unique_key = ['accept_test_id'],
       incremental_strategy = 'merge'
  ) }}

with stg_accept_test as (
    select
        accept_test_id::number(10,0) as accept_test_id,
        delivery_id::number(10,0) as delivery_id,
        count::number(10,0) as count,
        accept_id::number(10,0) as accept_id, 
        judge_user_flg::number(10,0) as judge_user_flg,
        created_at::timestamp_ntz(6) as created_at,
        updated_at::timestamp_ntz(6) as updated_at,
        ldts,
        row_number() over(partition by accept_test_id order by updated_at desc, line_number desc) aggkey
    from {{source('snowpipe_db_engineering', 'raw_ktrea0g7zz0kqe0001') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{this}})
    {% endif %}

)
select * exclude(aggkey) from stg_accept_test
where aggkey = 1 