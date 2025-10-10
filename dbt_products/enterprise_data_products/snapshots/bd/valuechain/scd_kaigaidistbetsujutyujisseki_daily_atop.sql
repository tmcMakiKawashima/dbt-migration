{% snapshot scd_kaigaidistbetsujutyujisseki_daily_atop %}
{{
    config(
        unique_key="concat_ws('-',
                    iff(mntkbn is null, '', mntkbn),      -- nullの場合はブランクで置き換える処理
                    iff(hinban is null, '', hinban),      -- nullの場合はブランクで置き換える処理
                    iff(dlrcd is null, '', dlrcd),      -- nullの場合はブランクで置き換える処理
                    iff(odrzok is null, '', odrzok),      -- nullの場合はブランクで置き換える処理
                    iff(keikakuodrkbn is null, '', keikakuodrkbn),      -- nullの場合はブランクで置き換える処理
                    iff(odrno is null, '', odrno),      -- nullの場合はブランクで置き換える処理
                    iff(yusokbn is null, '', yusokbn),      -- nullの場合はブランクで置き換える処理
                    iff(juchuymd is null, '1970-01-01 00:00:00.000', juchuymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(juchusu7 is null, 0, juchusu7),      -- nullの場合は0で置き換える処理
                    iff(hind5 is null, 0, hind5),      -- nullの場合は0で置き換える処理
                    ldts)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kaigaidistbetsujutyujisseki_daily_atop') }}
{% endsnapshot %}