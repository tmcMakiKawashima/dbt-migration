with stg_figmeisyo as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(langkbn,' 　')::varchar(3) as langkbn, -- 右blank
        rtrim(figno,' 　')::varchar(4) as figno, -- 右blank
        rtrim(figmei,' 　')::varchar(240) as figmei, -- 右blank
        ldts, --B層取込日時
        line_number,
        rank() over (partition by langkbn, figno order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_dv2a4723') }}
)
select * exclude(aggkey, line_number, mntkbn)
from stg_figmeisyo
where aggkey = 1 and mntkbn in ('C', 'U')