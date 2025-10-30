{% snapshot scd_katasikihyogenjiki_topacs %}

{{
    config(
        unique_key="concat_ws('-',
                    catalg,
                    katahyono)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_katasikihyogenjiki_topacs') }}

{% endsnapshot %}