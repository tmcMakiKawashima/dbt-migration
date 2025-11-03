{% snapshot scd_syaryoplbuturyukyotenplan_vlc %}

{{
    config(
        unique_key="concat_ws('-',
                    vhc_key,
                    plan_section,
                    kyoten_cd,
                    kyoten_kaisu)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syaryoplbuturyukyotenplan_vlc') }}

{% endsnapshot %}