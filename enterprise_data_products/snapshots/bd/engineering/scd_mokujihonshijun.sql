{% snapshot scd_mokujihonshijun %}
{{
    config(
        unique_key="concat_ws('-',
                    jigyoutai,
                    syasyu_cd,
                    iff(seppenno is null, '', seppenno),
                    torokujun
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_mokujihonshijun') }}
{% endsnapshot %}