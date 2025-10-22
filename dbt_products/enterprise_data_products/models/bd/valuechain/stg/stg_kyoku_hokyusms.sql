with stg_kyoku_hokyusms as (
    select
        rtrim(kyokucd, ' 　')::varchar(3) as kyokucd, -- 右blank
        iff(rtrim(kyokumeiwa, ' 　') = '', null, rtrim(kyokumeiwa, ' 　'))::varchar(10) as kyokumeiwa, -- 右blank,空値の場合はnull
        iff(rtrim(kyokumeiei, ' 　') = '', null, rtrim(kyokumeiei, ' 　'))::varchar(20) as kyokumeiei, -- 右blank,空値の場合はnull
        iff(rtrim(torokud, ' 　') = '', null, rtrim(torokud, ' 　'))::varchar(8) as torokud, -- 右blank,空値の場合はnull
        iff(rtrim(torokut, ' 　') = '', null, rtrim(torokut, ' 　'))::varchar(6) as torokut, -- 右blank,空値の場合はnull
        iff(rtrim(kosind, ' 　') = '', null, rtrim(kosind, ' 　'))::varchar(8) as kosind, -- 右blank,空値の場合はnull
        iff(rtrim(kosint, ' 　') = '', null, rtrim(kosint, ' 　'))::varchar(6) as kosint, -- 右blank,空値の場合はnull
        iff(rtrim(kosinsya, ' 　') = '', null, rtrim(kosinsya, ' 　'))::varchar(16) as kosinsya, -- 右blank,空値の場合はnull
        ldts
    from {{ ref('substr_cvg01kyoku_manual') }}
)
select * from stg_kyoku_hokyusms
where ldts = (select max(ldts) from stg_kyoku_hokyusms)