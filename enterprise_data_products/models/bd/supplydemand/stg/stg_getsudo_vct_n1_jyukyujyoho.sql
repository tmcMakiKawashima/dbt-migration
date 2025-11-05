{{ config(
      materialized='incremental',
      unique_key = ['plan_month', 'id_line_cd', 'sno', 'alloc_kata_cd', 'order_no', 'ske_date', 'pkg', 'ext_cd', 'trim_cd', 'int_cd', 'dest_cd', 'prod_spec', 'pcd_model_cd', 'wmi', 'vds', 'model_year'],
      incremental_strategy = 'merge'
   ) }}

with stg_getsudo_vct_n1_jyukyujyoho as (
      select
            plan_month::varchar(6) as plan_month,
            maker::varchar(4) as maker,
            id_line_cd::varchar(2) as id_line_cd,
            sno::varchar(2) as sno,
            alloc_kata_cd::varchar(5) as alloc_kata_cd,
            order_type::varchar(1) as order_type,
            pcode::varchar(1) as pcode,
            nengetu::varchar(6) as nengetu,
            order_no::varchar(5) as order_no,
            dest_detail::varchar(1) as dest_detail,
            generate_kbn::varchar(1) as generate_kbn,
            lineoff_kata_cd::varchar(5) as lineoff_kata_cd,
            n_unit::number(5,0) as n_unit,
            n1_unit::number(5,0) as n1_unit,
            n2_unit::number(5,0) as n2_unit,
            kosei_ratio::number(5,0) as kosei_ratio,
            ske_date::varchar(2) as ske_date,
            n1_unit_day::number(3,0) as n1_unit_day,
            pkg::varchar(1) as pkg,
            ext_cd::varchar(4) as ext_cd,
            trim_cd::varchar(2) as trim_cd,
            int_cd::varchar(2) as int_cd,
            dest_cd::varchar(3) as dest_cd,
            alloc_kata::varchar(20) as alloc_kata,
            frame_kbn::varchar(3) as frame_kbn,
            ctl_kata::varchar(20) as ctl_kata,
            zen_kohan_kbn::varchar(1) as zen_kohan_kbn,
            order_month::varchar(2) as order_month,
            kaso_model_kbn::varchar(1) as kaso_model_kbn,
            kd_parts_judge_kbn::varchar(1) as kd_parts_judge_kbn,
            unit_kbn::varchar(1) as unit_kbn,
            body_type::varchar(2) as body_type,
            prod_spec::varchar(200) as prod_spec,
            pcd_model_cd::varchar(2) as pcd_model_cd,
            sd_model_cd::varchar(3) as sd_model_cd,
            kihon_kata::varchar(10) as kihon_kata,
            vic_cd2::varchar(28) as vic_cd2,
            wmi::varchar(3) as wmi,
            vds::varchar(6) as vds,
            model_year::varchar(1) as model_year,
            simukekoku_cd::varchar(10) as simukekoku_cd,
            create_user::varchar(15) as create_user,
            create_date::timestamp_ntz(9) as create_date,
            update_user::varchar(15) as update_user,
            update_date::timestamp_ntz(9) as update_date,
            _fivetran_synced::timestamp_ntz(9) as ldts
      from 
            {{source('fivetran_database_oraclerds_orcl_jukyu_osamsp02sam202', 'raw_cam6295')}}
      where
            _fivetran_deleted = 'false'

      {% if is_incremental() %}
            and ldts > (select max(ldts) from {{ this }})
      {% endif %}
)
select * from stg_getsudo_vct_n1_jyukyujyoho