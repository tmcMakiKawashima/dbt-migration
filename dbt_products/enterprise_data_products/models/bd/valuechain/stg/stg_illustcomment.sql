with stg_illustcomment as (
    select
        mntkbn::varchar(1) as mntkbn, 
        langkbn::varchar(3) as langkbn, 
        ilstcmtno::varchar(5) as ilstcmtno, 
        rtrim(ilstcmt,' 　')::varchar(140) as ilstcmt,  -- 右blank
        ldts, --B層取込日時
        line_number,
        rank() over (partition by langkbn, ilstcmtno order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_dv2a5803') }}
)
select * exclude(aggkey, line_number, mntkbn)
from stg_illustcomment
where aggkey = 1 and mntkbn in ('C', 'U')