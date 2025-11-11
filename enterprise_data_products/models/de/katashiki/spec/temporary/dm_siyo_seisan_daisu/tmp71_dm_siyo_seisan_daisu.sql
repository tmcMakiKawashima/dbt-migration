with t7 as (
    select
        syasyu,
        kata,
        spec,
        intcode,
        int_cd_iromei,
        extcode,
        ext_cd_iromei,
        dest_cd,
        dest,
        plantcode,
        enginekata,
        pscexlk,
        sk_y,
        sk_m,
        idline,
        daisu,
        keta_no,
        kigo
    from {{ref('tmp70_dm_siyo_seisan_daisu')}}
), sh as (
  select
    syasyu,
    s1keta,  -- spec桁
    s1kigo,   -- spec記号
    siyoudai4,
    siyousai4
    from {{source('supplydemand_db_public','raw_stg_siyouhenkan')}}
)
select
    t7.syasyu,
    kata,
    null as r_sfx_code,
    spec,
    listagg(sh.siyoudai4 || sh.siyousai4, '')
    within group (order by t7.keta_no) as spec200_siyo,
    intcode,
    int_cd_iromei,
    extcode,
    ext_cd_iromei,
    dest_cd,
    dest,
    plantcode,
    enginekata,
    pscexlk,
    idline,
    sk_y,
    sk_m,
    daisu,
    '1' as naiji_flg
from t7
left join sh
on(
    t7.syasyu = sh.syasyu
and to_number(t7.keta_no) = to_number(sh.s1keta)
and t7.kigo = sh.s1kigo
)
group by
    t7.syasyu,
    kata,
    spec,
    intcode,
    int_cd_iromei,
    extcode,
    ext_cd_iromei,
    dest_cd,
    dest,
    plantcode,
    enginekata,
    pscexlk,
    idline,
    sk_y,
    sk_m,
    daisu