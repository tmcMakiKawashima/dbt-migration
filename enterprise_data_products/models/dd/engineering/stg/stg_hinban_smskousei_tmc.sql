with
    stg_hinban as (select * from {{ ref('stg_hinban') }}), --品番情報
    stg_syasyu_aisac_tmc as (select distinct syasyu from {{ ref('stg_syasyu_aisac_tmc') }}) --車種(トヨタ車種限定)

select
    a.hinban::varchar(10) as hinban, --品番
    a.kekka::varchar(1) as kekka, --取得結果
    a.minor::varchar(2) as minor, --マイナ/特設符号
    a.hinmei::varchar(120) as hinmei, --品名
    a.syasyu::varchar(4) as syasyu, --設定車種コード
    a.zaisitu::varchar(41) as zaisitu, --材質
    a.itaatu::varchar(40) as itaatu, --板厚
    a.zu::varchar(1) as zu, --図面有無(紙)
    a.zu2d::varchar(1) as zu2d, --図面有無(2D)
    a.zu3d::varchar(1) as zu3d, --図面有無(3D)
    a.com21::varchar(54) as com21, --品番コメント21
    a.com22::varchar(54) as com22, --品番コメント22
    a.com23::varchar(54) as com23, --品番コメント23
    a.com24::varchar(54) as com24, --品番コメント24
    a.com29::varchar(54) as com29, --品番コメント29
    a.com30::varchar(54) as com30, --品番コメント30
    a.seppen::varchar(10) as seppen, --設変No.
    a.torokutime::timestamp_ntz(6) as torokutime --登録日時
from stg_hinban a
inner join stg_syasyu_aisac_tmc b
    on trim(a.syasyu) = trim(b.syasyu)