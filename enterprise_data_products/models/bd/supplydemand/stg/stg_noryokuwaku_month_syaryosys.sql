with stg_noryokuwaku_month_syaryosys as (
    select
        shamei::varchar(2) as shamei, 
        sno::varchar(2) as sno, 
        nengetu::varchar(6) as nengetu, 
        kncode::varchar(7) as kncode, 
        wkbn::varchar(1) as wkbn, 
        ksign::varchar(1) as ksign, 
        dsyubetum::varchar(9) as dsyubetum, 
        tdaisu::varchar(5) as tdaisu, 
        dummy::varchar(7) as dummy, 
        ldts
    from {{ ref('substr_da34b18') }}
)
select * from stg_noryokuwaku_month_syaryosys
where ldts = (select max(ldts) from stg_noryokuwaku_month_syaryosys)