with t61 as (
    select * from {{ref('tmp61_dm_siyo_seisan_daisu')}}
), seq as (
  -- SPECを200分割するためのシーケンス
    select
        seq4() + 1 as keta_no -- 桁No
    from table(generator(rowcount => 200))
)  
select
  t61.*,
  seq.*,
  substr(t61.spec, seq.keta_no, 1) as kigo  -- specを1文字づつ200分割した記号
 from t61 cross join seq