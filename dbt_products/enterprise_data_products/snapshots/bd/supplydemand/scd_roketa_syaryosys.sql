{% snapshot scd_roketa_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    syoribi,
                    stime)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_roketa_syaryosys') }}

{% endsnapshot %}