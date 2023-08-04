with DM_YOHIN_TMP_JUHATTYUURIAGE as (
    select *
    from {{ref('dm_yohin_tmp_juhattyuuriage')}} -- 用品台当りTMP受発注売上DM
    where TKSKBN in ('1', '3', '4') -- 一般直送区分
),
DM_KOKUNAI_SHINSEISAN_JISSEKI as (
    select
        HKATA, -- 販売型式
        FRMNO, -- フレームNo
        FRMKBN, -- フレーム区分
        -- VLT出力日 ※年、月、日のいずれかがブランクの場合は表示しない
        IFF(rtrim(VLT_Y)='','',
        IFF(rtrim(VLT_M)='','',
        IFF(rtrim(VLT_D)='','',
        concat(VLT_Y, VLT_M, VLT_D)))) VLT_YMD,
        -- 終検日 ※年、月、日のいずれかがブランクの場合は表示しない
        IFF(rtrim(SK_Y)='','',
        IFF(rtrim(SK_M)='','',
        IFF(rtrim(SK_D)='','',
        concat(SK_Y, SK_M, SK_D)))) SK_YMD,
        -- 配車日 ※年、月、日のいずれかがブランクの場合は表示しない
        IFF(rtrim(HAISYA_Y)='','',
        IFF(rtrim(HAISYA_M)='','',
        IFF(rtrim(HAISYA_D)='','',
        concat(HAISYA_Y, HAISYA_M, HAISYA_D)))) HAISYA_YMD
    from {{ref('dm_kokunai_shinseisan_jisseki')}} -- 国内新生産実績DM
)
select J.*,
       S.VLT_YMD, -- VLT出力日
       S.SK_YMD, -- 終検日
       S.HAISYA_YMD, -- 配車日
    --TMP納期遵守(DM_YOHIN_TMP_JUHATTYUURIAGE)
    CASE
        WHEN TRY_TO_DATE(J.SYUKKOYMD,'yyyyMMdd') is not NULL -- 出庫日
        and  TRY_TO_DATE(to_char(J.TYAKKO),'yyyyMMdd') is not NULL -- 確定着工日
            THEN
                CASE -- 出庫日が確定着工日よりも過去の場合
                    WHEN TRY_TO_DATE(J.SYUKKOYMD,'yyyyMMdd') < 
                         TRY_TO_DATE(to_char(J.TYAKKO),'yyyyMMdd')
                        THEN '◯'
                        ELSE '✕'
                END
            ELSE '未判定'
    END TMP_NOKIJUNSYU,
    --TMP納期遵守（ソート優先度）(DM_YOHIN_TMP_JUHATTYUURIAGE)
    CASE
        WHEN TRY_TO_DATE(J.SYUKKOYMD,'yyyyMMdd') is not NULL -- 出庫日
        and  TRY_TO_DATE(to_char(J.TYAKKO),'yyyyMMdd') is not NULL -- 確定着工日
            THEN 
                CASE -- 出庫日が確定着工日よりも過去の場合
                     WHEN TRY_TO_DATE(J.SYUKKOYMD,'yyyyMMdd') < 
                          TRY_TO_DATE(to_char(J.TYAKKO),'yyyyMMdd')
                        THEN 3
                        ELSE 1
                END
            ELSE 2
    END TMP_NOKIJUNSYU_PRIORITY,
    --TMP納期遅延日数（暦日）(DM_YOHIN_TMP_JUHATTYUURIAGE)
    CASE
        WHEN TRY_TO_DATE(J.SYUKKOYMD,'yyyyMMdd') is not NULL  -- 出庫日
        and  TRY_TO_DATE(to_char(J.TYAKKO),'yyyyMMdd') is not NULL -- 確定着工日
            THEN -- 出庫日 - 確定着工日
                DATEDIFF(day,TRY_TO_DATE(to_char(J.TYAKKO),'yyyyMMdd'),
                             TRY_TO_DATE(J.SYUKKOYMD,'yyyyMMdd'))
            ELSE NULL
    END TMP_NOKIOKUREDAYS,
    concat(KYOUHAN, SISHACD) SHIMUKE_CD -- 仕向先コード（共販店コード、支社コードの結合文字列）
from DM_YOHIN_TMP_JUHATTYUURIAGE J -- 用品台当りTMP受発注売上DM
left outer join DM_KOKUNAI_SHINSEISAN_JISSEKI S -- 国内新生産実績DM
on J.FRMKB = S.FRMKBN -- フレーム区分
and J.FRMNO = S.FRMNO -- フレームNo
and J.HANKATA = S.HKATA -- 販売型式