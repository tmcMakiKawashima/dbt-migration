with
    stg_specname as (select * from {{ ref('stg_specname') }}), --スペック名称
    stg_syasyu_tmc_sms as (select distinct syasyu from {{ ref('stg_syasyu_tmc_sms') }}) --車種(トヨタ車種限定)

select
    a.syasyu::varchar(4) as syasyu,  --車種コード
    a.shiyodai::varchar(3) as shiyodai,  --仕様コード(5桁)大分類
    a.shiyosai::varchar(2) as shiyosai,  --仕様コード(5桁)細目
    a.sketa::varchar(3) as sketa,  --スペック桁
    a.skigo::varchar(1) as skigo,  --スペック記号
    a.smeikanji::varchar(25) as smeikanji,  --スペック名称漢字
    a.smeikana::varchar(25) as smeikana,  --スペック名称カナ
    a.smeieiji::varchar(25) as smeieiji,  --スペック名称英字
    a.mtflg::varchar(1) as mtflg,  --生管MTFLG
    a.sijikara::varchar(9) as sijikara,  --指示書№カラ
    a.tutisyokara::varchar(3) as tutisyokara,  --通知書№カラ
    a.tutisufkata::varchar(2) as tutisufkata,  --通知書№カラSUFIX
    a.mtdate::timestamp_ntz(9) as mtdate,  --MT日時
    a.ldts::timestamp_ntz(9) as ldts --B層取込日時
from stg_specname a
inner join stg_syasyu_tmc_sms b
    on trim(a.syasyu) = trim(b.syasyu)
