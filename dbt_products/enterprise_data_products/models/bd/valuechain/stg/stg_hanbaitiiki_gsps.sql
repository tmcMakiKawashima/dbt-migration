with stg_hanbaitiiki_gsps as (
    select
        rtrim(donyutiiki, ' 　')::varchar(3) as donyutiiki, -- 右blank
        iff(rtrim(hantiiki, ' 　') = '', null, rtrim(hantiiki, ' 　'))::varchar(5) as hantiiki, -- 右blank,空値の場合はnull
        iff(rtrim(hantiikijp, ' 　') = '', null, rtrim(hantiikijp, ' 　'))::varchar(10) as hantiikijp, -- 右blank,空値の場合はnull
        iff(rtrim(hantiikien, ' 　') = '', null, rtrim(hantiikien, ' 　'))::varchar(20) as hantiikien, -- 右blank,空値の場合はnull
        iff(rtrim(haisiymd, ' 　') = '', null, rtrim(haisiymd, ' 　'))::varchar(8) as haisiymd, -- 右blank,空値の場合はnull
        iff(rtrim(kosincompid, ' 　') = '', null, rtrim(kosincompid, ' 　'))::varchar(5) as kosincompid, -- 右blank,空値の場合はnull
        iff(rtrim(kosinuserid, ' 　') = '', null, rtrim(kosinuserid, ' 　'))::varchar(10) as kosinuserid, -- 右blank,空値の場合はnull
        iff(rtrim(kosintime, ' 　') = '', null, rtrim(kosintime, ' 　'))::varchar(16) as kosintime, -- 右blank,空値の場合はnull
        ldts
    from {{ ref('substr_tmjfvk02') }}
)
select * from stg_hanbaitiiki_gsps
where ldts = (select max(ldts) from stg_hanbaitiiki_gsps)