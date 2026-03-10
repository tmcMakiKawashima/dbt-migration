{% snapshot scd_ugsotyakujisseki_kinto %}
{{
    config(
        unique_key="concat_ws('-',
                    iff(syadai_kt is null, '', syadai_kt),
                    iff(frm_no is null, '', frm_no),
                    iff(daibun_4 is null, '', daibun_4),
                    iff(saimoku_4 is null, '', saimoku_4),
                    iff(dai_kanji_name is null, '', dai_kanji_name),
                    iff(sai_kana_name is null, '', sai_kana_name),
                    iff(parts_cd is null, '', parts_cd),
                    iff(ruibetsu is null, '', ruibetsu),
                    iff(parts_name is null, '', parts_name),
                    iff(kosu is null, '', kosu),
                    iff(nyuko_dealer_cd is null, '', nyuko_dealer_cd),
                    iff(odo is null, '', odo),
                    iff(ug_date is null, '', ug_date),
                    ldts
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_ugsotyakujisseki_kinto') }}
{% endsnapshot %}