with stg_siyouhenkan as (
    select
        mtkbn::varchar(1) as mtkbn,
        syasyu::varchar(4) as syasyu,
        siyoudai5::varchar(3) as shiyodai, -- 別名「shiyodai」
        siyousai5::varchar(2) as shiyosai, -- 別名「shiyosai」
        siyoudai4::varchar(3) as siyoudai4,
        siyousai4::varchar(1) as siyousai4,
        ltrim(s1keta, '0')::varchar(3) as s1keta, -- 左側0Trim
        s1kigo::varchar(1) as s1kigo,
        ltrim(s2keta, '0')::varchar(3) as s2keta, -- 左側0Trim
        s2kigo::varchar(1) as s2kigo,
        ltrim(s3keta, '0')::varchar(3) as s3keta, -- 左側0Trim
        s3kigo::varchar(1) as s3kigo,
        ctlkata::varchar(20) as ctlkata,
        tokukbn::varchar(1) as tokukbn,
        rtrim(sijikara, ' ')::varchar(9) as sijikara, -- 右側ブランクTrim
        tutisyokara::varchar(3) as tutisyokara,
        tutisufkara::varchar(2) as tutisufkara,
        tutisyomade::varchar(3) as tutisyomade,
        tutisufmade::varchar(2) as tutisufmade,
        tekikara::varchar(8) as tekikara,
        tekimade::varchar(8) as tekimade,
        mtdate::varchar(14) as mtdate,
        ldts::timestamp_ntz(9) as ldts,
        line_number,
        rank() over (partition by syasyu, shiyodai, shiyosai, s1keta, s1kigo, ctlkata order by sijikara desc, ldts desc, line_number desc) aggkey
    from {{ ref('substr_ktrla024zz0ka218')}}
)
select * exclude(mtkbn, line_number, aggkey)
from stg_siyouhenkan
where aggkey = 1 and mtkbn in ('C', 'U')