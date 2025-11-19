with rnk as (
    select
        base.*,
        row_number() over (
            partition by
                base.syasyu,
                base.haisya_kt,
                base.sk_y,
                base.sk_m,
                base.spec200
            order by
                base.dest_match_flag desc
        ) as rn
	from {{source('katashiki_db_spec','raw_tmp50_dm_siyo_seisan_daisu_test')}} base
  {% raw %}
     --from {{ref('tmp50_dm_siyo_seisan_daisu')}}
  {% endraw %}
)
select * exclude(dest_match_flag)
from rnk
where rn = 1