with stg_syamei as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(ctlgcd,' 　')::varchar(6) as ctlgcd, -- 右blank
        syamei::varchar(30) as syamei, 
        syameizen::varchar(120) as syameizen, 
        syameizenkana::varchar(120) as syameizenkana, 
        daikata::varchar(50) as daikata, 
        seisank::varchar(6) as seisank, 
        seisanm::varchar(6) as seisanm, 
        lexusflg::varchar(1) as lexusflg, 
        prts1kbn::varchar(1) as prts1kbn, 
        tksyuflg::varchar(1) as tksyuflg, 
        ldts, --B層取込日時
        line_number,
        rank() over (partition by ctlgcd order by ldts desc, line_number desc) aggkey
    from {{ source('snowpipe_db_valuechain', 'raw_dv2a4745') }}
)
select * exclude(aggkey, line_number, mntkbn)
from stg_syamei
where aggkey = 1 and mntkbn in ('C', 'U')