{% snapshot scd_kd_cbu_henkan %}

{{
    config(
        unique_key="concat_ws('-',
                    send_date,
                    areacd,
                    country_cd,
                    psc,
                    affiliate_cd,
                    plant_cd,
                    line_cd,
                    geoss_line,
                    shimukechi_cd,
                    syasyu_cd,
                    sno,
                    syamei,
                    jpn_syasyu_cd,
                    jpn_sno,
                    jpn_syamei
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kd_cbu_henkan') }}

{% endsnapshot %}
