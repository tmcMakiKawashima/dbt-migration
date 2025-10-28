{% snapshot scd_juchushiyo_kanri_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    shamei,
                    sno,
                    dfsc)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_juchushiyo_kanri_syaryosys') }}

{% endsnapshot %}