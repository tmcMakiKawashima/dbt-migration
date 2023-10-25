{% snapshot scd_tbnokjs %}

{{
    config(
        unique_key="kyouhan ||'-'|| usercd ||'-'|| hinban ||'-'|| 
                    mkbn ||'-'|| nyukkten ||'-'|| 
                    concat(left(chumon, 1), right(chumon, 3)) ||'-'|| 
                    jchuymd",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_tbnokjs') }}

{% endsnapshot %}
