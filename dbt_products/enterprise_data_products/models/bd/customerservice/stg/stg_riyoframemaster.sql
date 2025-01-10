with
    stg_riyoframemaster as (
        select
            rtrim(no_vin_frameno,' 　')::varchar(17) as no_vin_frameno, -- 右blank
            kb_frameno::varchar(1) as kb_frameno,
            rtrim("cd_fll_mdl",' 　')::varchar(20) as kosyo_kt, -- 右blank
            rtrim(cd_pubbnd,' 　')::varchar(6) as cd_pubbnd, -- 右blank
            rtrim("cd_model_nm",' 　')::varchar(5) as syamei, -- 右blank
            rtrim(cd_vtype,' 　')::varchar(6) as cd_vtype, -- 右blank
            dd_pubbnd_trmfrym::varchar(6) as dd_pubbnd_trmfrym,
            "dd_mdly"::varchar(4) as my,
            dd_sectest::varchar(8) as dd_sectest,
            rtrim("cd_sms",' 　')::varchar(4) as sms_syasyu_cd, -- 右blank
            rtrim("cd_dispatch_mdl",' 　')::varchar(20) as haisya_kt, -- 右blank
            rtrim("cd_sale_mdl",' 　')::varchar(20) as hanbai_kt, -- 右blank
            dt_frameno_capture::varchar(8) as dt_frameno_capture,
            ldts, -- b層のldts
            line_number,
            rank() over (partition by no_vin_frameno order by ldts desc, line_number desc) aggkey
        from {{ref('substr_ktrla05azz0kvw0002')}}
    ),
    stg_syasyusedaisakujo as (
        select
            cd_pubbnd
        from {{ ref('stg_syasyusedaisakujo') }} -- 車種世代削除情報
    )
select stg_riyoframemaster.* exclude(aggkey, line_number) from stg_riyoframemaster
left outer join stg_syasyusedaisakujo on stg_riyoframemaster.cd_pubbnd = stg_syasyusedaisakujo.cd_pubbnd
where stg_syasyusedaisakujo.cd_pubbnd is null and aggkey = 1