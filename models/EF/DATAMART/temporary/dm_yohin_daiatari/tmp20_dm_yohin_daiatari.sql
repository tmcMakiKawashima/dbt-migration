with temp10 as (
    select * from {{ref('tmp10_dm_yohin_daiatari')}}
),
dm_shinsya_meisai as (
    select
       rtrim(hkata) hkata, -- 販売型式
       rtrim(flno) flno, -- フレームno
       coalesce(tshameia,'') || '-' -- t-com車名コード(ﾒｰｶｰﾌﾞﾗﾝﾄﾞ)
       || coalesce(tshameib,'') || '-' -- t-com車名コード(ブランド名)
       || coalesce(tshameic,'') || '-' -- t-com車名コード(通称名称)
       || coalesce(tshameid,'') -- t-com車名コード(ボディ)
       tshamei, -- 車名コード
       hdkb, -- 払出区分
       youtokbn, -- 用途区分
       ftdd, -- 振当日
       todd, -- 登録日
       nsqbdy, -- 納車希望日
       nsdd, -- 納車日
       hiytdd, -- 配車予定日
       toytdd, -- 登録予定日
       jkeidd, -- 受注計上日
       hanbkjdd -- 販売計上日
    from {{ref('dm_shinsya_meisai')}} -- 新車明細DM
)
select t.*,
       h.tshamei, -- 車名コード
       h.hdkb, -- 払出区分
       h.youtokbn, -- 用途区分
       h.ftdd, -- 振当日
       h.todd, -- 登録日
       h.nsqbdy, -- 納車希望日
       h.nsdd, -- 納車日
       h.hiytdd, -- 配車予定日
       h.toytdd, -- 登録予定日
       h.jkeidd, -- 受注計上日
       h.hanbkjdd -- 販売計上日
from temp10 t
left outer join dm_shinsya_meisai h -- 新車明細DM
on t.frmno = h.flno -- フレームNO
and t.hankata = h.hkata -- 販売型式