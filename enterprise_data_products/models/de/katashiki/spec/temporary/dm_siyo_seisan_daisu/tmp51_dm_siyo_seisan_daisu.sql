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
	from {{ref('tmp50_dm_siyo_seisan_daisu')}} base
)
select * exclude(dest_match_flag, rn)
from rnk
where rn = 1