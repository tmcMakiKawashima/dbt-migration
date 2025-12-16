with
    dm_syasyu_katashiki_specmaster as (select * from {{ source('katashiki_db_spec', 'raw_dm_syasyu_katashiki_specmaster') }}), --車種型式スペックマスター
    stg_syasyu_tmc_aisac as (select distinct syasyu from {{ ref('stg_syasyu_tmc_aisac') }}) --車種(トヨタ車種限定)

select
    a.syasyu::varchar(4) as syasyu,  --車種ｺｰﾄﾞ
    a.s1keta::varchar(3) as s1keta,  --スペック１ 桁
    a.s1kigo::varchar(1) as s1kigo,  --スペック１ 記号
    a.siyoudai4::varchar(3) as siyoudai4,  --仕様ｺｰﾄﾞ4桁 大分類
    a.siyousai4::varchar(1) as siyousai4,  --仕様ｺｰﾄﾞ4桁 細目
    a.daijpmei::varchar(25) as daijpmei,  --仕様大分類漢字名称
    a.daikanamei::varchar(25) as daikanamei,  --仕様大分類カナ名称
    a.daienmei::varchar(25) as daienmei,  --仕様大分類英字名称
    a.siyoudaicom::varchar(60) as siyoudaicom,  --仕様大分類コメント
    a.siyousai::varchar(2) as siyousai,  --仕様細目コード
    a.saikanamei::varchar(25) as saikanamei,  --仕様細目カナ名称
    a.saienmei::varchar(35) as saienmei,  --仕様細目英字名称
from dm_syasyu_katashiki_specmaster a
inner join stg_syasyu_tmc_aisac b
    on trim(a.syasyu) = trim(b.syasyu)