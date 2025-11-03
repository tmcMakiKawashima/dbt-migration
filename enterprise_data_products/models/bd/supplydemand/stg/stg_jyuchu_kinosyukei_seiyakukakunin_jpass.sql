{{
    config (
        materialized = 'incremental',
        unique_key = ['ym', 'caltimingkbn', 'shamei', 'sno', 'shinq','nijsym','kncode'],
        incremental_strategy = 'merge',
        post_hook ="
              delete from {{this}} where try_to_timestamp_ntz(ym,'yyyymm') < dateadd(month, -36, (select try_to_timestamp_ntz(max(ym),'yyyymm') from {{this}}))
        "
    )
}}
--直近3年のみ保持する為post_hookによる削除処理を実装
with stg_jyuchu_kinosyukei_seiyakukakunin_jpass as (
    select
        rtrim(ym,' 　')::varchar(6) as ym,  -- 右blank
        rtrim(caltimingkbn,' 　')::varchar(2) as caltimingkbn,  -- 右blank
        rtrim(shamei,' 　')::varchar(2) as shamei,  -- 右blank
        rtrim(sno,' 　')::varchar(2) as sno,  -- 右blank
        rtrim(shinq,' 　')::varchar(3) as shinq,  -- 右blank
        rtrim(nijsym,' 　')::varchar(6) as nijsym,  -- 右blank
        rtrim(kncode,' 　')::varchar(7) as kncode,  -- 右blank
        rtrim(seinasidai,' 　')::varchar(5) as seinasidai,  -- 右blank
        rtrim(seinasidaihi,' 　')::varchar(5) as seinasidaihi,  -- 右blank
        rtrim(sdai,' 　')::varchar(5) as sdai,  -- 右blank
        rtrim(seiaridai,' 　')::varchar(5) as seiaridai,  -- 右blank
        rtrim(seiaridaihi,' 　')::varchar(5) as seiaridaihi,  -- 右blank
        rtrim(fulllank,' 　')::varchar(3) as fulllank,  -- 右blank
        rtrim(dummy,' 　')::varchar(24) as dummy,  -- 右blank
        ldts,
        row_number() over(partition by ym, caltimingkbn, shamei, sno, shinq, nijsym, kncode order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_ktrla038zz0kaddb03') }}      
  {% if is_incremental() %}
      where ldts > (select max(ldts) from {{this}})
  {% endif %}
)
select * exclude(aggkey) from stg_jyuchu_kinosyukei_seiyakukakunin_jpass
where aggkey = 1