{% snapshot scd_tbdaiml %}

{{
    config(
        unique_key="KYOUHAN ||'-'|| HASSIN ||'-'|| USERCD ||'-'|| KAISYA ||'-'|| TCHUMON ||'-'|| HINBAN ||'-'|| MEKAKB ||'-'|| HIKIATE1",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_tbdaiml') }}

{% endsnapshot %}
