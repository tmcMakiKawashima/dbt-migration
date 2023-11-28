{% snapshot scd_dm_yohin_tmp_juhattyuuriage %}

{{
    config(
        unique_key="concat_ws('-',
                    kyouhan,
                    usercd,
                    kaisya,
                    tchumon,
                    iff(hinban is null, '', hinban),
                    jznjusin,
                    iff(chumon is null, '', chumon),
                    iff(odersyu is null, '', odersyu),
                    iff(hattyuhi is null, '', hattyuhi))",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('dm_yohin_tmp_juhattyuuriage') }}

{% endsnapshot %}
