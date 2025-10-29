{% snapshot scd_ukeirejisseki_atop %}

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
select * from {{ ref('stg_ukeirejisseki_atop') }}

{% endsnapshot %}