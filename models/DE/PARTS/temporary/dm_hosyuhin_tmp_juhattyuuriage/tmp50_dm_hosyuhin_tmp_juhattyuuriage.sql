{# TAS納期管理ファイルの仕様確定次第追加 #}
with
    temp40 as (select * from {{ ref('tmp40_dm_hosyuhin_tmp_juhattyuuriage') }}),
    atopjuchu as (select * from {{ ref('stg_o_cvs11jyuchuu') }}),
    hinban as (select * from {{ ref('stg_dm_pno') }}),
    tasshimuke as (select * from {{ ref('stg_tbsmksk') }}),
    atopshimuke as (select * from {{ ref('stg_dvnp054a') }}),
    tbuserm as (select * from {{ ref('stg_tbuserm') }})
select
    temp40.*,
    tbuserm.hanbaiten,
    tbuserm.kjusrnm,
    atopjuchu.tkskbn,
    atopshimuke.smkmeijpjh,
    atopshimuke.smkmeijpjs,
    hinban.pname,
    tasshimuke.sishacd
from temp40
    left outer join atopjuchu
        on temp40.hinban = atopjuchu.jhinban
    left outer join hinban
        on temp40.hinban = hinban.pno
    left outer join tasshimuke
        on temp40.kyouhan = tasshimuke.kyouhan
        and temp40.nyukkten = tasshimuke.kyoten
    left outer join atopshimuke
        on concat(
            tasshimuke.kyouhan, tasshimuke.sishacd
        ) = atopshimuke.dlrcd
    left outer join tbuserm
        on temp40.kyouhan = tbuserm.kyouhan
        and temp40.usercd = tbuserm.usrcod
