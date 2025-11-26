{% snapshot scd_funahimoduke_vlc %}

{{
    config(
        unique_key="concat_ws('-',
                    shiyuichita_kbn,
                    fune_cd,
                    tumikou_cd_g,
                    departure_datetime,
                    agekou_cd_g,
                    henkanmae_cd_g,
                    send_datetime)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}


select * from {{ ref('stg_funahimoduke_vlc') }}

{% endsnapshot %}