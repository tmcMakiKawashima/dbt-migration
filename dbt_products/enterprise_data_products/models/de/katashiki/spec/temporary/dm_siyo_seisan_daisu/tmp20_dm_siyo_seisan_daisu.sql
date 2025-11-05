with t1 as (
  select
    r_katashiki,  -- 呼称型式
    r_sfx_code,   -- SFX№
    r_spec_keta,  -- SPEC桁
    r_spec_kigo,  -- SPEC記号
    r_dist_code,  -- 受注先コード
    left(r_prod_month, 4) as sk_y,
    substr(r_prod_month, 5, 2) as sk_m,
    r_shashu
  from {{ref('tmp10_dm_siyo_seisan_daisu')}}
), sh as (
  select
    syasyu,
    s1keta,  -- SPEC桁
    s1kigo   -- SPEC記号
  from {{ref('stg_siyouhenkan')}}
)
select
    sh.syasyu as shashu_cd,
    t1.r_katashiki as r_katashiki,
    t1.r_sfx_code as r_sfx_code,
    t1.r_spec_keta as r_spec_keta,
    t1.r_spec_kigo as r_spec_kigo,
    t1.r_dist_code as r_dist_code,
    sk_y,
    sk_m
from t1
inner join sh
on (
    t1.r_shashu = sh.syasyu
and TO_NUMBER(t1.r_spec_keta) = TO_NUMBER(sh.s1keta)
and t1.r_spec_kigo = sh.s1kigo
)