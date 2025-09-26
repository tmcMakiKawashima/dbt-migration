{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'append',
        transient = false,
        pre_hook = "
            {% if is_incremental() %}
                delete from {{this}} a
                using (
                    select distinct 
                        syasyu,
                        kumitate,
                        bui
                    from {{ ref('tmp08_dm_kousei_jyufukublktenkai')}}) b
                where a.syasyu = b.syasyu
                  and a.kumitate = b.kumitate
                  and a.bui = b.bui;
            {% endif %}
        "
    )
}}
--車種,組立番号,部位の単位で置き換える

select * exclude(target, torokujun, seppenno, maxmttime,mttime),
current_timestamp() AS ldts
from {{ ref('tmp08_dm_kousei_jyufukublktenkai')}}