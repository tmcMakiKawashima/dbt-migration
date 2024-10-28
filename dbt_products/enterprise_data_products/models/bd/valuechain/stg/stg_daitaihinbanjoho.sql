with stg_daitaihinbanjoho as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(hinban,' 　')::varchar(12) as hinban, -- 右blank
        rtrim(hnbtikicd,' 　')::varchar(5) as hnbtikicd, -- 右blank
        rtrim(dthin,' 　')::varchar(12) as dthin, -- 右blank
        dtkosu::varchar(2) as dtkosu, 
        dthintkdate::varchar(8) as dthintkdate, 
        dttype::varchar(2) as dttype, 
        mainflg::varchar(1) as mainflg, 
        ldts, --B層取込日時
        line_number,
        rank() over (partition by hinban, hnbtikicd, dthin order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_dv2a4763') }}
)
select * exclude(aggkey, line_number, mntkbn)
from stg_daitaihinbanjoho
where aggkey = 1 and mntkbn in ('C', 'U')