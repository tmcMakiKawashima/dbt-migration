with substr_ktrla01dzz0kalc015 as (
  select
    to_varchar(substr(raw_data, 1, 7), 'utf-8')::varchar(7) as kncode,
    to_varchar(substr(raw_data, 8, 60), 'utf-8')::varchar(60) as sknmmei,
    to_varchar(substr(raw_data, 68, 1), 'utf-8')::varchar(1) as knmsortjun,
    to_varchar(substr(raw_data, 69, 8), 'utf-8')::varchar(8) as creymd,
    to_varchar(substr(raw_data, 77, 18), 'utf-8')::varchar(18) as mtuser,
    to_varchar(substr(raw_data, 95, 26), 'utf-8')::varchar(26) as mttime,
    ldts,
    line_number
  from {{ ref('byte_ktrla01dzz0kalc015') }}
)

select * from substr_ktrla01dzz0kalc015