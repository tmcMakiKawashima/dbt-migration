with substr_hostalc_na_cka01t0050 as (
  select
    substr(raw_data, 1, 2)::varchar(2) as psc,
    substr(raw_data, 3, 1)::varchar(1) as plantcode,
    substr(raw_data, 4, 8)::varchar(8) as lodate,
    substr(raw_data, 12, 10)::varchar(10) as idno,
    substr(raw_data, 22, 1)::varchar(1) as line,
    substr(raw_data, 23, 2)::varchar(2) as tp,
    substr(raw_data, 25, 2)::varchar(2) as prsnttptype,
    substr(raw_data, 27, 1)::varchar(1) as times,
    substr(raw_data, 28, 1)::varchar(1) as hostgalctp,
    substr(raw_data, 29, 2)::varchar(2) as actrsthostseq,
    substr(raw_data, 31, 3)::varchar(3) as lastbcno,
    substr(raw_data, 34, 15)::varchar(15) as pdate,
    substr(raw_data, 49, 14)::varchar(14) as ntdate,
    substr(raw_data, 63, 7)::varchar(7) as delaytime,
    substr(raw_data, 70, 1)::varchar(1) as prgrssgn,
    substr(raw_data, 71, 7)::varchar(7) as csprtp,
    substr(raw_data, 78, 7)::varchar(7) as csprbyo,
    substr(raw_data, 85, 7)::varchar(7) as csprdeli,
    substr(raw_data, 92, 7)::varchar(7) as leadtime,
    substr(raw_data, 99, 7)::varchar(7) as leadtimebs,
    substr(raw_data, 106, 1)::varchar(1) as cancelflg,
    substr(raw_data, 107, 1)::varchar(1) as histsign,
    substr(raw_data, 108, 14)::varchar(14) as updateymdel14dg,
    ldts,
    line_number
  from {{ ref('tmp_hostalc_na_cka01t0050')}}
)

select * from substr_hostalc_na_cka01t0050