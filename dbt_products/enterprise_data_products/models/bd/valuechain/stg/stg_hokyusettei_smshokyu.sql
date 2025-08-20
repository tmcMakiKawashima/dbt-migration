with stg_hokyusettei_smshokyu as (
    select
        trim(syasyu32)::varchar(2) as syasyu32, -- 左右ブランク
        trim(syasyu)::varchar(4) as syasyu, -- 左右ブランク
        trim(kumitate)::varchar(4) as kumitate, -- 左右ブランク
        trim(bui)::varchar(2) as bui, -- 左右ブランク
        trim(vari)::varchar(2) as vari, -- 左右ブランク
        trim(oyahin)::varchar(10) as oyahin, -- 左右ブランク
        trim(gc)::varchar(2) as gc, -- 左右ブランク
        trim(kohin)::varchar(10) as kohin, -- 左右ブランク 
        sepjunk::varchar(9) as sepjunk,
        sepjunm::varchar(9) as sepjunm,
        kosu::varchar(3) as kosu,
        trim(sentaku)::varchar(2) as sentaku, -- 左右ブランク
        trim(hikihokbn)::varchar(2) as hikihokbn, -- 左右ブランク
        trim(hosenflg)::varchar(1) as hosenflg, -- 左右ブランク
        trim(tekikara)::varchar(8) as tekikara, -- 左右ブランク
        trim(tekimade)::varchar(8) as tekimade, -- 左右ブランク
        trim(kyoseijig)::varchar(2) as kyoseijig, -- 左右ブランク
        trim(torokud)::varchar(8) as torokud, -- 左右ブランク
        trim(torokut)::varchar(6) as torokut, -- 左右ブランク
        trim(kosind)::varchar(8) as kosind, -- 左右ブランク
        trim(kosint)::varchar(6) as kosint, --　左右ブランク
        trim(kosinsya)::varchar(16) as kosinsya, -- 左右ブランク
        _fivetran_synced as ldts
    from {{source('fivetran_database_idr_hokyu_sms_dxpfy2d', 'raw_cvf03hosetu')}}
    where _fivetran_deleted = 'false'
)
select * from stg_hokyusettei_smshokyu