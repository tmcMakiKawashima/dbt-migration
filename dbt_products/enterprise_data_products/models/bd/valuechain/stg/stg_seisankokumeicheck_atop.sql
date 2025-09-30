
with stg_seisankokumeicheck_atop as (
    select
        rtrim(seisnkokumei, ' 　')::varchar(20) as seisnkokumei,
        iff(rtrim(seisnkm1keta, ' 　') = '', null, rtrim(seisnkm1keta, ' 　'))::varchar(1) as seisnkm1keta,
        iff(rtrim(isocd, ' 　') = '', null, rtrim(isocd,' 　'))::varchar(3) as isocd,
        iff(rtrim(mtuserid, ' 　') = '', null, rtrim(mtuserid,' 　'))::varchar(16) as mtuserid,
        iff(rtrim(mttime, ' 　') = '', null, to_timestamp_ntz(mttime, 'yyyy-mm-dd-hh24.mi.ss.ff6'))::timestamp_ntz(9) as mttime,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by seisnkokumei
            order by line_number desc
        ) aggkey 
    from {{ref('substr_ktrla01vzz0kvs00m3')}}
    where ldts = (select max(ldts) from {{ref('substr_ktrla01vzz0kvs00m3')}})
)
select * exclude(aggkey) from stg_seisankokumeicheck_atop
where aggkey = 1