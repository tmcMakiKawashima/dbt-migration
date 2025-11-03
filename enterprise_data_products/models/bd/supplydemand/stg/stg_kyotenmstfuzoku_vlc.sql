with stg_kyotenmstfuzoku_vlc as (
    select
        kyoten_cd::varchar(20) as kyoten_cd, 
        tkiy_k::varchar(12) as tkiy_k, 
        tkiy_m::varchar(12) as tkiy_m, 
        kyotenarea_cd::varchar(3) as kyotenarea_cd, 
        ido::varchar(9) as ido, 
        keido::varchar(10) as keido, 
        inst_datetime::timestamp_ntz(9) as inst_datetime,
        inst_id::varchar(20) as inst_id, 
        upd_datetime::timestamp_ntz(9) as upd_datetime,
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc130kyotenattach') }}
    where _fivetran_deleted = 'false'
)
select * from stg_kyotenmstfuzoku_vlc