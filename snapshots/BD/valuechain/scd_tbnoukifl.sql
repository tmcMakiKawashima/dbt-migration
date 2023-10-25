{% snapshot scd_tbnoukifl %}

{{
    config(
        unique_key="kyouhan ||'-'|| hinban ||'-'|| mkbn ||'-'|| 
                    jchuymd ||'-'|| jchutime ||'-'|| jdenno ||'-'|| 
                    jdennoeda ||'-'|| kensu",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_tbnoukifl') }}

{% endsnapshot %}
