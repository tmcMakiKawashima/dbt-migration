with t3 as (
  select * from {{source('katashiki_db_spec','raw_tmp30_dm_siyo_seisan_daisu_test')}}
  {% raw %}
    --from {{ref('tmp30_dm_siyo_seisan_daisu')}}
  {% endraw %}
),
t4 as (
  select * from {{source('katashiki_db_spec','raw_tmp40_dm_siyo_seisan_daisu_test') }}
  {% raw %}
    --from {{ref('tmp40_dm_siyo_seisan_daisu')}}
  {% endraw %}
)
select
    t4.*,
    t3.r_sfx_code,
    case
        when t3.r_dist_code = t4.dest_cd
        then '1'
        else '0'
    end as dest_match_flag
from t4
left outer join t3
on (
    t4.syasyu = t3.r_shashu
and t4.haisya_kt = t3.r_katashiki
and t4.sk_y = t3.sk_y
and t4.sk_m = t3.sk_m
and t4.spec200 regexp('^' || replace(t3.spec200, ' ', '.') || '$')
)
--tmp30.SPEC200のうち、仕様変換マスタに存在しなかった桁はワイルドカードに置換して正規表現で比較