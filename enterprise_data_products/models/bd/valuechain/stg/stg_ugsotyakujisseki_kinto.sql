{{
    config(
        materialized='incremental',
        incremental_strategy = 'append',
        pre_hook="
          {% if is_incremental() %}
            delete from {{this}} as a
              using (select
                iff(syadai_kt = '', null, syadai_kt) as syadai_kt,
                iff(frm_no = '', null, frm_no) as frm_no,
                iff(daibun_4 = '', null, daibun_4) as daibun_4,
                iff(saimoku_4 = '', null, saimoku_4) as saimoku_4,
                iff(sai_kana_name = '', null, sai_kana_name) as sai_kana_name,
                iff(parts_cd = '', null, parts_cd) as parts_cd,
                iff(ruibetsu = '', null, ruibetsu) as ruibetsu,
                iff(parts_name = '', null, parts_name) as parts_name,
                iff(kosu = '', null, kosu) as kosu,
                iff(nyuko_dealer_cd = '', null, nyuko_dealer_cd) as nyuko_dealer_cd,
                iff(odo = '', null, odo) as odo,
                iff(ug_date = '', null, ug_date) as ug_date
                from {{ref('extract_vinhisfile')}}
                where updatekbn = '1' and
                  ldts > (select max(ldts) from {{this}})
              ) as b
            where
              (a.syadai_kt = b.syadai_kt or (a.syadai_kt is null and b.syadai_kt is null)) and
              (a.frm_no = b.frm_no or (a.frm_no is null and b.frm_no is null)) and
              (a.daibun_4 = b.daibun_4 or (a.daibun_4 is null and b.daibun_4 is null)) and
              (a.saimoku_4 = b.saimoku_4 or (a.saimoku_4 is null and b.saimoku_4 is null)) and
              (a.sai_kana_name = b.sai_kana_name or (a.sai_kana_name is null and b.sai_kana_name is null)) and
              (a.parts_cd = b.parts_cd or (a.parts_cd is null and b.parts_cd is null)) and
              (a.ruibetsu = b.ruibetsu or (a.ruibetsu is null and b.ruibetsu is null)) and
              (a.parts_name = b.parts_name or (a.parts_name is null and b.parts_name is null)) and
              (a.kosu = b.kosu or (a.kosu is null and b.kosu is null)) and
              (a.nyuko_dealer_cd = b.nyuko_dealer_cd or (a.nyuko_dealer_cd is null and b.nyuko_dealer_cd is null)) and
              (a.odo = b.odo or (a.odo is null and b.odo is null)) and
              (a.ug_date = b.ug_date or (a.ug_date is null and b.ug_date is null))
          {% endif %}
        "
    )
}}
--更新区分'1'(削除)の場合、データの物理削除が必要のためpre_hookにて該当データの削除を行う。

with
    stg_ugsotyakujisseki_kinto as (
        select
            iff(syadai_kt = '', null, syadai_kt)::varchar(9) as syadai_kt, --なし
            iff(frm_no = '', null, frm_no)::varchar(7) as frm_no, --なし
            iff(daibun_4 = '', null, daibun_4)::varchar(3) as daibun_4, --なし
            iff(saimoku_4 = '', null, saimoku_4)::varchar(1) as saimoku_4, --なし
            null::varchar(800) as dai_kanji_name, --なし
            iff(sai_kana_name = '', null, sai_kana_name)::varchar(800) as sai_kana_name, --なし
            iff(parts_cd = '', null, parts_cd)::varchar(10) as parts_cd, --なし
            iff(ruibetsu = '', null, ruibetsu)::varchar(2) as ruibetsu, --なし
            iff(parts_name = '', null, parts_name)::varchar(60) as parts_name, --なし
            iff(kosu = '', null, kosu)::varchar(3) as kosu, --なし
            iff(nyuko_dealer_cd = '', null, nyuko_dealer_cd)::varchar(400) as nyuko_dealer_cd, --なし
            iff(odo = '', null, odo)::varchar(7) as odo, --なし
            iff(ug_date = '', null, ug_date)::varchar(8) as ug_date, --なし
            ldts::timestamp_ntz(9) as ldts -- timestamp型
        from {{ ref('extract_vinhisfile') }}
        where
            (ug_date is not null) and trim(ug_date) <> '' and updatekbn = '0'

            {% if is_incremental() %}
                and ldts > (select max(ldts) from {{ this }})
            {% endif %}
    )
select * from stg_ugsotyakujisseki_kinto
