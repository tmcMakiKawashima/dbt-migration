{% snapshot scd_cvn18nosiodrjyoho_previous %}

{{
    config(
        unique_key="concat_ws('-', 
                    ordrkey, 
                    juchuymd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_cvn18nosiodrjyoho_previous') }}

{% endsnapshot %}
