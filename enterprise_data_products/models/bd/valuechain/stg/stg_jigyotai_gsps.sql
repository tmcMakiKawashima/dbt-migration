with stg_jigyotai_gsps as (
    select
        rtrim(jtai, ' 　')::varchar(7) as jtai, -- 右blank
        iff(rtrim(jtaimei, ' 　') = '', null, rtrim(jtaimei, ' 　'))::varchar(20) as jtaimei, -- 右blank,空値の場合はnull
        iff(rtrim(siirekbn, ' 　') = '', null, rtrim(siirekbn, ' 　'))::varchar(1) as siirekbn, -- 右blank,空値の場合はnull
        iff(rtrim(orderkbn, ' 　') = '', null, rtrim(orderkbn, ' 　'))::varchar(1) as orderkbn, -- 右blank,空値の場合はnull
        iff(rtrim(haisiymd, ' 　') = '', null, rtrim(haisiymd, ' 　'))::varchar(8) as haisiymd, -- 右blank,空値の場合はnull
        iff(rtrim(kosincompid, ' 　') = '', null, rtrim(kosincompid, ' 　'))::varchar(5) as kosincompid, -- 右blank,空値の場合はnull
        iff(rtrim(kosinuserid, ' 　') = '', null, rtrim(kosinuserid, ' 　'))::varchar(10) as kosinuserid, -- 右blank,空値の場合はnull
        iff(rtrim(kosintime, ' 　') = '', null, rtrim(kosintime, ' 　'))::varchar(16) as kosintime, -- 右blank,空値の場合はnull
        ldts
    from {{ ref('substr_tmjfvk01') }}
)
select * from stg_jigyotai_gsps
where ldts = (select max(ldts) from stg_jigyotai_gsps)