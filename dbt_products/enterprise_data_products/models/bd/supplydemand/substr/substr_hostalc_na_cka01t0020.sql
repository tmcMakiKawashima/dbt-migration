with substr_hostalc_na_cka01t0020 as (
  select
    substr(raw_data, 1, 2)::varchar(2) as psc,
    substr(raw_data, 3, 1)::varchar(1) as plantcode,
    substr(raw_data, 4, 8)::varchar(8) as lodate,
    substr(raw_data, 12, 10)::varchar(10) as idno,
    substr(raw_data, 22, 4)::varchar(4) as msgno,
    substr(raw_data, 26, 50)::varchar(50) as labelinfo,
    substr(raw_data, 76, 14)::varchar(14) as updateymdel14dg,
    ldts,
    line_number
  from {{ ref('tmp_hostalc_na_cka01t0020')}}
)

select * from substr_hostalc_na_cka01t0020