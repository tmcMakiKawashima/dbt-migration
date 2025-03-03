{% snapshot scd_goguchisyasyucd %}

{{
    config(
        unique_key="concat_ws('-',
                    syasyu_cd,
                    yohinsyamei)",

        strategy='timestamp',
        updated_at='kousin',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_goguchisyasyucd') }}

{% endsnapshot %}
