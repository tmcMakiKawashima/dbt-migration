{{
    config (
        materialized = 'incremental',
        unique_key = ['syasyu', 'shiyodai', 'shiyosai', 'sketa', 'skigo'],
        incremental_strategy = 'merge'
    )
}}

with stg_specname as (
    select
        syasyu::varchar(4) as syasyu,  -- なし
        siyoudai5::varchar(3) as shiyodai,  -- なし
        siyousai5::varchar(2) as shiyosai,  -- なし
        ltrim(sketa,'0')::varchar(3) as sketa,  -- 左ゼロ
        skigo::varchar(1) as skigo,  -- なし
        smeikanji::varchar(25) as smeikanji,  -- なし
        rtrim(smeikana,' 　')::varchar(25) as smeikana,  -- 右blank
        smeieiji::varchar(25) as smeieiji,  -- なし
        mtflg::varchar(1) as mtflg,  -- なし
        rtrim(sijikara,' 　')::varchar(9) as sijikara,  -- 右blank
        tutisyokara::varchar(3) as tutisyokara,  -- なし
        tutisufkata::varchar(2) as tutisufkata,  -- なし
        try_to_timestamp_ntz(mtdate , 'yyyymmddhh24missff9') as mtdate,  -- timestamp
        ldts, -- b層のldts
        row_number() over (
                partition by
                    syasyu, shiyodai, shiyosai, sketa, skigo
                order by sijikara desc, ldts desc
            ) aggkey
        from {{ ref('substr_ktrla01ezz0ka20001') }}

        {% if is_incremental() %}
            where ldts > (select max(ldts) from {{ this }})
        {% endif %}

    )
select * exclude(aggkey)
from stg_specname
where aggkey = 1
