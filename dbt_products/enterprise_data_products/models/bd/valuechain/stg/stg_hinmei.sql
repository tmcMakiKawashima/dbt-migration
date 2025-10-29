with stg_hinmei as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(langkbn,' 　')::varchar(3) as langkbn, -- 右blank
        rtrim(pnc,' 　')::varchar(6) as pnc, -- 右blank
        rtrim(hinmei,' 　')::varchar(240) as hinmei, -- 右blank 全角文字を含む
        ldts, --B層取込日時
        line_number,
        rank() over (partition by langkbn, pnc order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_dv2a4703') }}
)
select * exclude(aggkey, line_number, mntkbn)
from stg_hinmei
where aggkey = 1 and mntkbn in ('C', 'U')