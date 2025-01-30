{{
    config (
        post_hook=
            'create or replace hybrid table customerservice_db.public.stg_riyosyasyutekiyonengetsusyameikatashiki (
                cd_pubbnd varchar(6) not null,
                syamei varchar(5) not null,
                cd_vtype varchar(6) not null,
                dd_pubbnd_trmfrym varchar(6) not null,
                kosyo_kt varchar(20) not null,
                ldts timestamp_ntz(9),
                constraint stg_riyosyasyutekiyonengetsusyameikatashiki_cd_pubbnd_syamei_cd_vtype_dd_pubbnd_trmfrym_kosyo_kt_uk primary key (cd_pubbnd, syamei, cd_vtype, dd_pubbnd_trmfrym, kosyo_kt) rely
            ) as select * from {{this}}'
    )
}}

with
    stg_riyosyasyutekiyonengetsusyameikatashiki as (
        select
            rtrim(cd_pubbnd,' 　')::varchar(6) as cd_pubbnd, -- 右blank
            rtrim(cd_model_nm,' 　')::varchar(5) as syamei, -- 右blank
            rtrim(cd_vtype,' 　')::varchar(6) as cd_vtype, -- 右blank
            dd_pubbnd_trmfrym::varchar(6) as dd_pubbnd_trmfrym,
            rtrim(cd_fll_mdl,' 　')::varchar(20) as kosyo_kt, -- 右blank
            ldts, -- b層のldts
            line_number,
            rank() over (
                partition by
                    cd_pubbnd,
                    syamei,
                    cd_vtype,
                    dd_pubbnd_trmfrym,
                    kosyo_kt
                order by ldts desc, line_number desc
            ) aggkey
        from {{ref('substr_ktrla05azz0kvw0006')}}
    ),
    stg_syasyusedaisakujo as (
        select
            cd_pubbnd
        from {{ ref('stg_syasyusedaisakujo') }} -- 車種世代削除情報
    )
select stg_riyosyasyutekiyonengetsusyameikatashiki.* exclude(aggkey, line_number) from stg_riyosyasyutekiyonengetsusyameikatashiki
left outer join stg_syasyusedaisakujo on stg_riyosyasyutekiyonengetsusyameikatashiki.cd_pubbnd = stg_syasyusedaisakujo.cd_pubbnd
where stg_syasyusedaisakujo.cd_pubbnd is null and aggkey = 1