{{
    config (
        post_hook=
            'create or replace hybrid table valuechain_db.public.stg_shiyopattern (
                syasyu_cd varchar(4) not null,
                siyoptno varchar(4) not null,
                siyocd varchar(4) not null,
                ldts timestamp_ntz(9),
                constraint stg_shiyopattern_syasyu_cd_siyoptno_siyocd_uk primary key (syasyu_cd, siyoptno, siyocd) rely
            ) as select * from {{this}}'
    )
}}

with stg_shiyopattern as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(syasyu_cd, ' 　')::varchar(4) as syasyu_cd, 
        rtrim(siyoptno, ' 　')::varchar(4) as siyoptno, 
        rtrim(siyocd, ' 　')::varchar(4) as siyocd, 
        ldts, -- b層のldts
        rank() over (
                partition by
                    syasyu_cd,
                    siyoptno,
                    siyocd
                order by ldts desc
            ) aggkey
        from {{ref('substr_dv2a4774')}})
select * exclude(aggkey, mntkbn) from stg_shiyopattern where aggkey = 1 and mntkbn in ('C', 'U')