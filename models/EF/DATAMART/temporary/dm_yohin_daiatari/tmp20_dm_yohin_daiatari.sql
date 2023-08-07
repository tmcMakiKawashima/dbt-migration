with temp10 as (
    select * from {{ref('tmp10_dm_yohin_daiatari')}}
),
DM_SHINSYA_MEISAI as (
    select
       RTRIM(HKATA) HKATA, -- 販売型式
       RTRIM(FLNO) FLNO, -- フレームNo
       COALESCE(TSHAMEIA,'') || '-' -- T-COM車名コード(ﾒｰｶｰﾌﾞﾗﾝﾄﾞ)
       || COALESCE(TSHAMEIB,'') || '-' -- T-COM車名コード(ブランド名)
       || COALESCE(TSHAMEIC,'') || '-' -- T-COM車名コード(通称名称)
       || COALESCE(TSHAMEID,'') -- T-COM車名コード(ボディ)
       TSHAMEI, -- 車名コード
       HDKB, -- 払出区分
       YOUTOKBN, -- 用途区分
       FTDD, -- 振当日
       TODD, -- 登録日
       NSQBDY, -- 納車希望日
       NSDD, -- 納車日
       HIYTDD, -- 配車予定日
       TOYTDD -- 登録予定日
    from {{ref('dm_shinsya_meisai')}} -- 新車明細DM
)
select t.*,
       h.TSHAMEI, -- 車名コード
       h.HDKB, -- 払出区分
       h.YOUTOKBN, -- 用途区分
       h.FTDD, -- 振当日
       h.TODD, -- 登録日
       h.NSQBDY, -- 納車希望日
       h.NSDD, -- 納車日
       h.HIYTDD, -- 配車予定日
       h.TOYTDD -- 登録予定日
from temp10 t
left outer join DM_SHINSYA_MEISAI h -- 新車明細DM
on t.FRMNO = h.FLNO -- フレームNo
and t.HANKATA = h.HKATA -- 販売型式