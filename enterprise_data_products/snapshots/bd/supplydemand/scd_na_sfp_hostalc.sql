{% snapshot scd_na_sfp_hostalc %}

{{
    config(
        unique_key="concat_ws('-',
                    psc,
                    plantcode,
                    lodate,
                    idno,
                    line,
                    tp)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_na_sfp_hostalc') }}

{% endsnapshot %}