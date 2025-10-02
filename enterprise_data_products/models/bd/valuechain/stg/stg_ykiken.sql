with stg_ykiken as(
    select
        rtrim(hinban, ' 　')::varchar(15) as hinban, -- 右ブランク
        syusbetu::varchar(4) as syusbetu,
        rtrim(seppenjun, ' 　')::varchar(15) as seppenjun, -- 右ブランク
        seppen::varchar(18) as seppen,
        kara::varchar(8) as kara,
        made::varchar(8) as made,
        kikenhinsyokbn::varchar(1) as kikenhinsyokbn,
        hazkbn::varchar(1) as hazkbn,
        kaiyuhaz::varchar(3) as kaiyuhaz,
        kuyuhaz::varchar(3) as kuyuhaz,
        kosincompid::varchar(5) as kosincompid,
        kosinuserid::varchar(10) as kosinuserid,
        kosintime::varchar(16) as kosintime,
        _fivetran_synced as ldts
    from {{ source('fivetran_database_idr_gsps_dxpfy2d', 'raw_cvk09ykiken') }}
    where _fivetran_deleted = 'false'
)

select * from stg_ykiken