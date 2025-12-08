with t70 as (
    select
        syasyu,                           -- 車種ｺｰﾄﾞ
        kata,                             -- 呼称型式
        spec,                             -- SPEC200桁組合せ
        intcode,                          -- 内張コード
        int_cd_iromei,                    -- 内張色
        extcode,                          -- 外鈑色コード
        ext_cd_iromei,                    -- 外鈑色
        destcode as dest_cd,              -- 仕向地コード
        r_country_name as dest,           -- 仕向国
        plantcode,                        -- 工場コード
        enginekata,                       -- エンジン型式
        pscexlk,                          -- PSC
        sk_y,                             -- 終検日年
        sk_m,                             -- 終検日月
        idline,                           -- アイデントライン
        daisu,                            -- 台数
        keta_no,                          -- 桁No
        kigo                              -- specを1文字づつ200分割した記号
    from {{ref('tmp70_dm_siyo_seisan_daisu')}}
), sh as (
    select
        syasyu,    -- 車種ｺｰﾄﾞ
        s1keta,    -- spec桁
        s1kigo,    -- spec記号
        siyoudai4, -- 仕様コード(4桁)大分類
        siyousai4  -- 仕様コード(4桁)細目
    from {{ref('stg_siyouhenkan')}}
)
select
    coalesce(t70.syasyu, '') as syasyu,
    coalesce(t70.kata, '') as kata,
    null::varchar(2) as r_sfx_code,
    coalesce(t70.spec, '') as spec,
    listagg(sh.siyoudai4 || sh.siyousai4, '')
    within group (order by t70.keta_no)::varchar(800) as spec200_siyo, -- SPEC対応4桁仕様,
    coalesce(t70.intcode, '') as intcode,
    t70.int_cd_iromei,
    coalesce(t70.extcode, '') as extcode,
    t70.ext_cd_iromei,
    coalesce(t70.dest_cd, '') as dest_cd,
    t70.dest,
    coalesce(t70.plantcode, '') as plantcode,
    coalesce(t70.enginekata, '') as enginekata,
    coalesce(t70.pscexlk, '') as pscexlk,
    coalesce(t70.idline, '') as idline,
    coalesce(t70.sk_y, '') as sk_y,
    coalesce(t70.sk_m, '') as sk_m,
    t70.daisu,
    '1' as naiji_flg -- 内示実績FLG
from t70
left join sh
on(
    t70.syasyu = sh.syasyu
and to_number(t70.keta_no) = to_number(sh.s1keta)
and t70.kigo = sh.s1kigo
)
group by
    t70.syasyu,
    t70.kata,
    t70.spec,
    t70.intcode,
    t70.int_cd_iromei,
    t70.extcode,
    t70.ext_cd_iromei,
    t70.dest_cd,
    t70.dest,
    t70.plantcode,
    t70.enginekata,
    t70.pscexlk,
    t70.idline,
    t70.sk_y,
    t70.sk_m,
    t70.daisu