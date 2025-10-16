{{
    config (
        materialized = 'incremental',
        unique_key = ['syasyu_cd', 'ctg_cd', 'chg_no', 'shamei', 'cnl_cd','eqp_mgr_id','eqp_cd','eqp_dtl_cd'],
        incremental_strategy = 'merge',
    )
}}
with stg_optsobisaimoku as (
    select
        car_kind_cd::varchar(4) as syasyu_cd,
        ctg_cd::varchar(1) as ctg_cd,
        chg_no::varchar(3) as chg_no,
        car_name_cd::varchar(2) as shamei,
        cnl_cd::varchar(1) as cnl_cd,
        eqp_mgr_id::varchar(9) as eqp_mgr_id,
        eqp_cd::varchar(8) as eqp_cd,
        eqp_dtl_cd::varchar(4) as eqp_dtl_cd,
        data_kbn::varchar(1) as data_kbn,
        eqp_dtl_org::varchar(150) as eqp_dtl_org,
        eqp_dtl_chg_kanji::varchar(768) as eqp_dtl_chg_kanji,
        eqp_dtl_chg::varchar(180) as eqp_dtl_chg,
        veh_eqp_cd::varchar(3) as shiyodai,
        veh_eqp_dtl_cd::varchar(4) as shiyosai,
        dsp_odr::varchar(5) as dsp_odr,
        ldts,
        row_number() over (
            partition by car_kind_cd, ctg_cd, chg_no, car_name_cd, cnl_cd, eqp_mgr_id, eqp_cd, eqp_dtl_cd
            order by ldts desc, line_number desc
        ) aggkey
    from {{ ref('substr_n8jfim06') }}
    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{this}})
    {% endif %}
)
select * exclude(aggkey) from stg_optsobisaimoku
where aggkey = 1