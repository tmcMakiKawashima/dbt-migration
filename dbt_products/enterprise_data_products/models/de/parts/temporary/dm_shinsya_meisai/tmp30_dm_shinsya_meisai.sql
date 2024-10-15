{{ config(snowflake_warehouse='DBT_WH') }}

with temp20 as (
    select
        *
    from {{ref('tmp20_dm_shinsya_meisai')}}
    where rnk = 1
),
stg_yohinhinban as (
    select * from {{ref('stg_yohinhinban')}}
)
select
    temp20.* exclude(dlrcd,cuno, ym),
    yohinhinban.jkeidd,
    yohinhinban.hanbkjdd,
    yohinhinban.dlrcd as check_dlrcd -- 販売店コード nullチェック用
from temp20
left outer join stg_yohinhinban as yohinhinban on
        temp20.dlrcd = yohinhinban.dlrcd
    and temp20.cuno = yohinhinban.cuno
    and temp20.ym = yohinhinban.ym