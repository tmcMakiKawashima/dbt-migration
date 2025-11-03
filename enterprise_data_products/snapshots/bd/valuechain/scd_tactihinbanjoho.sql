{% snapshot scd_tactihinbanjoho %}

{{
    config(
        unique_key="concat_ws('-',
                    toyotahin,
                    siirecd,
                    rentacti)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_tactihinbanjoho') }}

{% endsnapshot %}