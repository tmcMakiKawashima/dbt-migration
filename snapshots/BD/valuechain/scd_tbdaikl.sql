{% snapshot scd_tbdaikl %}

{{
    config(
        unique_key="KYOUHAN ||'-'|| HASSIN ||'-'|| USERCD ||'-'|| KAISYA ||'-'|| TCHUMON ||'-'|| JZNJUSIN",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_tbdaikl') }}

{% endsnapshot %}
