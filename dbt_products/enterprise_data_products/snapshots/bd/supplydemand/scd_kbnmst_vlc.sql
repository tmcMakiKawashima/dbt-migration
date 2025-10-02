{% snapshot scd_kbnmst_vlc %}

{{
    config(
        unique_key="concat_ws('-',
                    kbn,
                    cd,
                    lang_cd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kbnmst_vlc') }}

{% endsnapshot %}