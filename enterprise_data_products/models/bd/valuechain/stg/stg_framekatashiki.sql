with stg_framekatashiki as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(frmnokata, ' 　')::varchar(7) as frmnokata, -- 右blank
        rtrim(replace(frmno, '@', '0'), ' 　')::varchar(7) as frmno, -- 右blank及び@を0へ変換
        rtrim(mdlyearkbn, ' 　')::varchar(1) as mdlyearkbn, -- 右blank
        rtrim(vin, ' 　')::varchar(17) as vin, -- 右blank
        nen::varchar(4) as nen, 
        tuki::varchar(2) as tuki, 
        clrcd::varchar(3) as clrcd, 
        trmcd::varchar(4) as trmcd, 
        rtrim(syasyu_cd, ' 　')::varchar(4) as syasyu_cd, -- 右blank
        rtrim(siyoptno, ' 　')::varchar(4) as siyoptno, -- 右blank
        tkstkbn::varchar(1) as tkstkbn, 
        rtrim(syakata, ' 　')::varchar(20) as syakata, -- 右blank
        hanbai_kt::varchar(20) as hanbai_kt, 
        eng_type::varchar(7) as eng_type, 
        transkata::varchar(6) as transkata, 
        rdf_type::varchar(3) as rdf_type, 
        ldts, --B層取込日時
        rank() over (partition by frmnokata, frmno, mdlyearkbn, vin order by ldts desc) aggkey
    from {{ ref('substr_dv2a5404') }}
)
select * exclude(mntkbn, aggkey)
from stg_framekatashiki
where aggkey = 1 and mntkbn in ('C', 'U')