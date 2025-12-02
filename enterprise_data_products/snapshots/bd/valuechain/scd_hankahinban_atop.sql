{% snapshot scd_hankahinban_atop %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_hankahinban_atop') }}

{% endsnapshot %}