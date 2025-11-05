{{
  config(
    materialized='incremental',
    unique_key = ['syagai_cd'],
    incremental_strategy = 'append',
    pre_hook=[
      "{{ dbt_snow_mask.create_masking_policy('models')}}",
      "
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
      "
    ],
    post_hook=[
      "{{ dbt_snow_mask.apply_masking_policy('models') }}"
    ]
  )
}}

with stg_syagaisya as (
    select
        r_syagaiid::varchar(7) as syagai_cd,
        r_syagaikbn::varchar(1) as r_syagaikbn,
        r_simeiknj::varchar(20) as r_simeiknj,
        r_simeifrgn::varchar(20) as r_simeifrgn,
        r_simeirm::varchar(50) as r_simeirm,
        r_birthday::varchar(8) as r_birthday,
        r_ukebusyocd::varchar(5) as r_ukebusyocd,
        r_keiyakukaisiymd::varchar(8) as r_keiyakukaisiymd,
        r_keiyakusyuryoymd::varchar(8) as r_keiyakusyuryoymd,
        r_sagyoarea::varchar(4) as r_sagyoarea,
        r_kikansyokuflg::varchar(1) as r_kikansyokuflg,
        r_syozokucd::varchar(5) as syozoku_cd,
        r_motokaisyacd::varchar(5) as r_motokaisyacd,
        r_motokaisyamei::varchar(60) as r_motokaisyamei,
        r_syozokukaisyacd::varchar(5) as r_syozokukaisyacd,
        r_syozokukaisyamei::varchar(60) as r_syozokukaisyamei,
        r_picdata::varchar(10) as r_picdata,
        r_caruse::varchar(1) as r_caruse,
        r_postalcode::varchar(7) as r_postalcode,
        r_carmaker::varchar(20) as r_carmaker,
        r_carname::varchar(20) as r_carname,
        r_carcode::varchar(20) as r_carcode,
        r_carnumber::varchar(6) as r_carnumber,
        r_cardhakkou::varchar(1) as r_cardhakkou,
        r_prnno::varchar(3) as r_prnno,
        r_cardrtn::varchar(1) as r_cardrtn,
        r_cardstatus::varchar(1) as r_cardstatus,
        r_hyokikeisiki::varchar(1) as r_hyokikeisiki,
        r_sofukubun::varchar(30) as r_sofukubun,
        r_sofutateya::varchar(30) as r_sofutateya,
        r_sofubu::varchar(60) as r_sofubu,
        r_sofusinseisya::varchar(20) as r_sofusinseisya,
        r_cardsendflag::varchar(1) as r_cardsendflag,
        r_mukouymd::varchar(16) as r_mukouymd,
        r_inputempcd::varchar(7) as r_inputempcd,
        r_inputname::varchar(40) as r_inputname,
        r_updateymd::varchar(8) as r_updateymd,
        r_kinmukanrikbn::varchar(1) as r_kinmukanrikbn,
        ldts,
        row_number() over(partition by syagai_cd
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20054')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20054')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_syagaisya where aggkey = 1
