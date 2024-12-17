{% snapshot scd_shiyopattern %}

{{
    config(
        unique_key="concat_ws('-',
                    syasyu_cd,
                    siyoptno,
                    siyocd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_shiyopattern') }}

{% endsnapshot %}