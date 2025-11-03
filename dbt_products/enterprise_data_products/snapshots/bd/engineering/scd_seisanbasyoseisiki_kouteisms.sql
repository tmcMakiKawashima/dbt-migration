{% snapshot scd_seisanbasyoseisiki_kouteisms %}
{{
    config(
        unique_key="concat_ws('-',
                    syasyu,
                    tantoseikan,
                    jyokenno,
                    kata,
                    jigyoutai,
                    seisuffix,
                    genteikbn,
                    seisanbasyo
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_seisanbasyoseisiki_kouteisms') }}
{% endsnapshot %}