with stg_katasikihyogenjiki_topacs as (
    select
        mtkbn::varchar(1) as mtkbn, 
        rtrim(catalg, ' 　')::varchar(6) as catalg, -- 右blank
        rtrim(katahyono, ' 　')::varchar(5) as katahyono, -- 右blank
        iff(rtrim(katapno, ' 　') = '', null, rtrim(katapno, ' 　'))::varchar(5) as katapno, -- 右blank,空値の場合はnull
        iff(rtrim(hyognkara, ' 　') = '', null, rtrim(hyognkara, ' 　'))::varchar(6) as hyognkara, -- 右blank,空値の場合はnull
        iff(rtrim(hyognmade, ' 　') = '', null, rtrim(hyognmade, ' 　'))::varchar(6) as hyognmade, -- 右blank,空値の場合はnull
        ldts,
        line_number,
        rank() over (
            partition by 
                catalg,
                katahyono
            order by ldts desc, line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01xzz0kv200v7') }}
)
select * exclude(aggkey, mtkbn, line_number)
from stg_katasikihyogenjiki_topacs
where aggkey = 1 and mtkbn in (1, 4)
order by catalg asc