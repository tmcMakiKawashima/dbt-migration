{% snapshot scd_hinbantikibetsutaiouhinban_smshokyu  %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    ruibetu,
                    syaryoszoco,
                    dounyutiikicd,
                    tkerekijun)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hinbantikibetsutaiouhinban_smshokyu') }}

{% endsnapshot %}