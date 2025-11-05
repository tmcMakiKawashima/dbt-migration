with stg_dfsc_kinomeisaicd_syaryosys as (
    select
        sno::varchar(2) as sno, 
        shamei::varchar(2) as shamei, 
        dfsc::varchar(5) as dfsc, 
        kncode::varchar(7) as kncode, 
        dum::varchar(4) as dum, 
        ldts
    from {{ ref('substr_da34b19') }}
)
select * from stg_dfsc_kinomeisaicd_syaryosys
where ldts = (select max(ldts) from stg_dfsc_kinomeisaicd_syaryosys)