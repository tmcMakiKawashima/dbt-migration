{% snapshot scd_daitaijoho_smshokyu %}

{{
    config(
        unique_key="concat_ws('-',
                    syusbetu,
                    hinban,
                    ruibetu,
                    daihin,
                    daihinrui,
                    kerekijun)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_daitaijoho_smshokyu' )}}

{% endsnapshot%}