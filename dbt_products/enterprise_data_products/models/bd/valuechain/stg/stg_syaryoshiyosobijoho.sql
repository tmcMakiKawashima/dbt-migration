with stg_syaryoshiyosobijoho as (
    select
        mntkbn::varchar(1) as mntkbn, 
        langkbn::varchar(3) as langkbn, 
        syasyu::varchar(4) as syasyu, 
        siyoptno::varchar(4) as siyoptno, 
        siyocd::varchar(4) as siyocd, 
        dispseq::varchar(3) as dispseq, 
        rtrim(siyodaibnrmei,' 　')::varchar(320) as siyodaibnrmei, -- 右blank
        rtrim(siyosaimokumei,' 　')::varchar(320) as siyosaimokumei, -- 右blank 
        ldts, --B層取込日時
        line_number,
        rank() over (partition by langkbn, syasyu, siyoptno, siyocd order by ldts desc, line_number desc) aggkey
    from {{ source('snowpipe_db_valuechain', 'raw_dv2a5717') }}
)
select * exclude(aggkey, line_number, mntkbn)
from stg_syaryoshiyosobijoho
where aggkey = 1 and mntkbn in ('C', 'U')