{{ config(
      materialized='incremental',
      unique_key = ['syasyu','tantoseikan','jyokenno','kata','jigyoutai','seisuffix','genteikbn','seisanbasyo'],
      incremental_strategy = 'merge',
      post_hook ="
        update {{this}} i
          set
            i.source = 'sms-koutei',
            i.ldts = to_timestamp_ntz(_fivetran_synced),
            i.haishiflg = '1'
        from {{ source('fivetran_database_idr_koutei_sms_dxpfy2d', 'raw_cym07seisansei') }} j
        where
          i.syasyu=j.syasyu and
          i.tantoseikan=j.tantoseikan and
          i.jyokenno=j.jyokenno and
          i.kata=j.kata and
          i.jigyoutai=j.jigyoutai and
          i.seisuffix=j.seisuffix and
          i.genteikbn=j.genteikbn and
          i.seisanbasyo=j.seisanbasyo and
          substr(i.seisanbasyo, 5, 1)='S' and ifnull(i.haishiflg,0)<>'1' and
          j._fivetran_deleted = 'true' and substr(j.seisanbasyo, 5, 1)='S'
      "
  )
 }}
--廃止済みデータを更新するためpost_hookで廃止フラグをセットする

with stg_seisanbasyoseisiki_kouteisms as (
    select
        syasyu::varchar(4) as syasyu, --なし
        tantoseikan::varchar(2) as tantoseikan, --なし
        jyokenno::varchar(3) as jyokenno, --なし
        kata::varchar(20) as kata, --なし
        jigyoutai::varchar(2) as jigyoutai, --なし
        seisuffix::varchar(4) as seisuffix, --なし
        genteikbn::varchar(4) as genteikbn, --なし
        seisanbasyo::varchar(6) as seisanbasyo, --なし
        taisyogaiflg::varchar(1) as taisyogaiflg, --なし
        siyoumu::varchar(1) as siyoumu, --なし
        yusengenteiflg::varchar(1) as yusengenteiflg, --なし
        mttime::varchar(16) as mttime, --なし
        'sms-koutei'::varchar(50) as source, --なし
        _fivetran_synced::timestamp_ntz as ldts, -- timestamp型
        null::varchar(1) as haishiflg,
    from {{ source('fivetran_database_idr_koutei_sms_dxpfy2d', 'raw_cym07seisansei') }}
    where _fivetran_deleted = 'false' and
        substr(seisanbasyo, 5, 1)='S'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_seisanbasyoseisiki_kouteisms