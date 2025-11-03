{% snapshot scd_hakkokatasiki_topacs %}

{{
    config(
        unique_key="concat_ws('-',
                    catalg,
                    syasyu,
                    kosho)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hakkokatasiki_topacs') }}

{% endsnapshot %}