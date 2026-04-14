with
    stg_ugsotyakujisseki_kinto as (
        select * from {{ ref('stg_ugsotyakujisseki_kinto') }}
    )
select
    rtrim(syadai_kt) as syadai_kt,
    rtrim(frm_no) as frm_no,
    rtrim(daibun_4) as daibun4,
    rtrim(saimoku_4) as saimoku4,
    rtrim(dai_kanji_name) as dai_kanji_name,
    rtrim(sai_kana_name) as sai_kana_name,
    rtrim(parts_cd) as parts_cd,
    rtrim(ruibetsu) as ruibetsu,
    rtrim(parts_name) as parts_name,
    rtrim(kosu) as kosu,
    rtrim(nyuko_dealer_cd) as nyuko_dealer_cd,
    rtrim(odo) as odo,
    rtrim(ug_date) as ug_date,
    ldts as load_date
from stg_ugsotyakujisseki_kinto
