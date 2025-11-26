with stg_hakkokatasiki_topacs as (
    select
        mtkbn::varchar(1) as mtkbn, 
        rtrim(catalg, ' 　')::varchar(6) as catalg, -- 右blank
        rtrim(syasyu, ' 　')::varchar(4) as syasyu, -- 右blank
        rtrim(kosho, ' 　')::varchar(20) as kosho, -- 右blank
        iff(rtrim(ctl, ' 　') = '', null, rtrim(ctl, ' 　'))::varchar(20) as ctl, -- 右blank,空値の場合はnull
        iff(rtrim(jissijkara, ' 　') = '', null, rtrim(jissijkara, ' 　'))::varchar(6) as jissijkara, -- 右blank,空値の場合はnull
        iff(rtrim(jissijmade, ' 　') = '', null, rtrim(jissijmade, ' 　'))::varchar(6) as jissijmade, -- 右blank,空値の場合はnull
        iff(rtrim(syakano, ' 　') = '', null, rtrim(syakano, ' 　'))::varchar(3) as syakano, -- 右blank,空値の場合はnull
        iff(rtrim(ctlgkatno, ' 　') = '', null, rtrim(ctlgkatno, ' 　'))::varchar(3) as ctlgkatno, -- 右blank,空値の場合はnull
        iff(rtrim(katatokuengine1, ' 　') = '', null, rtrim(katatokuengine1, ' 　'))::varchar(10) as katatokuengine1, -- 右blank,空値の場合はnull
        iff(rtrim(katatokuengine2, ' 　') = '', null, rtrim(katatokuengine2, ' 　'))::varchar(10) as katatokuengine2, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku1, ' 　') = '', null, rtrim(katatokutoku1, ' 　'))::varchar(5) as katatokutoku1, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku2, ' 　') = '', null, rtrim(katatokutoku2, ' 　'))::varchar(5) as katatokutoku2, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku3, ' 　') = '', null, rtrim(katatokutoku3, ' 　'))::varchar(5) as katatokutoku3, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku4, ' 　') = '', null, rtrim(katatokutoku4, ' 　'))::varchar(5) as katatokutoku4, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku5, ' 　') = '', null, rtrim(katatokutoku5, ' 　'))::varchar(5) as katatokutoku5, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku6, ' 　') = '', null, rtrim(katatokutoku6, ' 　'))::varchar(5) as katatokutoku6, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku7, ' 　') = '', null, rtrim(katatokutoku7, ' 　'))::varchar(5) as katatokutoku7, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku8, ' 　') = '', null, rtrim(katatokutoku8, ' 　'))::varchar(5) as katatokutoku8, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku9, ' 　') = '', null, rtrim(katatokutoku9, ' 　'))::varchar(5) as katatokutoku9, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku10, ' 　') = '', null, rtrim(katatokutoku10, ' 　'))::varchar(5) as katatokutoku10, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku11, ' 　') = '', null, rtrim(katatokutoku11, ' 　'))::varchar(5) as katatokutoku11, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku12, ' 　') = '', null, rtrim(katatokutoku12, ' 　'))::varchar(5) as katatokutoku12, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku13, ' 　') = '', null, rtrim(katatokutoku13, ' 　'))::varchar(5) as katatokutoku13, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku14, ' 　') = '', null, rtrim(katatokutoku14, ' 　'))::varchar(5) as katatokutoku14, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku15, ' 　') = '', null, rtrim(katatokutoku15, ' 　'))::varchar(5) as katatokutoku15, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku16, ' 　') = '', null, rtrim(katatokutoku16, ' 　'))::varchar(5) as katatokutoku16, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku17, ' 　') = '', null, rtrim(katatokutoku17, ' 　'))::varchar(5) as katatokutoku17, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku18, ' 　') = '', null, rtrim(katatokutoku18, ' 　'))::varchar(5) as katatokutoku18, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku19, ' 　') = '', null, rtrim(katatokutoku19, ' 　'))::varchar(5) as katatokutoku19, -- 右blank,空値の場合はnull
        iff(rtrim(katatokutoku20, ' 　') = '', null, rtrim(katatokutoku20, ' 　'))::varchar(5) as katatokutoku20, -- 右blank,空値の場合はnull
        iff(rtrim(stdkata, ' 　') = '', null, rtrim(stdkata, ' 　'))::varchar(7) as stdkata, -- 右blank,空値の場合はnull
        iff(rtrim(ikkatu, ' 　') = '', null, rtrim(ikkatu, ' 　'))::varchar(11) as ikkatu, -- 右blank,空値の場合はnull
        ldts,
        line_number,
        rank() over (
            partition by 
                catalg,
                syasyu,
                kosho
            order by ldts desc, line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01xzz0kv200v9') }}
)
select * exclude(aggkey, mtkbn, line_number)
from stg_hakkokatasiki_topacs
where aggkey = 1 and mtkbn in (1, 4)
order by catalg asc