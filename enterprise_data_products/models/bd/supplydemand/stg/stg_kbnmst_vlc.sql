with stg_kbnmst_vlc as (
    select
        kbn::varchar(2) as kbn, 
        cd::varchar(2) as cd, 
        lang_cd::varchar(2) as lang_cd, 
        field::varchar(60) as field, 
        disp_seq::varchar(2) as disp_seq, 
        inst_datetime::timestamp_ntz(9) as inst_datetime,
        inst_id::varchar(20) as inst_id, 
        upd_datetime::timestamp_ntz(9) as upd_datetime,
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc111kbn') }}
    where _fivetran_deleted = 'false'
)
select * from stg_kbnmst_vlc