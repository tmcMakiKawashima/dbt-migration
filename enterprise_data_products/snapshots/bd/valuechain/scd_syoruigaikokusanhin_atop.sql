{% snapshot scd_syoruigaikokusanhin_atop %}

{{
    config(
        unique_key="concat_ws('-',
                    shinban)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_syoruigaikokusanhin_atop') }}

{% endsnapshot %}