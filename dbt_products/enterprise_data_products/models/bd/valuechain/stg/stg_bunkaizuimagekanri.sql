with stg_bunkaizuimagekanri as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(hansno,' 　')::varchar(7) as hansno, -- 右blank
        bnkimgflmei::varchar(8) as bnkimgflmei,
        ldts, --B層取込日時
        line_number,
        rank() over (partition by hansno order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_dv2a5544') }}
)
select * exclude(aggkey, line_number, mntkbn)
from stg_bunkaizuimagekanri
where aggkey = 1 and mntkbn = 'C'
