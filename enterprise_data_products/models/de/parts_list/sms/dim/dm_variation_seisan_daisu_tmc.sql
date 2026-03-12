with
    dm_variation_seisan_daisu as (select * from {{ ref('dm_variation_seisan_daisu') }}), --バリエーション生産実績
    stg_syasyu_tmc_sms as (select distinct syasyu from {{ ref('stg_syasyu_tmc_sms') }}) --車種(トヨタ車種限定)

select
    a.syasyu::varchar(4) as syasyu,  --車種コード
    a.kumitate::varchar(4) as kumitate,  --組立番号
    a.bui::varchar(2) as bui,  --部位
    a.vari::varchar(2) as vari,  --バリエーション
    a.seppen_no_kara::varchar(10) as seppen_no_kara,  --設変Noカラ
    a.haisya_kt::varchar(20) as haisya_kt,  --配車型式
    a.spec200::varchar(40000) as spec200,  --SPEC200桁組合せ
    a.spec200_siyo::varchar(800) as spec200_siyo,  --SPEC対応4桁仕様
    a.sk_y::varchar(4) as sk_y,  --終検日年
    a.sk_m::varchar(2) as sk_m,  --終検日月
    a.daisu::number(13,0) as daisu,  --台数
    a.daisu_spec200::number(13,0) as daisu_spec200,  --台数(SPEC200)
    a.spkbn::varchar(1) as spkbn,  --STD/OPT
    a.hikisiyo::varchar(250) as hikisiyo,  --引当仕様コード
    a.spec200_hikisiyo::varchar(200) as spec200_hikisiyo,  --SPEC200桁組合せ(引当仕様コード)
    ''::varchar(1) as naijiflg, --内示FLG
    a.ldts::timestamp_ntz(9) as ldts  --最終更新日時
from dm_variation_seisan_daisu a
inner join stg_syasyu_tmc_sms b
    on trim(a.syasyu) = trim(b.syasyu)
