{% snapshot scd_daitaihinbanjoho %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    hnbtikicd,
                    dthin)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_daitaihinbanjoho') }}

{% endsnapshot %}