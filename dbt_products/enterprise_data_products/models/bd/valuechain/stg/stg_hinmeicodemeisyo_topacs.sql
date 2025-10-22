with stg_hinmeicodemeisyo_topacs as (
    select
        mtkbn::varchar(1) as mtkbn, 
        rtrim(pnc1, ' 　')::varchar(6) as pnc1, -- 右blank
        rtrim(langua, ' 　')::varchar(2) as langua, -- 右blank
        iff(rtrim(pncmei, ' 　') = '', null, rtrim(pncmei, ' 　'))::varchar(60) as pncmei, -- 右blank,空値の場合はnull
        ldts,
        line_number,
        rank() over (
            partition by 
                pnc1,
                langua
            order by ldts desc, line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01xzz0kv200va') }}
)
select * exclude(aggkey, mtkbn, line_number)
from stg_hinmeicodemeisyo_topacs
where aggkey = 1 and mtkbn in (1, 4)
order by pnc1 asc