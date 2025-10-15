select 
    ev.eventno,                       -- イベントNo
    ev.syasyu,                        -- 車種コード
    ev.eventmei,                      -- イベント名
    ev.syonintime,                    -- 承認日時
    ev.seppenhinkou,                  -- 設変内容-品番構成変更
    ev.seppensyaryohiki,              -- 設変内容-車両引当変更
    ev.evidenceumu,                   -- エビデンス有無
    ev.systorokutime,                 -- システム登録日時
    ev.systorokukaisyacode,           -- システム登録会社コード
    ev.systorokuuserid,               -- システム登録ユーザID
    ev.systorokuaplid,                -- システム登録アプリID
    ev.syskosintime,                  -- システム更新日時
    ev.syskosinkaisyacode,            -- システム更新会社コード
    ev.syskosinuserid,                -- システム更新ユーザID
    ev.syskosinaplid,                 -- システム更新アプリID
    coalesce(sy.syukan,'')::varchar(2) as syukan,  -- 主管会社
    current_timestamp()::timestamp_ntz(9) as ldts  -- 最終更新日時
  from {{ ref('stg_swevent_ebidensu') }} as ev
  left outer join {{ ref('stg_syasyu') }} as sy
    on sy.syasyu = ev.syasyu