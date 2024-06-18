{% snapshot scd_hanbaihikiate %}

{{
    config(
        unique_key="concat_ws('-', 
                    hanbaino,
                    kosyokata, 
                    suffix_code, 
                    shiyoudai, 
                    shiyousai)",

        strategy='timestamp',
        updated_at='dt_kosin',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_hanbaihikiate') }}

{% endsnapshot %}
