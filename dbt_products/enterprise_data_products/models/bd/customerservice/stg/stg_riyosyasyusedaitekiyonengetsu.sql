with
    stg_riyosyasyusedaitekiyonengetsu as (
        select
            rtrim(cd_pubbnd,' 　')::varchar(6) as cd_pubbnd, -- 右blank
            dd_pubbnd_trmfrym::varchar(6) as dd_pubbnd_trmfrym, 
            dd_mdly::varchar(4) as my, 
            ldts, -- b層のldts
            line_number,
            rank() over (partition by cd_pubbnd, dd_pubbnd_trmfrym order by ldts desc, line_number desc) aggkey
        from {{ref('substr_ktrla05azz0kvw0005')}}
    ),
    stg_syasyusedaisakujo as (
        select
            cd_pubbnd
        from {{ ref('stg_syasyusedaisakujo') }} -- 車種世代削除情報
    )
select stg_riyosyasyusedaitekiyonengetsu.* exclude(aggkey, line_number) from stg_riyosyasyusedaitekiyonengetsu
left outer join stg_syasyusedaisakujo on stg_riyosyasyusedaitekiyonengetsu.cd_pubbnd = stg_syasyusedaisakujo.cd_pubbnd
where stg_syasyusedaisakujo.cd_pubbnd is null and aggkey = 1