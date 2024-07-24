{{config(fail_calc="cnt")}}
-- 2-4
select count(*) as cnt
    from {{ref('dm_hosyuhin_noukishitei')}}
    where (
        jchusu is not null and syukkosu is not null
    ) and jchusu < syukkosu