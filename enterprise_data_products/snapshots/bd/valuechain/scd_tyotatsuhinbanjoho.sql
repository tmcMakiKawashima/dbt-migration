{% snapshot scd_tyotatsuhinbanjoho %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    dntikicd,
                    cthin)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_tyotatsuhinbanjoho') }}

{% endsnapshot %}