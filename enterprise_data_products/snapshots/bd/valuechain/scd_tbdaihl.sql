{% snapshot scd_tbdaihl %}

{{
    config(
        unique_key="KYOUHAN ||'-'|| HATUHINB ||'-'|| HATUMKBN ||'-'|| CHUMON ||'-'|| ODERSYU ||'-'|| USERCD ||'-'|| KAISYA ||'-'|| TCHUMON ||'-'|| HATTYUHI",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * from {{ ref('stg_tbdaihl') }}

{% endsnapshot %}
