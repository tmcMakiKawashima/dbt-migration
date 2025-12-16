with
    dm_legacy_kousei_blktenkai as (select * from {{ ref('dm_legacy_kousei_blktenkai') }}), --旧型構成BLK展開
    stg_syasyu_tmc_aisac as (select distinct syasyu from {{ ref('stg_syasyu_tmc_aisac') }}) --車種(トヨタ車種限定)

select
    a.syasyu::varchar(4) as syasyu,  --車種コード
    a.siyoubui::varchar(10) as siyoubui,  --使用部位
    a.kumitate::varchar(10) as kumitate,  --組立番号
    a.bui::varchar(10) as bui,  --部位
    a.motosiyoubui::varchar(10) as motosiyoubui,  --元使用部位
    a.vari::varchar(10) as vari,  --バリエーション
    a.oyahin::varchar(10) as oyahin,  --親品番
    a.lv::number(38,0) as lv,  --レベル
    a.kouseijyun::number(18,0) as kouseijyun,  --構成順
    a.gc::varchar(2) as gc,  --GC
    a.kohin::varchar(10) as kohin,  --品番／BLKコード
    a.kohinmei::varchar(120) as kohinmei,  --品名／BLKコード名称
    a.kosu::varchar(3) as kosu,  --使用個数
    a.sentaku::varchar(2) as sentaku,  --選択符号
    a.tyohuku::varchar(100) as tyohuku,  --重複記載
    a.torokujunk::varchar as torokujunk,  --登録／生認順カラ
    a.torokujunm::varchar as torokujunm,  --登録／生認順マデ
    a.seppennok::varchar(10) as seppennok,  --設変No.カラ
    a.seppennom::varchar(10) as seppennom,  --設変No.マデ
    a.torokutimek::timestamp_ntz(9) as torokutimek,  --LOAD TIMEカラ
    a.torokutimem::timestamp_ntz(9) as torokutimem,  --LOAD TIMEマデ
    a.ldts::timestamp_ntz(9) as ldts  --B層処理日時
from dm_legacy_kousei_blktenkai a
inner join stg_syasyu_tmc_aisac b
    on trim(a.syasyu) = trim(b.syasyu)