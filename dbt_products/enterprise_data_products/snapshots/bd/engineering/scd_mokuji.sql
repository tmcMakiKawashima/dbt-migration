{% snapshot scd_mokuji %}

{{
    config(
        unique_key="concat_ws('-',
                    syasyu32,
                    syasyu_cd,
                    kumitate,
                    bui,
                    kosyokt,
                    vari,
                    torokujunk,
                    hikikey)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_mokuji') }}

{% endsnapshot %}