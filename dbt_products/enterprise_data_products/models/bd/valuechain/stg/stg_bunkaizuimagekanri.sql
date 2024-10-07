with stg_bunkaizuimagekanri as (
    select
        mntkbn::varchar(1) as mntkbn, 
        hansno::varchar(7) as hansno, 
        rtrim(bnkimgflmei,' 　')::varchar(8) as bnkimgflmei, -- 右blank
        ldts, --B層取込日時
        rank() over (partition by hansno order by ldts desc) aggkey
    from {{ ref('substr_dv2a5544') }}
)
select * exclude(aggkey, mntkbn)
from stg_bunkaizuimagekanri
where aggkey = 1 and mntkbn = 'C'
