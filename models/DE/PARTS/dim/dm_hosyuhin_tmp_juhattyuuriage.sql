with
    dm_hosyuhin_tmp_juhattyuuriage as (
        select
            kyouhan,
            hanbaiten,
            usercd,
            kjusrnm,
            makercd,
            tkskbn,
            jdenno,
            jchuymd,
            shitei,
            hinban,
            pname,
            jchusu,
            chumon,
            chuzan_hchuymd hchuymd,
            nyukayd,
            syuka,
            hkkanymd,
            syukkei,
            ndasiymd,
            nokiymd,
            sishacd siten,
            smkmeijpjh,
            smkmeijpjs,
            syukayotei_min,
            syukayoteibinno_min,
            syukayotei_prev,
            syukayoteibinno_prev,
            syukayotei_max,
            syukayoteibinno_max,
            kakuhositei,
            honbuigai
        from {{ ref('tmp50_dm_hosyuhin_tmp_juhattyuuriage') }}
    )
select *
from dm_hosyuhin_tmp_juhattyuuriage
