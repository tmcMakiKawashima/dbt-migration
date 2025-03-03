{% snapshot scd_gekkan_kadojisseki %}

{{
    config(
        unique_key="concat_ws('-',
                    send_date,
                    ym,
                    jpn_local_div,
                    areacd,
                    country_cd,
                    psc,
                    affiliate_cd,
                    plant_cd,
                    line_cd,
                    result_type_cd,
                    geoss_line,
                    shimukechi_cd,
                    iff(jpn_model_name_cd is null, '', jpn_model_name_cd::varchar),
                    iff(local_model_name_cd is null, '', local_model_name_cd::varchar),
                    unit_cd,
                    error,
                    iff(id is null, '', id),
                    syasyu_cd,
                    sno,
                    syamei,
                    de_total_cd,
                    iff(katashiki is null, '', katashiki),
                    iff(powertrain_cd is null, '', powertrain_cd::varchar),
                    oem,
                    only_for_result,
                    no_katashiki_result,
                    warning_diff_kata,
                    only_kd,
                    completion,
                    iff(employee_cd is null, '', employee_cd),
                    confirmed_flg
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_gekkan_kadojisseki') }}

{% endsnapshot %}
