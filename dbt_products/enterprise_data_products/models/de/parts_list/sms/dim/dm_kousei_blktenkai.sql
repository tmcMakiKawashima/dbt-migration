{{
    config(
        materialized='incremental',
        incremental_strategy = 'append',
        pre_hook = "
            {% if is_incremental() %}
                delete from {{this}} a
                using (
                    select distinct syasyu,
                                    substr(siyoubui, 1, 4) as kumitate,
                                    substr(siyoubui, 5, 2) as bui
                    from {{ source('parts_list_db_sms', 'raw_tmp_kousei03_blktenkai') }} ) b
                where a.syasyu = b.syasyu
                  and a.kumitate = b.kumitate
                  and a.bui = b.bui;
            {% endif %}
        "
    )
}}
--車種,組立番号,部位の単位で置き換える

with 
   tmp_kousei03_blktenkai as (
     select
       syasyu, -- 車種コード
       siyoubui, -- 使用部位
       kumitate, -- 組立番号
       bui, -- 部位
       motosiyoubui, --元使用部位
       vari, -- バリエーション
       oyahin, -- 親品番
       lv, -- レベル
       kouseijyun, -- 構成順
       gc, -- GC
       kohin, -- 品番／BLKコード
       hinmei, --品名
       blkmei, -- BLKコード名称
       kosu, -- 使用個数
       sentaku, -- 選択符号
       tyohuku, -- 重複記載
       torokujunk, -- 登録／生認順カラ
       torokujunm, -- 登録／生認順マデ
       seppennok, -- 設変No.カラ
       seppennom, -- 設変No.マデ
       to_timestamp(torokutimek || iff(torokujunk = '999999999','9', '0'), 'yyyymmddhh24missff3') as torokutimek, -- LOAD TIMEカラ
       to_timestamp(torokutimem || iff(torokujunm = '999999999','9', '0'), 'yyyymmddhh24missff3') as torokutimem, -- LOAD TIMEマデ
       ldts -- B層処理日時
     from {{ source('parts_list_db_sms', 'raw_tmp_kousei03_blktenkai') }}
   )

select 
  tmp_kousei03_blktenkai.syasyu,
  tmp_kousei03_blktenkai.siyoubui,
  tmp_kousei03_blktenkai.kumitate,
  tmp_kousei03_blktenkai.bui,
  tmp_kousei03_blktenkai.motosiyoubui,
  tmp_kousei03_blktenkai.vari,
  tmp_kousei03_blktenkai.oyahin,
  tmp_kousei03_blktenkai.lv,
  tmp_kousei03_blktenkai.kouseijyun,
  tmp_kousei03_blktenkai.gc,
  tmp_kousei03_blktenkai.kohin,
  case  
    when rtrim(blkmei) is not null then blkmei
    when rtrim(hinmei) is not null then hinmei
    else ''
  end as kohinmei,
  tmp_kousei03_blktenkai.kosu,
  tmp_kousei03_blktenkai.sentaku,
  tmp_kousei03_blktenkai.tyohuku,
  tmp_kousei03_blktenkai.torokujunk,
  tmp_kousei03_blktenkai.torokujunm,
  tmp_kousei03_blktenkai.seppennok,
  tmp_kousei03_blktenkai.seppennom,
  tmp_kousei03_blktenkai.torokutimek,
  tmp_kousei03_blktenkai.torokutimem,
  tmp_kousei03_blktenkai.ldts
from tmp_kousei03_blktenkai