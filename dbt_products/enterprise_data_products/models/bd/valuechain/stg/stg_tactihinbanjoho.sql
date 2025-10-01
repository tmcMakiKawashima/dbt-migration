with stg_tactihinbanjoho as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(toyotahin,' 　')::varchar(14) as toyotahin, -- 右blank
        rtrim(siirecd,' 　')::varchar(5) as siirecd, -- 右blank
        rtrim(rentacti,' 　')::varchar(1) as rentacti, -- 右blank
        rectype::varchar(1) as rectype, 
        tactihin::varchar(14) as tactihin, 
        sikitacti::varchar(6) as sikitacti, 
        syukitacti::varchar(6) as syukitacti, 
        taiokosu::varchar(2) as taiokosu, 
        buhinmkmei::varchar(40) as buhinmkmei, 
        tkkatatacti::varchar(204) as tkkatatacti, 
        hinmeitacti::varchar(240) as hinmeitacti, 
        sankoprice::varchar(7) as sankoprice, 
        updid::varchar(19) as updid, 
        updtime, -- timestamp
        ldts, --B層取込日時
        line_number,
        rank() over (partition by toyotahin, siirecd, rentacti order by ldts desc, line_number desc) aggkey
    from {{ source('snowpipe_db_valuechain', 'raw_dv2b0205') }}
)
select * exclude(aggkey, line_number, mntkbn)
from stg_tactihinbanjoho
where aggkey = 1 and mntkbn in ('C', 'U')