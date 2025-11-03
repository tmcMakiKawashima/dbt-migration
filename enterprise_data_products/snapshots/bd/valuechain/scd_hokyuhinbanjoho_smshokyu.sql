{% snapshot scd_hokyuhinbanjoho_smshokyu %}

{{
    config(
        unique_key="concat_ws('-',
                    syusbetu,
                    hinban,
                    ruibetu,
                    kerekijun)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hokyuhinbanjoho_smshokyu') }}

{% endsnapshot %}