with stg_katasikipattern_topacs as (
    select
        mtkbn::varchar(1) as mtkbn, 
        rtrim(catalg, ' 　')::varchar(6) as catalg, -- 右blank
        rtrim(syasyu, ' 　')::varchar(4) as syasyu, -- 右blank
        rtrim(katapno, ' 　')::varchar(5) as katapno, -- 右blank
        rtrim(katano, ' 　')::varchar(3) as katano, -- 右blank
        ldts,
        line_number,
        rank() over (
            partition by 
                catalg,
                syasyu,
                katapno,
                katano
            order by ldts desc, line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01xzz0kv200v8') }}
)
select * exclude(aggkey, mtkbn, line_number)
from stg_katasikipattern_topacs
where aggkey = 1 and mtkbn in (1, 4)
order by catalg asc