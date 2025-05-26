with stg_cubc001key_vlc as (
    select
        vhc_key::varchar(15) as vhc_key, 
        idno::varchar(10) as idno, 
        prdct_year::varchar(4) as prdct_year, 
        prdct_country_cd::varchar(3) as prdct_country_cd, 
        urn::varchar(10) as urn, 
        hbtcd_orderno::varchar(17) as hbtcd_orderno, 
        order_acpt_date::varchar(8) as order_acpt_date, 
        lrn::varchar(40) as lrn, 
        lrn_country_cd::varchar(3) as lrn_country_cd, 
        vin::varchar(17) as vin, 
        frame_vis::varchar(11) as frame_vis, 
        edds::varchar(10) as edds, 
        syadaino::varchar(14) as syadaino, 
        vhc_yuko_kbn::varchar(1) as vhc_yuko_kbn, 
        inst_datetime, 
        inst_id::varchar(20) as inst_id, 
        upd_datetime, 
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc001key') }}
    where _fivetran_deleted = 'false'
)
select * from stg_cubc001key_vlc