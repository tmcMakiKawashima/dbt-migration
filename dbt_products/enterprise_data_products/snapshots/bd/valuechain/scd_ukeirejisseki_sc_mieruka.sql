{% snapshot scd_ukeirejisseki_sc_mieruka %}

{{
    config(
        unique_key="concat_ws('-',
                    kaknokyotnkbn,
                    tyotathb,
                    srsirskcd,
                    brsirskcd,
                    nnymd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_ukeirejisseki_sc_mieruka') }}

{% endsnapshot %}