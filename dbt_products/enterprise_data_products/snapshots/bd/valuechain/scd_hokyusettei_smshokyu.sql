{% snapshot scd_hokyusettei_smshokyu %}

{{
    config(
        unique_key="concat_ws('-',
                    syasyu32,
                    syasyu,
                    kumitate,
                    bui,
                    vari,
                    oyahin,
                    gc,
                    kohin,
                    sepjunk)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ref('stg_hokyusettei_smshokyu')}}

{% endsnapshot %}
