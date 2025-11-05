with 
    ev as (
            select 
                  eventno,                       -- イベントNo
                  syasyu,                        -- 車種コード
                  eventmei,                      -- イベント名
                  syonintime,                    -- 承認日時
                  seppenhinkou,                  -- 設変内容-品番構成変更
                  seppensyaryohiki,              -- 設変内容-車両引当変更
                  evidenceumu,                   -- エビデンス有無
                  systorokutime,                 -- システム登録日時
                  systorokukaisyacode,           -- システム登録会社コード
                  systorokuuserid,               -- システム登録ユーザID
                  systorokuaplid,                -- システム登録アプリID
                  syskosintime,                  -- システム更新日時
                  syskosinkaisyacode,            -- システム更新会社コード
                  syskosinuserid,                -- システム更新ユーザID
                  syskosinaplid,                 -- システム更新アプリID
              from {{ ref('stg_swevent_ebidensu_aisac') }} 
    ),
    sy as (
            select syasyu,  -- 車種ユニットコード
                   syukan   -- 主管会社
              from {{ ref('stg_syasyu') }}
    )

select 
    ev.*,
    coalesce(sy.syukan,'')::varchar(2) as syukan,
    current_timestamp()::timestamp_ntz(9) as ldts  -- 最終更新日時
  from ev
  left outer join sy
    on sy.syasyu = ev.syasyu