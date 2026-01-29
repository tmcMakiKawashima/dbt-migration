{% snapshot scd_na_sft_hostalc %}

{{
    config(
        unique_key="concat_ws('-',
                    psc,
                    plantcode,
                    lodate,
                    idno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_na_sft_hostalc') }}

{% endsnapshot %}