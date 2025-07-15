{% snapshot scd_cubc024plodplan_vlc %}

{{
    config(
        unique_key="concat_ws('-',
                    vhc_key,
                    plan_section,
                    kyoten_cd,
                    kyoten_kaisu,
                    tp_kbn)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_cubc024plodplan_vlc') }}

{% endsnapshot %}