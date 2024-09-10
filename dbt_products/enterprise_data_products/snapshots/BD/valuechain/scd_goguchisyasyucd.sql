{% snapshot scd_goguchisyasyucd %}

{{
    config(
        unique_key="concat_ws('-',
                    syasyu_cd,
                    yohinsyamei)",

        strategy='timestamp',
        updated_at='kousin',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_goguchisyasyucd') }}

{% endsnapshot %}
