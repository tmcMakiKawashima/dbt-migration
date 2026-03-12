with
    stg_siyouhenkan as (select * from {{ ref('stg_siyouhenkan') }}), --仕様変換
    stg_syasyu_tmc_sms as (select distinct syasyu from {{ ref('stg_syasyu_tmc_sms') }}) --車種(トヨタ車種限定)

select
    a.syasyu::varchar(4) as syasyu,  --車種コード
    a.shiyodai::varchar(3) as shiyodai,  --仕様コード(5桁)大分類
    a.shiyosai::varchar(2) as shiyosai,  --仕様コード(5桁)細目
    a.siyoudai4::varchar(3) as siyoudai4,  --仕様コード(4桁)大分類
    a.siyousai4::varchar(1) as siyousai4,  --仕様コード(4桁)細目
    a.s1keta::varchar(3) as s1keta,  --スペック桁1
    a.s1kigo::varchar(1) as s1kigo,  --スペック記号1
    a.s2keta::varchar(3) as s2keta,  --スペック桁2
    a.s2kigo::varchar(1) as s2kigo,  --スペック記号2
    a.s3keta::varchar(3) as s3keta,  --スペック桁3
    a.s3kigo::varchar(1) as s3kigo,  --スペック記号3
    a.ctlkata::varchar(20) as ctlkata,  --ＣＴＬ型式
    a.tokukbn::varchar(1) as tokukbn,  --特設区分
    a.sijikara::varchar(9) as sijikara,  --指示書№カラ
    a.tutisyokara::varchar(3) as tutisyokara,  --通知書№カラ
    a.tutisufkara::varchar(2) as tutisufkara,  --通知書№カラSUFIX
    a.tutisyomade::varchar(3) as tutisyomade,  --通知書№マデ
    a.tutisufmade::varchar(2) as tutisufmade,  --通知書№マデSUFIX
    a.tekikara::varchar(8) as tekikara,  --適用期間カラ
    a.tekimade::varchar(8) as tekimade,  --適用期間マデ
    a.mtdate::timestamp_ntz(9) as mtdate,  --MT日時
    a.ldts::timestamp_ntz(9) as ldts  --B層取込日時
from stg_siyouhenkan a
inner join stg_syasyu_tmc_sms b
    on trim(a.syasyu) = trim(b.syasyu)
