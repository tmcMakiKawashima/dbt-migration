with zissiziki as (
    select
        *
    from {{ ref('stg_zissiziki_smshokyu') }}
),
syasyu as (
    select 
        syasyu,
        tantogaisya,
        syukan
    from {{ ref('stg_syasyu') }}
)
select
    zissiziki.*
from zissiziki
inner join syasyu
    on zissiziki.syasyu = syasyu.syasyu
    and syasyu.tantogaisya = '01'
    and syasyu.syukan = 'TM'