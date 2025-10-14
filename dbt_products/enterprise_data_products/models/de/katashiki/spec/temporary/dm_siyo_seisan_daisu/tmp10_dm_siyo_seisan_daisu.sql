with kj as (
  select 
    r_prod_month,  -- 生産年月
    r_edno,  -- ｅｄ№
    r_sfx_code,  -- r_sfx_code
    r_shashu,  -- 車種コード
    r_dist_code,  -- 受注先コード
    r_katashiki  -- 呼称型式
  from {{ref('stg_cam2146_jyukyujyoho')}}
), sj as (
  select
    r_prod_month,  -- 生産年月
    r_edno,  -- ｅｄ№
    r_spec_keta,  -- SPEC桁
    r_spec_kigo  -- SPEC記号
  from {{ref('stg_cam2148_jyukyujyoho')}}
)
select
    kj.r_prod_month,
    kj.r_edno,
    kj.r_sfx_code,
    kj.r_shashu,
    kj.r_dist_code,
    kj.r_katashiki,
    sj.r_spec_keta,
    sj.r_spec_kigo
from kj
left join sj
on (
    kj.r_prod_month = sj.r_prod_month
and kj.r_edno = sj.r_edno
)