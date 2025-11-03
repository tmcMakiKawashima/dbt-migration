with stg_hinbanjyoho_gsps as (
    select
        rtrim(hinban, ' 　')::varchar(15) as hinban, -- 右blank
        rtrim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 右blank
        iff(rtrim(hasseigen, ' 　') = '', null, rtrim(hasseigen, ' 　'))::varchar(2) as hasseigen, -- 右blank,空値の場合はnull
        iff(rtrim(irohinkbn, ' 　') = '', null, rtrim(irohinkbn, ' 　'))::varchar(1) as irohinkbn, -- 右blank,空値の場合はnull
        iff(rtrim(hinsinseturiyu, ' 　') = '', null, rtrim(hinsinseturiyu, ' 　'))::varchar(1) as hinsinseturiyu, -- 右blank,空値の場合はnull
        iff(rtrim(hinbanhyojikbn, ' 　') = '', null, rtrim(hinbanhyojikbn, ' 　'))::varchar(1) as hinbanhyojikbn, -- 右blank,空値の場合はnull
        iff(rtrim(seppen, ' 　') = '', null, rtrim(seppen, ' 　'))::varchar(18) as seppen, -- 右blank,空値の場合はnull
        iff(rtrim(kosincompid, ' 　') = '', null, rtrim(kosincompid, ' 　'))::varchar(5) as kosincompid, -- 右blank,空値の場合はnull
        iff(rtrim(kosinuserid, ' 　') = '', null, rtrim(kosinuserid, ' 　'))::varchar(10) as kosinuserid, -- 右blank,空値の場合はnull
        iff(rtrim(kosintime, ' 　') = '', null, rtrim(kosintime, ' 　'))::varchar(16) as kosintime, -- 右blank,空値の場合はnull
        ldts,
        line_number,
        rank() over (partition by hinban, syusbetu order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_tmjfvk03') }}
)
select * exclude(aggkey, line_number) from stg_hinbanjyoho_gsps where aggkey = 1 order by hinban asc