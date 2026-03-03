with hokyusetteicltiikigenntei as (
    select
        *
    from {{ ref('stg_hokyusetteicltiikigenntei_smshokyu') }}
),
syasyu as (
    select 
        syasyu,
        tantogaisya,
        syukan
    from {{ ref('stg_syasyu') }}
)
select
    hokyusetteicltiikigenntei.*
from hokyusetteicltiikigenntei
inner join syasyu
    on hokyusetteicltiikigenntei.syasyu = syasyu.syasyu
    and syasyu.tantogaisya = '01'
    and syasyu.syukan = 'TM'