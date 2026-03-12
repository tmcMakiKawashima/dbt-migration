with
    dm_siyo_seisan_daisu as (select * from {{ ref('dm_siyo_seisan_daisu') }}), --仕様生産情報実績
    stg_syasyu_tmc_sms as (select distinct syasyu from {{ ref('stg_syasyu_tmc_sms') }}) --車種(トヨタ車種限定)

select
    a.syasyu::varchar(4) as syasyu,  --車種ｺｰﾄﾞ
    a.haisya_kt::varchar(20) as haisya_kt,  --配車型式
    a.r_sfx_code::varchar(2) as r_sfx_code,  --SFXコード
    a.spec200::varchar(200) as spec200,  --SPEC200桁組合せ
    a.spec200_siyo::varchar(800) as spec200_siyo,  --SPEC対応4桁仕様
    a.int_cd::varchar(4) as int_cd,  --内張コード
    a.int_cd_iromei::varchar(25) as int_cd_iromei,  --内張名
    a.ext_cd::varchar(4) as ext_cd,  --外鈑色コード
    a.ext_cd_iromei::varchar(25) as ext_cd_iromei,  --外鈑色名
    a.dest_cd::varchar(5) as dest_cd,  --仕向地コード
    a.dest::varchar(20) as dest,  --仕向国
    a.koujyou_cd::varchar(1) as koujyou_cd,  --工場コード
    a.eng_kt::varchar(8) as eng_kt,  --エンジン型式
    a.psc::varchar(2) as psc,  --PSC
    a.o_idline::varchar(2) as o_idline,  --アイデントライン
    a.sk_y::varchar(4) as sk_y,  --終検日年
    a.sk_m::varchar(2) as sk_m,  --終検日月
    a.daisu::number(13, 0) as daisu,  --台数
    a.naiji_flg::varchar(1) as naiji_flg,  --内示FLG
    a.ldts::timestamp_ntz(9) as ldts  --最終更新日時
from dm_siyo_seisan_daisu a
inner join stg_syasyu_tmc_sms b
    on trim(a.syasyu) = trim(b.syasyu)
