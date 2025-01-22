with
    stg_kousei as (
        select
            syasyu, --車種コード
            jigyoutai, --生産事業体
            mttime --MT日時
        from {{ ref('stg_kousei') }}
        where jigyoutai = '  '
    ),
    tmp_junkanri_blktenkai as (
        select
            syasyu, --車種コード
            target, --ターゲット
            maxmttime --MAXMTTIME
        from {{ source('parts_list_db_sms', 'raw_tmp_junkanri_blktenkai') }}
    ),
    stg_kouseicom as (
        select
            syasyu, --車種コード
            jigyoutai, --生産事業体
            comkbn, --コメント区分
            mttime --MT日時
        from {{ ref('stg_kouseicom') }}
        where jigyoutai = '  '
        and comkbn = '11'
    )
        select
            a.syasyu
        from stg_kousei a
        left outer join tmp_junkanri_blktenkai b
        on 
        a.syasyu = b.syasyu
        and a.jigyoutai = '  '
        and b.target = 'KOUSEI'
        where b.syasyu is null or ( a.syasyu = b.syasyu and a.mttime > b.maxmttime)
        group by a.syasyu
        
        union
        
        select
            c.syasyu
        from stg_kouseicom c
        left outer join tmp_junkanri_blktenkai b
        on 
        c.syasyu = b.syasyu
        and c.jigyoutai = '  '
        and c.comkbn in ('11')
        and b.target = 'KOUSEI'
        where b.syasyu is null or ( c.syasyu = b.syasyu and c.mttime > b.maxmttime)
        group by c.syasyu
