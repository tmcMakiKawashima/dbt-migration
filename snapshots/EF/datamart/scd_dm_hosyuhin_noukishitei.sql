{% snapshot scd_dm_hosyuhin_noukishitei %}

{{
    config(
        unique_key="concat_ws('-',
                    usercd,
                    dlrcd,
                    jdenno,
                    jchuymd,
                    chumon,
                    hinban)",
        
        strategy='timestamp',
        updated_at='ldts_snapshot',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('dm_hosyuhin_noukishitei') }}

{% endsnapshot %}