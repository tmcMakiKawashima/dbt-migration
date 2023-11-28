{% snapshot scd_dm_hosyuhin_tmp_juhattyuuriage %}

{{
    config(
        unique_key="concat_ws('-',
                    kyouhan,
                    usercd,
                    jdenno,
                    jchuymd,
                    chumon,
                    hinban)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('dm_hosyuhin_tmp_juhattyuuriage') }}

{% endsnapshot %}
