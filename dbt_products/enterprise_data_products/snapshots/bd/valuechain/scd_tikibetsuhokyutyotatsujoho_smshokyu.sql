{% snapshot scd_tikibetsuhokyutyotatsujoho_smshokyu %}
{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    ruibetu,
                    syaryoszoco,
                    dounyutiikicd,
                    kerekijun)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_tikibetsuhokyutyotatsujoho_smshokyu') }}

{% endsnapshot %}