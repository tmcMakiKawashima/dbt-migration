{{ config(snowflake_warehouse='DBT_WH') }}

with
    nokishiteijutyuchikuseki as (select * from {{ ref('stg_tbnokjs') }}),
    nyusyukko as (
        select
            *,
            case
                when denno3 <> '' then denno3
                when denno2 <> '' then denno2
                when denno1 <> '' then denno1
                else dennoj
            end as denno,
            lpad(rtrim("JDATE-Y"),length("JDATE-Y"),'0') ||
            lpad(rtrim("JDATE-M"),length("JDATE-M"),'0') ||
            lpad(rtrim("JDATE-D"),length("JDATE-D"),'0') 
            as jdate,
            lpad(rtrim("SDATE-Y"),length("SDATE-Y"),'0') ||
            lpad(rtrim("SDATE-M"),length("SDATE-M"),'0') ||
            lpad(rtrim("SDATE-D"),length("SDATE-D"),'0') 
            as sdate -- 処理日付
        from {{ ref('stg_tbnsyus') }}
        where gdenk = '05' and dsyubets = '1' and origin = '1'
    )
select
    ns.* exclude (ldts, aggkey),
    nk.makercd,
    nk.sdate,
    ns.ldts, -- snapshot作成用
    nk.kyouhan as check_kyouhan -- 共販店コード nullチェック用
from nokishiteijutyuchikuseki ns
    left outer join nyusyukko nk
        on case
            when ns.buturyuflg <> '1' then ns.kyouhan = nk.kyouhan and ns.usercd = nk.usrcod
            when ns.buturyuflg = '1' then ns.motokyouhan = nk.kyouhan and ns.motousercd = nk.usrcod
        end
        and ns.mkbn = nk.mkbn
        and ns.hinban = nk.hinban
        and ns.jchuymd = nk.jdate
        and ns.jdenno = nk.denno
        and ns.remark1 = nk.remark1
        and ns.remark2 = nk.remark2
