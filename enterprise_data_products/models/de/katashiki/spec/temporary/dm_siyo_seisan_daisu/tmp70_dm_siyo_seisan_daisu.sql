with t61 as (
    select
        syasyu,         -- 車種ｺｰﾄﾞ
        kata,           -- 呼称型式
        enginekata,     -- エンジン型式
        spec,           -- SPEC200桁組合せ
        intcode,        -- 内張コード
        int_cd_iromei,  -- 内張色
        extcode,        -- 外鈑色コード
        ext_cd_iromei,  -- 外鈑色
        dest_cd,        -- 仕向地コード
        dest,           -- 仕向国
        plantcode,      -- 工場コード
        pscexlk,        -- PSC
        sk_y,           -- 終検日年
        sk_m,           -- 終検日月
        idline,         -- アイデントライン
        daisu           -- 台数
    from 
        {{source('katashiki_db_spec','raw_tmp61_dm_siyo_seisan_daisu_test')}}
  {% raw %}
    --from {{ref('tmp61_dm_siyo_seisan_daisu')}}
  {% endraw %}
), seq as (
  -- SPECを200分割するためのシーケンス
    select
        seq4() + 1 as keta_no -- 桁No
    from table(generator(rowcount => 200))
)  
select
  t61.*,
  seq.keta_no,
  substr(t61.spec, seq.keta_no, 1) as kigo  -- specを1文字づつ200分割した記号
 from t61 cross join seq