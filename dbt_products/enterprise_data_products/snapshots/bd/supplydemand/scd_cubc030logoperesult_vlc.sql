{% snapshot scd_cubc030logoperesult_vlc %}

{{
    config(
        unique_key="concat_ws('-',
                    vhc_key,
                    kyoten_cd,
                    kyoten_kaisu,
                    tp_kbn)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_cubc030logoperesult_vlc') }}

{% endsnapshot %}