{% snapshot scd_chiiki %}
{{
config(
unique_key="concat_ws('-',
send_date,
areacd)",
strategy='timestamp',
updated_at='ldts',
invalidate_hard_deletes=true,
)
}}
select * from {{ ref('stg_chiiki') }}
{% endsnapshot %}