{{
    config(
        materialized = 'incremental',
        unique_key = [
            'hinban',
            'seisankyoku',
            'hosyubas',
            'hantiiki',
            'syusbetu',
            'seppenjun'
        ],
        incremental_strategy = 'merge'
    )
}}

with stg_ordersakisyoninzumi_ordersaki_gsps as (
    select
        rtrim(hinban, ' 　')::varchar(15) as hinban, -- 右blank
        rtrim(seisankyoku, ' 　')::varchar(3) as seisankyoku, -- 右blank
        rtrim(hosyubas, ' 　')::varchar(6) as hosyubas, -- 右blank
        rtrim(hantiiki, ' 　')::varchar(5) as hantiiki, -- 右blank
        rtrim(syusbetu, ' 　')::varchar(4) as syusbetu, -- 右blank
        try_cast(seppenjun as number(15)) as seppenjun,
        iff(rtrim(orderjtai1, ' 　') = '', null, rtrim(orderjtai1, ' 　'))::varchar(7) as orderjtai1, -- 右blank,空値の場合はnull
        iff(rtrim(orderjtai2, ' 　') = '', null, rtrim(orderjtai2, ' 　'))::varchar(7) as orderjtai2, -- 右blank,空値の場合はnull
        iff(rtrim(orderjtai3, ' 　') = '', null, rtrim(orderjtai3, ' 　'))::varchar(7) as orderjtai3, -- 右blank,空値の場合はnull
        iff(rtrim(orderjtai4, ' 　') = '', null, rtrim(orderjtai4, ' 　'))::varchar(7) as orderjtai4, -- 右blank,空値の場合はnull
        iff(rtrim(orderjtai5, ' 　') = '', null, rtrim(orderjtai5, ' 　'))::varchar(7) as orderjtai5, -- 右blank,空値の場合はnull
        iff(rtrim(kara, ' 　') = '', null, rtrim(kara, ' 　'))::varchar(8) as kara, -- 右blank,空値の場合はnull
        iff(rtrim(made, ' 　') = '', null, rtrim(made, ' 　'))::varchar(8) as made, -- 右blank,空値の場合はnull
        iff(rtrim(motomade, ' 　') = '', null, rtrim(motomade, ' 　'))::varchar(8) as motomade, -- 右blank,空値の場合はnull
        iff(rtrim(seppen, ' 　') = '', null, rtrim(seppen, ' 　'))::varchar(18) as seppen, -- 右blank,空値の場合はnull
        iff(rtrim(hokyuyouhi, ' 　') = '', null, rtrim(hokyuyouhi, ' 　'))::varchar(1) as hokyuyouhi, -- 右blank,空値の場合はnull
        iff(rtrim(orderresetkbn, ' 　') = '', null, rtrim(orderresetkbn, ' 　'))::varchar(1) as orderresetkbn, -- 右blank,空値の場合はnull
        iff(rtrim(onkyoseihenko, ' 　') = '', null, rtrim(onkyoseihenko, ' 　'))::varchar(1) as onkyoseihenko, -- 右blank,空値の場合はnull
        iff(rtrim(dkjgenkbn, ' 　') = '', null, rtrim(dkjgenkbn, ' 　'))::varchar(1) as dkjgenkbn, -- 右blank,空値の場合はnull
        iff(rtrim(dkjgenumukbn, ' 　') = '', null, rtrim(dkjgenumukbn, ' 　'))::varchar(1) as dkjgenumukbn, -- 右blank,空値の場合はnull
        iff(rtrim(mukoflg, ' 　') = '', null, rtrim(mukoflg, ' 　'))::varchar(1) as mukoflg, -- 右blank,空値の場合はnull
        iff(rtrim(kosincompid, ' 　') = '', null, rtrim(kosincompid, ' 　'))::varchar(5) as kosincompid, -- 右blank,空値の場合はnull
        iff(rtrim(kosinuserid, ' 　') = '', null, rtrim(kosinuserid, ' 　'))::varchar(10) as kosinuserid, -- 右blank,空値の場合はnull
        iff(rtrim(kosintime, ' 　') = '', null, rtrim(kosintime, ' 　'))::varchar(16) as kosintime, -- 右blank,空値の場合はnull
        ldts,
        line_number,
        rank() over (
            partition by 
                hinban,
                seisankyoku,
                hosyubas,
                hantiiki,
                syusbetu,
                seppenjun
            order by ldts desc, line_number desc
        ) aggkey
    from {{ ref('substr_tmjfvk05') }}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select * exclude(aggkey, line_number)
from stg_ordersakisyoninzumi_ordersaki_gsps
where aggkey = 1 and seppenjun is not null
order by hinban asc