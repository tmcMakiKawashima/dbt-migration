{{
    config (
        post_hook=
            'create or replace hybrid table customerservice_db.public.stg_riyosyasyusedai (
                cd_pubbnd varchar(6) not null,
                mj_opt1_str varchar(100),
                mj_opt2_str varchar(100),
                mj_opt3_str varchar(100),
                mj_opt4_str varchar(100),
                mj_opt5_str varchar(100),
                ldts timestamp_ntz(9),
                constraint stg_riyosyasyusedai_cd_pubbnd_uk primary key (cd_pubbnd) rely
            ) as select * from {{this}}'
    )
}}

with
    stg_riyosyasyusedai as (
        select
            rtrim(cd_pubbnd,' 　')::varchar(6) as cd_pubbnd, -- 右blank
            rtrim(mj_opt1_str,' 　')::varchar(100) as mj_opt1_str, -- 右blank
            rtrim(mj_opt2_str,' 　')::varchar(100) as mj_opt2_str, -- 右blank
            rtrim(mj_opt3_str,' 　')::varchar(100) as mj_opt3_str, -- 右blank
            rtrim(mj_opt4_str,' 　')::varchar(100) as mj_opt4_str, -- 右blank
            rtrim(mj_opt5_str,' 　')::varchar(100) as mj_opt5_str, -- 右blank
            ldts, -- b層のldts
            line_number,
            rank() over (partition by cd_pubbnd order by ldts desc, line_number desc) aggkey
        from {{ ref('substr_ktrla05azz0kvw0004') }}
    ),
    stg_syasyusedaisakujo as (
        select
            cd_pubbnd
        from {{ ref('stg_syasyusedaisakujo') }} -- 車種世代削除情報
    )
select stg_riyosyasyusedai.* exclude(aggkey, line_number) from stg_riyosyasyusedai
left outer join stg_syasyusedaisakujo on stg_riyosyasyusedai.cd_pubbnd = stg_syasyusedaisakujo.cd_pubbnd
where stg_syasyusedaisakujo.cd_pubbnd is null and aggkey = 1