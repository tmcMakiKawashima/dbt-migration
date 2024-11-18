{% snapshot scd_ido_history %}

{{
    config(
        unique_key="concat_ws('-',
                    employee_cd,
                    idorekstaymd,
                    syozoku_cd_honrai)",


        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_ido_history') }}

{% endsnapshot %}
