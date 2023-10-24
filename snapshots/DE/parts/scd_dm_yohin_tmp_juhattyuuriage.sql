{% snapshot scd_dm_yohin_tmp_juhattyuuriage %}

{{
    config(
        unique_key="KYOUHAN ||'-'|| USERCD ||'-'|| KAISYA ||'-'|| TCHUMON ||'-'|| HINBAN ||'-'|| JZNJUSIN ||'-'|| IFF(CHUMON is null, '', CHUMON) ||'-'|| IFF(ODERSYU is null, '', ODERSYU) ||'-'|| IFF(HATTYUHI is null, '', HATTYUHI)",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('dm_yohin_tmp_juhattyuuriage') }}

{% endsnapshot %}
