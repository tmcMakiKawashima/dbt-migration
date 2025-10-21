{% snapshot scd_hokyuhinbancomment_smshokyu %}

{{
    config(
        unique_key="concat_ws('-',
                    syusbetu,
                    hinban,
                    ruibetu,
                    comkbn)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hokyuhinbancomment_smshokyu') }}

{% endsnapshot %}