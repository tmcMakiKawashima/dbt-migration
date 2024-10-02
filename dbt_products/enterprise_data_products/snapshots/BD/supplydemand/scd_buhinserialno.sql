{% snapshot scd_buhinserialno %}

{{
    config(
        unique_key="concat_ws('-',
                    index_cls,
                    syadai_kt,
                    frmno,
                    iff(wmi is null, '', wmi),
                    iff(vds is null, '', vds),
                    iff(vis is null, '', vis),
                    iff(parts_id is null, '', parts_id),
                    iff(parts_repl_seq is null, '', parts_repl_seq))",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_buhinserialno') }}

{% endsnapshot %}
