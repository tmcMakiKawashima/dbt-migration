{% snapshot scd_codekubun %}

{{
    config(
        unique_key="concat_ws('-',
                    codekbnid,
                    key)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_codekubun') }}

{% endsnapshot %}
