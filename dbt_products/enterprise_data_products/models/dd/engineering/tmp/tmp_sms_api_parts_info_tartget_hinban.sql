with
    stg_kousei as (
        select
            kohin
        from
            {{ ref('stg_kousei') }}
        where
            trim(jigyoutai) = ''
            and substr(kohin,8,1) != '-'
    ),
    stg_hinban as (
        select
            hinban
        from
            {{ ref('tmp_hinban_eph') }}
    )
select
  distinct ks.kohin as hinban
from
  stg_kousei as ks
left outer join stg_hinban as hb
  on ks.kohin = hb.hinban
where
  hb.hinban is null