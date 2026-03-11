with stg_jigyoutai_koumusms as (
    select
        jigyoutaicd::varchar(2) as jigyoutaicd,
        kouku::varchar(1) as kouku,
        koukumei::varchar(20) as koukumei,
        nmaker::varchar(5) as nmaker,
        nkoku::varchar(1) as nkoku,
        sakuseitime::varchar(16) as sakuseitime,
        kousintime::varchar(16) as kousintime,
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_oraclerds_lzdata01_sms_dxpfy2d', 'raw_cb414jigyoutai') }}
    where _fivetran_deleted = 'false'
)
select *
from stg_jigyoutai_koumusms