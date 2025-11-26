{% snapshot scd_knm_nrksortjun_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    shamei,
                    sno,
                    kncode)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_knm_nrksortjun_syaryosys') }}

{% endsnapshot %}