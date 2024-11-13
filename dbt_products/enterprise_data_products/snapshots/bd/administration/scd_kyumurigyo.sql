{% snapshot scd_kyumurigyo %}

{{
    config(
        unique_key="concat_ws('-',
                    employee_cd,
                    h2ytstayr,
                    h2ytstamon,
                    h2ytstadt,
                    h2staampmflg,
                    h2ytseqno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kyumurigyo') }}

{% endsnapshot %}
