{% snapshot scd_zaiko_atop %}
{{
    config(
        unique_key="concat_ws('-',
                    iff(hinban is null, '', hinban),      -- nullの場合はブランクで置き換える処理
                    iff(kaknoukbn is null, '', kaknoukbn),      -- nullの場合はブランクで置き換える処理
                    iff(zaikosu is null, 0, zaikosu),      -- nullの場合は0で置き換える処理
                    iff(jknsu is null, 0, jknsu),      -- nullの場合は0で置き換える処理
                    iff(ksyuzsu is null, 0, ksyuzsu),      -- nullの場合は0で置き換える処理
                    iff(tknkruisu is null, 0, tknkruisu),      -- nullの場合は0で置き換える処理
                    iff(tkskruisu is null, 0, tkskruisu),      -- nullの場合は0で置き換える処理
                    iff(nsksutsu is null, 0, nsksutsu),      -- nullの場合は0で置き換える処理
                    iff(snttssu is null, 0, snttssu),      -- nullの場合は0で置き換える処理
                    iff(torsaisu is null, 0, torsaisu),      -- nullの場合は0で置き換える処理
                    iff(kpksutsu is null, 0, kpksutsu),      -- nullの場合は0で置き換える処理
                    iff(skdsu is null, 0, skdsu),      -- nullの場合は0で置き換える処理
                    iff(jcukztsruisu is null, 0, jcukztsruisu),      -- nullの場合は0で置き換える処理
                    iff(mtuserid is null, '', mtuserid),      -- nullの場合はブランクで置き換える処理
                    iff(mttime is null, '1970-01-01 00:00:00.000', mttime),      -- nullの場合は日付初期値で置き換える処理
                    ldts)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_zaiko_atop') }}
{% endsnapshot %}