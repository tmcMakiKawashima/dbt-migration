with stg_syasyusedaisakujo as (
    select
        rtrim(cd_pubbnd,' 　')::varchar(6) as cd_pubbnd, -- 右blank
        ldts, -- b層のldts
        line_number,
        rank() over (partition by cd_pubbnd order by ldts desc, line_number desc) aggkey
        from {{ref('substr_ktrla05azz0kvw0007')}})
select * exclude(aggkey, line_number) from stg_syasyusedaisakujo where aggkey = 1