with rnk as (
    select
        base.*,
        row_number() over (
            partition by
                base.syasyu,
                base.haisya_kt,
                base.sk_y,
                base.sk_m,
                base.SPEC200
            order by
                base.dest_match_flag
        ) as rn
	from {{ref('tmp50_dm_siyo_seisan_daisu')}} base
)
select
 	syasyu,
	haisya_kt,
	r_sfx_code,
	spec200,
	spec200_siyo,
	int_cd,
	int_cd_iromei,
	ext_cd,
	ext_cd_iromei,
	dest_cd,
	dest,
	koujyou_cd,
	eng_kt,
	prodkuni_cd,
	psc,
	o_idline,
	sk_y,
	sk_m,
	daisu,
	naiji_flg
from rnk
where rn = 1