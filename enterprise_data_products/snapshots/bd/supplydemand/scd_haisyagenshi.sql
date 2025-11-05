{% snapshot scd_haisyagenshi %}

{{
    config(
        unique_key="concat_ws('-', 
                    frmno,
                    hkata, 
                    frmkbn, 
                    shamei, 
                    sno)",

        strategy='timestamp',
        updated_at='mtdate',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_haisyagenshi') }}

{% endsnapshot %}
