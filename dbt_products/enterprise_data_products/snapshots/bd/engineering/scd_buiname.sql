{% snapshot scd_buiname %}

{{
    config(
        unique_key="concat_ws('-',
                    syasyu_cd,
                    kumitate,
                    bui
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_buiname') }}

{% endsnapshot %}