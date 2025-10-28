with stg_kanrikino_meisaihikiate_master_syaryosys as (
    select
        spec_no::varchar(2) as spec_no, --仕様書NO.
        carnm_cd::varchar(2) as carnm_cd, --車名コード
        funcdtl_cd::varchar(7) as funcdtl_cd, --管理機能明細コード
        ctl_model::varchar(20) as ctl_model, --コントロール型式
        bdcol_cd::varchar(3) as bdcol_cd, --外鈑色コード
        inner_cd::varchar(4) as inner_cd, --内張コード
        eqp_cond1::varchar(4) as eqp_cond1, --装備条件1
        eqp_cond2::varchar(4) as eqp_cond2, --装備条件2
        eqp_cond3::varchar(4) as eqp_cond3, --装備条件3
        eqp_cond4::varchar(4) as eqp_cond4, --装備条件4
        eqp_cond5::varchar(4) as eqp_cond5, --装備条件5
        eqp_cond6::varchar(4) as eqp_cond6, --装備条件6
        eqp_cond7::varchar(4) as eqp_cond7, --装備条件7
        eqp_cond8::varchar(4) as eqp_cond8, --装備条件8
        tire_cd::varchar(3) as tire_cd, --タイヤコード
        ldts,
        row_number() over (
            partition by 
                spec_no,carnm_cd,funcdtl_cd,ctl_model,bdcol_cd,inner_cd,eqp_cond1,eqp_cond2,eqp_cond3,eqp_cond4,eqp_cond5,eqp_cond6,eqp_cond7,eqp_cond8,tire_cd
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb89') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb89') }})
)
select * exclude(aggkey)
from stg_kanrikino_meisaihikiate_master_syaryosys
where aggkey = 1