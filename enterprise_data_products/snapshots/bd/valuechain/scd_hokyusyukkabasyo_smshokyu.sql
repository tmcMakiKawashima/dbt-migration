{% snapshot scd_hokyusyukkabasyo_smshokyu %}

{{
    config(
        unique_key="concat_ws('-',
                    syusbetu,
                    hinban,
                    ruibetu,
                    kyokucd,
                    kerekijun)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hokyusyukkabasyo_smshokyu') }}

{% endsnapshot %}