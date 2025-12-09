with hokyusetteitiikigenntei as (
    select
        *
    from {{ ref('stg_hokyusetteitiikigenntei_smshokyu') }}
),
syasyu as (
    select 
        syasyu,
        tantogaisya,
        syukan
    from {{ ref('stg_syasyu') }}
)
select
    hokyusetteitiikigenntei.*
from hokyusetteitiikigenntei
inner join syasyu
    on hokyusetteitiikigenntei.syasyu = syasyu.syasyu
    and syasyu.tantogaisya = '01'
    and syasyu.syukan = 'TM'