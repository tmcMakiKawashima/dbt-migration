with
    temp20 as (select * from {{ ref('tmp20_dm_hosyuhin_tmp_juhattyuuriage') }}),
    bof as (select * from {{ ref('stg_tbbofll') }})
select
    temp20.* exclude (check_kyouhan),
    bof.syukkei,
    bof.ndasiymd,
    case
        when bof.kasyuu <> '' then bof.kasyuu
        else bof.usercd
    end kasyuu,
    bof.kyouhan as check_kyouhan -- 共販店コード nullチェック用
from temp20
    left outer join bof
        on temp20.kyouhan = bof.kyouhan
        and temp20.hinban = bof.hinban
        and temp20.mkbn = bof.mkbn
        and temp20.nyukkten = bof.nyukkten
        and temp20.jdenno = bof.jdenno
        and temp20.chumon = bof.chumon
        and temp20.usercd = bof.usercd
        and temp20.jchuymd = bof.jchuymd
