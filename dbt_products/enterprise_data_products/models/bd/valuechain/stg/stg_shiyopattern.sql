with stg_shiyopattern as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(syasyu_cd, ' 　')::varchar(4) as syasyu_cd, -- 右blank
        rtrim(siyoptno, ' 　')::varchar(4) as siyoptno, -- 右blank
        rtrim(siyocd, ' 　')::varchar(4) as siyocd, -- 右blank
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