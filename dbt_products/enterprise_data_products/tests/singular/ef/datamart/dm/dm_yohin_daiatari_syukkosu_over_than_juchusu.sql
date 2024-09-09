{{ config(fail_calc = "cnt") }}
-- 2-4
select count(*) as cnt
    from {{ref('dm_yohin_daiatari')}}
    -- [TMP]受注数に値があり、[TMP]出庫数に値がある場合
    where juchusu is not null
    and syukkosu is not null
    -- [TMP]受注数に対して、[TMP]出庫数が大きくないかの確認
    and juchusu < syukkosu