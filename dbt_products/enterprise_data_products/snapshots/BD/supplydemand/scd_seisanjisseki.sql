{% snapshot scd_seisanjisseki %}

{{
    config(
        unique_key="concat_ws('-',
                    index_cls,
                    syadai_kt,
                    frmno,
                    iff(wmi is null, '', wmi), -- nullの場合はブランクで置き換える処理
                    iff(vds is null, '', vds),
                    iff(vis is null, '', vis))",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_seisanjisseki') }}

{% endsnapshot %}