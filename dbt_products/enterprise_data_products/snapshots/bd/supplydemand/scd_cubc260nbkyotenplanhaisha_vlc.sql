{% snapshot scd_cubc260nbkyotenplanhaisha_vlc %}

{{
    config(
        unique_key="concat_ws('-',
                    vhc_key,
                    kyoten_cd,
                    kyoten_kaisu)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_cubc260nbkyotenplanhaisha_vlc') }}

{% endsnapshot %}