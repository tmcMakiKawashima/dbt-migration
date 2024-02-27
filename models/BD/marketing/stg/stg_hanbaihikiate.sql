with stg_hanbaihikiate as (
    select
        hanbaino::varchar(11) as hanbaino,  -- なし
        rtrim(kosyokata,' 　')::varchar(20) as kosyokata,  -- 右blank
        rtrim(suffix_code,' 　')::varchar(3) as suffix_code,  -- 右blank
        rtrim(hanbaikata,' 　')::varchar(30) as hkata,  -- 右blank
        shiyoudai::varchar(3) as shiyoudai,  -- なし
        trim(shiyousai,' 　')::varchar(3) as shiyousai,  -- 左右blank
        hsochaku::varchar(1) as hsochaku,  -- なし
        sflg::varchar(1) as sflg,  -- なし
        cd_sksifunc::varchar(9) as cd_sksifunc,  -- なし
        cd_ksnfunc::varchar(9) as cd_ksnfunc,  -- なし
        cd_sksisya::varchar(16) as cd_sksisya,  -- なし
        cd_ksnsya::varchar(16) as cd_ksnsya,  -- なし
        dt_sakusei::varchar(26) as dt_sakusei,  -- なし
        try_to_timestamp_ntz(dt_kosin , 'yyyy-mm-dd-hh24.mi.ss.ff9') as dt_kosin,  -- timestamp
        ldts, -- B層のldts
        rank() over(
                partition by
                    hanbaino,
                    kosyokata,
                    suffix_code,
                    shiyoudai,
                    shiyousai,
                    hkata
                order by ldts desc
            ) aggkey
        from {{ref('substr_N8JFIM04')}}
)
select * from stg_hanbaihikiate where aggkey = 1