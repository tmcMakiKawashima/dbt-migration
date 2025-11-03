with stg_hankahinban_atop as (
    select
        rtrim(hinban, ' 　')::varchar(20) as hinban,
        iff(trim(hinbansikicd, ' 　') = '',null,rtrim(hinbansikicd, ' 　'))::varchar(1) as hinbansikicd,
        iff(trim(knisyohincd, ' 　') = '',null,rtrim(knisyohincd, ' 　'))::varchar(2) as knisyohincd,
        iff(trim(kgisyohincd, ' 　') = '',null,rtrim(kgisyohincd, ' 　'))::varchar(2) as kgisyohincd,
        iff(trim(hinmkcd, ' 　') = '',null,rtrim(hinmkcd, ' 　'))::varchar(4) as hinmkcd,
        iff(trim(zissijiki, ' 　') = '',null,rtrim(zissijiki, ' 　'))::varchar(6) as zissijiki,
        iff(trim(siryomeihanka, ' 　') = '',null,rtrim(siryomeihanka, ' 　'))::varchar(20) as siryomeihanka,
        iff(trim(hnmeiassep, ' 　') = '',null,rtrim(hnmeiassep, ' 　'))::varchar(40) as hnmeiassep,
        iff(trim(syuyohinmokukbn, ' 　') = '',null,rtrim(syuyohinmokukbn, ' 　'))::varchar(1) as syuyohinmokukbn,
        iff(trim(sagyokancd, ' 　') = '',null,rtrim(sagyokancd, ' 　'))::varchar(4) as sagyokancd,
        iff(trim(syokaistiymd, ' 　') = '',null,to_date(syokaistiymd,'YYYYMMDD')) as syokaistiymd,
        iff(trim(hsstihohocd, ' 　') = '',null,rtrim(hsstihohocd, ' 　'))::varchar(2) as hsstihohocd,
        iff(trim(zidosticd, ' 　') = '',null,rtrim(zidosticd, ' 　'))::varchar(1) as zidosticd,
        iff(trim(kgikyutaiocd, ' 　') = '',null,rtrim(kgikyutaiocd, ' 　'))::varchar(2) as kgikyutaiocd,
        iff(trim(zaisitu, ' 　') = '',null,rtrim(zaisitu, ' 　'))::varchar(14) as zaisitu,
        iff(trim(itaatugpn, ' 　') = '',null,rtrim(itaatugpn, ' 　'))::varchar(8) as itaatugpn,
        iff(trim(smsjuryo, ' 　') = '',null,to_decimal(to_decimal(smsjuryo)/100,9,2))::decimal(9,2) as smsjuryo,
        iff(trim(hikakuhinban, ' 　') = '',null,rtrim(hikakuhinban, ' 　'))::varchar(20) as hikakuhinban,
        iff(trim(zumenumu, ' 　') = '',null,rtrim(zumenumu, ' 　'))::varchar(1) as zumenumu,
        iff(trim(oyazuban, ' 　') = '',null,rtrim(oyazuban, ' 　'))::varchar(12) as oyazuban,
        iff(trim(pristiyoso, ' 　') = '',null,rtrim(pristiyoso, ' 　'))::varchar(68) as pristiyoso,
        iff(trim(zeikbn, ' 　') = '',null,rtrim(zeikbn, ' 　'))::varchar(1) as zeikbn,
        iff(trim(mtuserid, ' 　') = '',null,rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(trim(mttime, ' 　') = '',null,try_to_timestamp_ntz(mttime,'YYYY-MM-DD-HH24.MI.SS.FF9')) as mttime,
        ldts,
        row_number() over (
            partition by 
                hinban
            order by line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01vzz0kvq00m1') }}
    where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvq00m1') }})
)
select * exclude(aggkey)
from stg_hankahinban_atop
where aggkey = 1