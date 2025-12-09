{% snapshot scd_kyotenmst_vlc %}

{{
    config(
        unique_key="concat_ws('-',
                    kyoten_cd,
                    tkiy_k)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kyotenmst_vlc') }}

{% endsnapshot %}