{# TAS納期管理ファイルの仕様確定次第追加 #}
with
    temp40 as (select * from {{ ref("tmp40_DM_HOSYUHIN_TMP_JUHATTYUURIAGE") }}),
    atopshimuke as (select * from {{ ref("stg_DVNP054A") }}),
    atopjuchu as (select * from {{ ref("stg_O_CVS11JYUCHUU") }}),
    hinban as (select * from {{ ref("stg_DM_PNO") }}),
    tasshimuke as (select * from {{ ref("stg_tbsmksk") }}),
    -- 納期仕向
    tasshimuke_noki as (
        select * from {{ ref("stg_tbsmksk_noki") }} where deletedate = '00000000'
    ),
    --
    tbuserm as (select * from {{ ref("stg_tbuserm") }})
select
    temp40.*,
    tbuserm.hanbaiten,
    tbuserm.kjusrnm,
    atopjuchu.tkskbn,
    atopshimuke.smkmeijpjh,
    atopshimuke.smkmeijpjs,
    hinban.pname,
    -- 納期仕向
    case
        when

            (
                (
                    (substr(temp40.chumon, 1, 1) = 'P' or substr(temp40.chumon, 1, 1) = 'Q')
                    and not (noki.kyouhan is null)
                    and temp40.odrsbetu = '11'
                    and (noki.hikizaikbn = '1' or noki.hikizaikbn = '3')
                )
                or (
                    (substr(temp40.chumon, 1, 1) = 'P' or substr(temp40.chumon, 1, 1) = 'Q')
                    and not (noki.kyouhan is null)
                    and temp40.odrsbetu = '12'
                    and (noki.hikizaikbn = '2' or noki.hikizaikbn = '3')
                )
            )
        then iff(noki.nokismkskcd is null, '', noki.nokismkskcd)
        else iff(tasshimuke.sishacd is null, '', tasshimuke.sishacd)
    end as sishacd
from temp40
left outer join atopjuchu on temp40.hinban = atopjuchu.jhinban
left outer join hinban on temp40.hinban = hinban.pno
left outer join
    tasshimuke
    on temp40.kyouhan = tasshimuke.kyouhan
    and temp40.nyukkten = tasshimuke.kyoten
left outer join
    atopshimuke
    on trim(
        concat(
            tasshimuke.kyouhan, iff(tasshimuke.sishacd is null, '', tasshimuke.sishacd)
        )
    )
    = atopshimuke.dlrcd
left outer join
    tbuserm on temp40.kyouhan = tbuserm.kyouhan and temp40.usercd = tbuserm.usrcod
-- 納期仕向
left outer join
    tasshimuke_noki noki
    on temp40.kyouhan = noki.kyouhan
    and temp40.nyukkten = noki.nyukkten
    and temp40.makercd = noki.makercd
    and case
        when temp40.makercd = '70000'
        then temp40.ktenkbn = noki.ktenkbn
        else '' = noki.ktenkbn
    end
    --
    
