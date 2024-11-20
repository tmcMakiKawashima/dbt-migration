with stg_riyosyasyusedai as (
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
        from {{ref('substr_ktrla05azz0kvw0004')}})
select * exclude(aggkey, line_number) from stg_riyosyasyusedai where aggkey = 1