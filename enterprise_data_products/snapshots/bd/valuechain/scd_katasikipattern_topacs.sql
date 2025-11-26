{% snapshot scd_katasikipattern_topacs %}

{{
    config(
        unique_key="concat_ws('-',
                    catalg,
                    syasyu,
                    katapno,
                    katano)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_katasikipattern_topacs') }}

{% endsnapshot %}