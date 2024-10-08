{% snapshot scd_syaryoindex %}
{{
    config(
        unique_key="concat_ws('-',
                    index_cls,
                    syadai_kt,
                    frmno,
                    iff(wmi is null, '', wmi),
                    iff(vds is null, '', vds),
                    iff(vis is null, '', vis))",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_syaryoindex') }}
{% endsnapshot %}