with t52 as (
    select
        t51.syasyu,
        t51.haisya_kt,
        max(t51.r_sfx_code) as r_sfx_code,
        max(t51.spec200) as spec200,
        max(t51.spec200_siyo) as spec200_siyo,
        max(t51.int_cd) as int_cd,
        max(t51.int_cd_iromei) as int_cd_iromei,
        max(t51.ext_cd) as ext_cd,
        max(t51.ext_cd_iromei) as ext_cd_iromei,
        t51.dest_cd,
        max(t51.dest) as dest,
        max(t51.koujyou_cd) as koujyou_cd,
        max(t51.eng_kt) as eng_kt,
        max(t51.psc) as psc,
        max(t51.o_idline) as o_idline,
        t51.sk_y,
        t51.sk_m,
        max(t51.daisu) as daisu,
        max(t51.naiji_flg) as naiji_flg
	from {{source('katashiki_db_spec','raw_tmp51_dm_siyo_seisan_daisu_test')}} as t51
  {% raw %}
    --from {{ref('tmp51_dm_siyo_seisan_daisu')}}
  {% endraw %}
    group by
        syasyu,
        haisya_kt,
        dest_cd,
        sk_y,
        sk_m
)
select * from t52