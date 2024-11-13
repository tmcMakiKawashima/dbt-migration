{% snapshot scd_name_history %}

{{
    config(
        unique_key="concat_ws('-',
                    employee_cd,
                    namhnkyukymd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_name_history') }}

{% endsnapshot %}
