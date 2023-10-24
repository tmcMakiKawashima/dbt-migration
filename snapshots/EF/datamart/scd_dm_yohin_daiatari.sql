{% snapshot scd_dm_yohin_daiatari %}

{{
    config(
        unique_key="USERCD ||'-'|| KAISYA ||'-'|| DLRCD ||'-'|| TCHUMON ||'-'|| JUCHUYMD ||'-'|| HINBAN ||'-'|| IFF(CHUMON is null, '', CHUMON) ||'-'|| IFF(HACHUYMD is null, '', HACHUYMD)",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('dm_yohin_daiatari') }}

{% endsnapshot %}
