{% snapshot scd_na_sfl_hostalc %}

{{
    config(
        unique_key="concat_ws('-',
                    psc,
                    plantcode,
                    lodate,
                    idno,
                    msgno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_na_sfl_hostalc') }}

{% endsnapshot %}