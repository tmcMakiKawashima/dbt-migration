with DM_TMP_JUHATTYUURIAGE as (
    select *, COALESCE(SYUKKASU_J,0) + COALESCE(SYUKKASU_1,0) + COALESCE(SYUKKASU_2,0) + COALESCE(SYUKKASU_3,0) SYUKKOSU
    from {{ref('DM_YOHIN_TMP_JUHATTYUURIAGE')}}
    where TKSKBN in ('1', '3', '4')
),
DM_KOKUNAI_SHINSEISAN_JISSEKI as (
    select
        HKATA, FRMNO, FRMKBN, concat(VLT_Y, VLT_M, VLT_D) VLT_YMD, 
        concat(SK_Y, SK_M, SK_D) SK_YMD, concat(HAISYA_Y, HAISYA_M, HAISYA_D) HAISYA_YMD
    from {{ref('DM_KOKUNAI_SHINSEISAN_JISSEKI')}}
)
select J.*, S.VLT_YMD, S.SK_YMD, S.HAISYA_YMD,
    --TMP納期遵守(DM_YOHIN_TMP_JUHATTYUURIAGE)
    CASE
        WHEN TRY_TO_DATE(SYUKKOYMD,'yyyyMMdd') is not NULL and  TRY_TO_DATE(to_char(TYAKKO),'yyyyMMdd') is not NULL THEN
            CASE
                WHEN TRY_TO_DATE(SYUKKOYMD,'yyyyMMdd') < TRY_TO_DATE(to_char(TYAKKO),'yyyyMMdd') THEN
                    CASE
                        WHEN JUTYUSU = SYUKKOSU THEN '◯'
                        ELSE '✕'
                    END
                ELSE '✕'
            END
        ELSE '未判定'
    END TMP_NOKIJUNSYU,
    --TMP納期遵守（ソート優先度）
    CASE
        WHEN TRY_TO_DATE(SYUKKOYMD,'yyyyMMdd') is not NULL and  TRY_TO_DATE(to_char(TYAKKO),'yyyyMMdd') is not NULL THEN
            CASE
                WHEN TRY_TO_DATE(SYUKKOYMD,'yyyyMMdd') < TRY_TO_DATE(to_char(TYAKKO),'yyyyMMdd') THEN
                    CASE
                        WHEN JUTYUSU = SYUKKOSU THEN 3
                        ELSE 1
                    END
                ELSE 1
            END
        ELSE 2
    END TMP_NOKIJUNSYU_PRIORITY,
    --TMP納期遅延日数（暦日）
    CASE
        WHEN TRY_TO_DATE(SYUKKOYMD,'yyyyMMdd') is not NULL and  TRY_TO_DATE(to_char(TYAKKO),'yyyyMMdd') is not NULL THEN
            CASE
                WHEN TRY_TO_DATE(SYUKKOYMD,'yyyyMMdd') < TRY_TO_DATE(to_char(TYAKKO),'yyyyMMdd') THEN
                    CASE
                        WHEN JUTYUSU = SYUKKOSU THEN NULL
                        ELSE DATEDIFF(day,TRY_TO_DATE(to_char(TYAKKO),'yyyyMMdd'),TRY_TO_DATE(SYUKKOYMD,'yyyyMMdd'))
                    END
                ELSE DATEDIFF(day,TRY_TO_DATE(to_char(TYAKKO),'yyyyMMdd'),TRY_TO_DATE(SYUKKOYMD,'yyyyMMdd'))
            END
        ELSE NULL
    END TMP_NOKIOKUREDAYS,
    concat(KYOUHAN, SISHACD) SHIMUKE_CD
from DM_YOHIN_TMP_JUHATTYUURIAGE J
left outer join DM_KOKUNAI_SHINSEISAN_JISSEKI S
on J.FRMKB = S.FRMKBN
and J.FRMNO = S.FRMNO
and J.HANKATA = S.HKATA