with spec_split as (
    select
        t06.syasyu,
        t06.kata,
        t06.enginekata,
        t06.spec,
        t06.intcode,
        t06.int_cd_iromei,
        t06.extcode,
        t06.ext_cd_iromei,
        t06.dest_cd,
        t06.dest,
        t06.plantcode,
        t06.pscexlk,
        t06.sk_y,
        t06.sk_m,
        t06.idline,
        t06.daisu,
        seq.keta_no as keta_no,
        substr(t06.spec, seq.keta_no, 1) as kigo
    from 
        {{source('katashiki_db_spec','raw_tmp60_dm_siyo_seisan_daisu_test')}} as t06,
        (select seq4() + 1 as keta_no from table(generator(rowcount => 200))) as seq
)
select * from spec_split