with kj as (
  select 
    r_prod_month,  -- 生産年月
    r_edno,  -- ｅｄ№
    r_sfx_code,  -- r_sfx_code
    r_shashu,  -- 車種コード
    r_dist_code,  -- 受注先コード
    r_katashiki  -- 呼称型式
    from {{source('supplydemand_db_public','raw_stg_cam2146_jyukyujyoho')}}
    {% raw %}
     --from {{ref('stg_cam2146_jyukyujyoho')}}
    {% endraw %}
), sj as (
  select
    r_prod_month,  -- 生産年月
    r_edno,  -- ｅｄ№
    r_spec_keta,  -- SPEC桁
    trim(r_spec_kigo) as r_spec_kigo  -- SPEC記号
  from {{source('supplydemand_db_public','raw_stg_cam2148_jyukyujyoho')}}
  {% raw %}
  --from  {{ref('stg_cam2146_jyukyujyoho')}}
  {% endraw %}
)
select
    kj.*,
    sj.r_spec_keta,
    sj.r_spec_kigo
from kj
left join sj
on (
    kj.r_prod_month = sj.r_prod_month
and kj.r_edno = sj.r_edno
)
where 
  length(trim(r_spec_kigo)) = 1