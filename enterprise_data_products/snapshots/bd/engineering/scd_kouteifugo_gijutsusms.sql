{% snapshot scd_kouteifugo_gijutsusms %}
{{
    config(
        unique_key="concat_ws('-',
                    ktfgo
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kouteifugo_gijutsusms') }}
{% endsnapshot %}