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
            as jdate
        from {{ ref('stg_tbnsyus') }}
        where gdenk = '05' and dsyubets = '1' and origin = '1'
    )
select
    ns.kyouhan,
    ns.usercd,
    ns.hinban,
    ns.mkbn,
    ns.nyukkten,
    ns.jchuymd,
    ns.jchutime,
    ns.shitei,
    ns.jdenno,
    ns.chumon,
    ns.nyukayd,
    ns.jchusu,
    ns.hchuymd,
    ns.syuka,
    ns.hkkanymd,
    ns.kakuhositei,
    ns.honbuigai,
    nk.makercd,
    ns.ldts -- snapshot作成用
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
