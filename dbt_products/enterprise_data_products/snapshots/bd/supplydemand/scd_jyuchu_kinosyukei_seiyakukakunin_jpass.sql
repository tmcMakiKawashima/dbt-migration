{% snapshot scd_jyuchu_kinosyukei_seiyakukakunin_jpass %}
{{
    config(
        unique_key="concat_ws('-',
                    ym
                    ,caltimingkbn
                    ,shamei
                    ,sno
                    ,shinq
                    ,nijsym
                    ,kncode
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_jyuchu_kinosyukei_seiyakukakunin_jpass') }}
{% endsnapshot %}