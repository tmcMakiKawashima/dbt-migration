with stg_catalog_topacs as (
    select
        mtkbn::varchar(1) as mtkbn, 
        rtrim(catalg, ' 　')::varchar(6) as catalg, -- 右blank
        rtrim(syasyu, ' 　')::varchar(4) as syasyu, -- 右blank
        rtrim(figno, ' 　')::varchar(4) as figno, -- 右blank
        rtrim(pnc1, ' 　')::varchar(6) as pnc1, -- 右blank
        rtrim(hkhin, ' 　')::varchar(12) as hkhin, -- 右blank
        rtrim(kosu, ' 　')::varchar(3) as kosu, -- 右blank
        rtrim(jissijkara, ' 　')::varchar(6) as jissijkara, -- 右blank
        rtrim(setpospnno, ' 　')::varchar(4) as setpospnno, -- 右blank
        rtrim(bnrsiypnno, ' 　')::varchar(6) as bnrsiypnno, -- 右blank
        rtrim(trmgaihan, ' 　')::varchar(100) as trmgaihan, -- 右blank
        rtrim(katahyono, ' 　')::varchar(5) as katahyono, -- 右blank
        rtrim(hikiatetkgkbn, ' 　')::varchar(1) as hikiatetkgkbn, -- 右blank
        iff(rtrim(iromei, ' 　') = '', null, rtrim(iromei, ' 　'))::varchar(25) as iromei, -- 右blank,空値の場合はnull
        iff(rtrim(servsetkbn, ' 　') = '', null, rtrim(servsetkbn, ' 　'))::varchar(1) as servsetkbn, -- 右blank,空値の場合はnull
        iff(rtrim(hosekbn, ' 　') = '', null, rtrim(hosekbn, ' 　'))::varchar(1) as hosekbn, -- 右blank,空値の場合はnull
        iff(rtrim(hosehin, ' 　') = '', null, rtrim(hosehin, ' 　'))::varchar(12) as hosehin, -- 右blank,空値の場合はnull
        iff(rtrim(hkcom, ' 　') = '', null, rtrim(hkcom, ' 　'))::varchar(100) as hkcom, -- 右blank,空値の場合はnull
        iff(rtrim(jissijmade, ' 　') = '', null, rtrim(jissijmade, ' 　'))::varchar(6) as jissijmade, -- 右blank,空値の場合はnull
        iff(rtrim(kiricdkara, ' 　') = '', null, rtrim(kiricdkara, ' 　'))::varchar(4) as kiricdkara, -- 右blank,空値の場合はnull
        iff(rtrim(kiricdmade, ' 　') = '', null, rtrim(kiricdmade, ' 　'))::varchar(4) as kiricdmade, -- 右blank,空値の場合はnull
        iff(rtrim(genteisetkbn, ' 　') = '', null, rtrim(genteisetkbn, ' 　'))::varchar(1) as genteisetkbn, -- 右blank,空値の場合はnull
        iff(rtrim(enginek, ' 　') = '', null, rtrim(enginek, ' 　'))::varchar(1) as enginek, -- 右blank,空値の場合はnull
        iff(rtrim(refffig, ' 　') = '', null, rtrim(refffig, ' 　'))::varchar(4) as refffig, -- 右blank,空値の場合はnull
        iff(rtrim(tspnkbn, ' 　') = '', null, rtrim(tspnkbn, ' 　'))::varchar(1) as tspnkbn, -- 右blank,空値の場合はnull
        iff(rtrim(fignor1, ' 　') = '', null, rtrim(fignor1, ' 　'))::varchar(4) as fignor1, -- 右blank,空値の場合はnull
        iff(rtrim(fignor2, ' 　') = '', null, rtrim(fignor2, ' 　'))::varchar(4) as fignor2, -- 右blank,空値の場合はnull
        iff(rtrim(fignor3, ' 　') = '', null, rtrim(fignor3, ' 　'))::varchar(4) as fignor3, -- 右blank,空値の場合はnull
        iff(rtrim(kikgenkbn, ' 　') = '', null, rtrim(kikgenkbn, ' 　'))::varchar(1) as kikgenkbn, -- 右blank,空値の場合はnull
        ldts,
        line_number,
        rank() over (
            partition by 
                catalg,
                syasyu,
                figno,
                pnc1,
                hkhin,
                kosu,
                jissijkara,
                setpospnno,
                bnrsiypnno,
                trmgaihan,
                katahyono,
                hikiatetkgkbn
            order by ldts desc, line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01xzz0kv200v6') }}
)
select * exclude(aggkey, mtkbn, line_number)
from stg_catalog_topacs
where aggkey = 1 and mtkbn in (1, 4)
order by catalg asc