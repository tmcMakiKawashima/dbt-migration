{{ config(snowflake_warehouse='DBT_WH') }}

with dm_yohin_tmp_juhattyuuriage as (
    select *
    from {{ref('dm_yohin_tmp_juhattyuuriage')}} -- 用品台当りtmp受発注売上dm
    where tkskbn in ('1', '3', '4') -- 一般直送区分
),
dm_kokunai_shinseisan_jisseki as (
    select
        hkata, -- 販売型式
        frmno, -- フレームno
        frmkbn, -- フレーム区分
        -- vlt出力日 ※年、月、日のいずれかがブランクの場合は表示しない
        iff(rtrim(vlt_y)='','',
        iff(rtrim(vlt_m)='','',
        iff(rtrim(vlt_d)='','',
        concat(vlt_y, vlt_m, vlt_d)))) vlt_ymd,
        -- 終検日 ※年、月、日のいずれかがブランクの場合は表示しない
        iff(rtrim(sk_y)='','',
        iff(rtrim(sk_m)='','',
        iff(rtrim(sk_d)='','',
        concat(sk_y, sk_m, sk_d)))) sk_ymd,
        -- 配車日 ※年、月、日のいずれかがブランクの場合は表示しない
        iff(rtrim(haisya_y)='','',
        iff(rtrim(haisya_m)='','',
        iff(rtrim(haisya_d)='','',
        concat(haisya_y, haisya_m, haisya_d)))) haisya_ymd
    from {{ref('dm_kokunai_shinseisan_jisseki')}} -- 国内新生産実績dm
)
select j.*,
       s.vlt_ymd, -- vlt出力日
       s.sk_ymd, -- 終検日
       s.haisya_ymd, -- 配車日
    --tmp納期遵守(dm_yohin_tmp_juhattyuuriage)
    case 
        when try_to_date(j.syukkoymd,'yyyyMMdd') is not null -- 出庫日がnullでない
         and try_to_date(to_char(j.tyakko),'yyyyMMdd') is not null -- 確定着工日がnullでない
        then
            case -- （TMP）出庫日が（販売店）着工日より過去の場合
                when try_to_date(j.syukkoymd,'yyyyMMdd') < 
                     try_to_date(to_char(j.tyakko),'yyyyMMdd')
                then
                    case
                        when syukkosu >= jutyusu
                        then '◯'    -- (TMP)出庫数が(TMP)受注数以上
                        else '未判定' -- (TMP)出庫数が(TMP)受注数未満
                    end
                else '✕' -- （TMP）出庫日が（販売店）着工日より過去でない場合
            end
        else '未判定' -- 上記に該当しない場合
    end tmp_nokijunsyu,
    --tmp納期遵守（ソート優先度）(dm_yohin_tmp_juhattyuuriage)
    case
        when try_to_date(j.syukkoymd,'yyyyMMdd') is not null -- 出庫日がnullでない
         and try_to_date(to_char(j.tyakko),'yyyyMMdd') is not null -- 確定着工日がnullでない
        then 
            case --  （TMP）出庫日が（販売店）着工日より過去の場合
                when try_to_date(j.syukkoymd,'yyyyMMdd') < 
                     try_to_date(to_char(j.tyakko),'yyyyMMdd')
                then
                    case
                        when syukkosu >= jutyusu
                        then 3 -- (TMP)出庫数が(TMP)受注数以上
                        else 2 -- (TMP)出庫数が(TMP)受注数未満
                    end
                else 1 -- （TMP）出庫日が（販売店）着工日より過去でない場合
            end
        else 2 -- 上記に該当しない場合
    end tmp_nokijunsyu_priority,
    --tmp納期遅延日数（暦日）(dm_yohin_tmp_juhattyuuriage)
    case
        when try_to_date(j.syukkoymd,'yyyyMMdd') is not null  -- 出庫日
        and  try_to_date(to_char(j.tyakko),'yyyyMMdd') is not null -- 確定着工日
            then -- 出庫日 - 確定着工日
                datediff(day,try_to_date(to_char(j.tyakko),'yyyyMMdd'),
                             try_to_date(j.syukkoymd,'yyyyMMdd'))
            else null
    end tmp_nokiokuredays,
    concat(kyouhan, sishacd) shimuke_cd -- 仕向先コード（共販店コード、支社コードの結合文字列）
from dm_yohin_tmp_juhattyuuriage j -- 用品台当りtmp受発注売上dm
left outer join dm_kokunai_shinseisan_jisseki s -- 国内新生産実績dm
on j.frmkb = s.frmkbn -- フレーム区分
and j.frmno = s.frmno -- フレームno
and j.hankata = s.hkata -- 販売型式