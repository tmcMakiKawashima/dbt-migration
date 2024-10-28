{% snapshot scd_syaryoshiyosobijoho %}

{{
    config(
        unique_key="concat_ws('-',
                    langkbn,
                    syasyu,
                    siyoptno,
                    siyocd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_syaryoshiyosobijoho') }}

{% endsnapshot %}