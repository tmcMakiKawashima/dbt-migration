{% snapshot scd_seisanpattern_syasyumei %}

{{
    config(
        unique_key="concat_ws('-',
                    send_date,
                    jpn_local_div,
                    model_name_cd
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_seisanpattern_syasyumei') }}

{% endsnapshot %}
