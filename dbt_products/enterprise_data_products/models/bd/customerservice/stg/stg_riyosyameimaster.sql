with stg_riyosyameimaster as (
    select
        rtrim(cd_model_nm,' 　')::varchar(5) as cd_model_nm,  -- 右blank
        kb_model_brand::varchar(1) as kb_model_brand, 
        rtrim(mj_j_model_nm,' 　')::varchar(60) as mj_j_model_nm,  -- 右blank
        rtrim(mj_e_model_nm,' 　')::varchar(60) as mj_e_model_nm,  -- 右blank
        ldts, -- b層のldts
    from {{ source('snowpipe_db_customerservice', 'raw_ktrla05azz0kvw0003') }}
)
select * from stg_riyosyameimaster
where ldts = (select max(ldts) from stg_riyosyameimaster)