with
    dm_hinban_siresaki as (select * from {{ source('parts_db_public', 'raw_dm_hinban_siresaki') }}), --品番仕入先
    stg_hinban_tmc_sms as (select distinct hinban from {{ ref('stg_hinban_tmc_sms') }}) --品番情報(トヨタ車種限定)

select
    a.hinban::varchar(10) as hinban,  --品番
    a.jtai::varchar(4) as jtai,  --事業体ｺｰﾄﾞ
    a.jtaimei::varchar(20) as jtaimei,  --調達事業体名
    a.jigyoutai::varchar(2) as jigyoutai,  --生産事業体
    a.siire::varchar(5) as siire,  --仕入先ｺｰﾄﾞ
    a.stdate::varchar(8) as stdate,  --適用開始日付
    a.smeiknj::varchar(90) as smeiknj,  --仕入先名漢字
    a.srmeiknj::varchar(24) as srmeiknj,  --仕入先略名漢字
    a.smei::varchar(60) as smei,  --仕入先名カナ
    a.srmei::varchar(20) as srmei,  --仕入先略名カナ
    a.smeir::varchar(50) as smeir,  --仕入先名ローマ字
    a.srmeir::varchar(15) as srmeir,  --仕入先略名ローマ字
    a.hinmei::varchar(120) as hinmei  --品名
from dm_hinban_siresaki a
inner join stg_hinban_tmc_sms b
    on trim(a.hinban) = trim(b.hinban)