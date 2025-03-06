with
    tmp_kousei00_blktenkai as (
        select * 
        from {{ ref('tmp_kousei00_blktenkai') }}
    ),
    stg_kouseicom as (
        select
            syasyu, --車種コード
            siyoubui, --使用部位
            oyahin, --親使用部位/品番
            kohin, --子品番/BLK
            gc, --GC
            com, -- 構成コメント
            torokujunk, --登録/生認順カラ
            torokujunm, --登録/生認順マデ
        from {{ ref('stg_kouseicom') }} -- 構成コメント
        where jigyoutai = '  '
        and comkbn = '11'
    )
        select
            a.*,
            nvl(b.com, '') as tyohuku, --構成コメント
            nvl(b.torokujunk, '') as torokujunk_com, --登録/生認順カラ
            nvl(b.torokujunm, '') as torokujunm_com, --登録/生認順マデ
        from tmp_kousei00_blktenkai a
        left outer join stg_kouseicom b
          on a.syasyu = b.syasyu
          and a.siyoubui = b.siyoubui
          and a.oyahin = b.oyahin
          and a.kohin = b.kohin
          and a.gc = b.gc
          and not(b.torokujunm <= a.torokujunk or a.torokujunm <= b.torokujunk)