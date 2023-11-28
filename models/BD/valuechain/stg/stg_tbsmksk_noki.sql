with stg_tbsmksk_noki as (
    select
        rtrim(id,' 　')::varchar(3) as id,  -- 英数字
        rtrim(kyouhan,' 　')::varchar(5) as kyouhan,  -- 英数字
        --lpadの桁数を数値で記載（固定長ではなくCSVのため）
        iff(rtrim(nyukkten) = '','',lpad(rtrim(nyukkten),2,'0'))::varchar(2) as nyukkten,  -- コード／区分
        rtrim(makercd,' 　')::varchar(5) as makercd,  -- 英数字
        rtrim(ktenkbn,' 　')::varchar(1) as ktenkbn,  -- 英数字
        --lpadの桁数を数値で記載（固定長ではなくCSVのため）
        iff(rtrim(ptnno) = '','',lpad(rtrim(ptnno),1,'0'))::varchar(1) as ptnno,  -- コード／区分
        rtrim(yobi,' 　')::varchar(8) as yobi,  -- 英数字
        rtrim(nokismkskcd,' 　')::varchar(2) as nokismkskcd,  -- 英数字
        rtrim(hikizaikbn,' 　')::varchar(1) as hikizaikbn,  -- 英数字
        --lpadの桁数を数値で記載（固定長ではなくCSVのため）
        iff(rtrim(deletedate) = '','',lpad(rtrim(deletedate),8,'0'))::varchar(8) as deletedate,  -- 日付
        ldts, -- B層のLDTS
        -- nyusyukko x shimukeの絞り込みに利用
        row_number() over (
            partition by kyouhan, nyukkten, makercd 
            order by ktenkbn asc, ptnno desc) rownum
    from {{source('valuechain_db_public','substr_tbsmksk_noki')}}
)
select * from stg_tbsmksk_noki