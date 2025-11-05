with stg_disp_partnm10_iqas as (
    select
        table_data_id::varchar(300) as table_data_id,
        table_data_seq::number(5, 0) as table_data_seq,
        value_ja::varchar(900) as value_ja,
        value_en::varchar(900) as value_en,
        value_zh::varchar(900) as value_zh,
        parent_table_data_id::varchar(100) as parent_table_data_id,
        value_search::varchar(3000) as value_search,
        search_flag::number(1, 0) as search_flag,
        sort_order_ja::varchar(300) as sort_order_ja,
        sort_order_en::varchar(300) as sort_order_en,
        sort_order_zh::varchar(300) as sort_order_zh,
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_oraclerds_orcl_iqas_osepcs0000db20', 'raw_cep3323disp_partnm10') }}
    where _fivetran_deleted = 'false'    )
select *
from stg_disp_partnm10_iqas