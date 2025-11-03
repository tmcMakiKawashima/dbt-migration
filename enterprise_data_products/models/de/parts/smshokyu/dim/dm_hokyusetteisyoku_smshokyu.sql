with hokyusetteisyoku as (
    select
        *
    from {{ ref('stg_hokyusetteisyoku_smshokyu') }}
),
syasyu as (
    select 
        syasyu,
        tantogaisya,
        syukan
    from {{ ref('stg_syasyu') }}
)
select
    hokyusetteisyoku.*
from hokyusetteisyoku
inner join syasyu
    on hokyusetteisyoku.syasyu = syasyu.syasyu
    and syasyu.tantogaisya = '01'
    and syasyu.syukan = 'TM'