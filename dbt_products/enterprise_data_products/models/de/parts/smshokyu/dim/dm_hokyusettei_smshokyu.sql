with hokyusettei as (
    select
        *
    from {{ ref('stg_hokyusettei_smshokyu') }}
),
syasyu as (
    select 
        syasyu,
        tantogaisya,
        syukan
    from {{ ref('stg_syasyu') }}
)
select
    hokyusettei.*
from hokyusettei
inner join syasyu
    on hokyusettei.syasyu = syasyu.syasyu
    and syasyu.tantogaisya = '01'
    and syasyu.syukan = 'TM'