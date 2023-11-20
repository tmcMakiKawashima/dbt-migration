{% snapshot scd_tbnoukifl %}

{{
    config(
        unique_key="concat_ws('-', 
                    kyouhan, 
                    hinban, 
                    mkbn, 
                    jchuymd, 
                    jchutime, 
                    jdenno, 
                    jdennoeda, 
                    kensu)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_tbnoukifl') }}

{% endsnapshot %}
