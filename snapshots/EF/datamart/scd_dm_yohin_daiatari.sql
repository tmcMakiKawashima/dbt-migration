{% snapshot scd_dm_yohin_daiatari %}

{{
    config(
        unique_key="concat_ws('-',
                    usercd,
                    kaisya,
                    dlrcd,
                    tchumon,
                    juchuymd,
                    iff(hinban is null, '', hinban),
                    iff(chumon is null, '', chumon),
                    iff(hachuymd is null, '', hachuymd))",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('dm_yohin_daiatari') }}

{% endsnapshot %}
