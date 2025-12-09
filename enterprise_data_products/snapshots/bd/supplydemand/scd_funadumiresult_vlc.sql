{% snapshot scd_funadumiresult_vlc %}

{{
    config(
        unique_key="concat_ws('-',
                    vesselcode,
                    kitencd,
                    departuredate,
                    vhcuniqinfo)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}


select * from {{ ref('stg_funadumiresult_vlc') }}

{% endsnapshot %}