with t1 as (
  select
    r_katashiki,  -- 呼称型式
    r_sfx_code,   -- SFX№
    r_spec_keta,  -- SPEC桁
    r_spec_kigo,  -- SPEC記号
    r_dist_code,  -- 受注先コード
    left(r_prod_month, 4) as sk_y,     -- 生産年
    substr(r_prod_month, 5, 2) as sk_m,-- 生産月
    r_shashu -- 車種コード
  from {{source('katashiki_db_spec','raw_tmp10_dm_siyo_seisan_daisu_test')}}
  {% raw %}
     --from {{ref('tmp10_dm_siyo_seisan_daisu')}}
  {% endraw %}
), sh as (
  select
    syasyu,  -- 車種コード
    s1keta,  -- SPEC桁
    s1kigo   -- SPEC記号
  from {{source('supplydemand_db_public','raw_stg_siyouhenkan')}}
  {% raw %}
     -- {{ref('stg_siyouhenkan')}}
  {% endraw %}
)
select
    t1.*
from t1
inner join sh
on (
    t1.r_shashu = sh.syasyu
and TO_NUMBER(t1.r_spec_keta) = TO_NUMBER(sh.s1keta)
and t1.r_spec_kigo = sh.s1kigo
)