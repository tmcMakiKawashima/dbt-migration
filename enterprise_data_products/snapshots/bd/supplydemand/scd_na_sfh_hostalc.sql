{% snapshot scd_na_sfh_hostalc %}

{{
    config(
        unique_key="concat_ws('-',
                    psc,
                    plantcode,
                    lodate,
                    idno,
                    line,
                    tp,
                    prsnttptype,
                    times)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_na_sfh_hostalc') }}

{% endsnapshot %}