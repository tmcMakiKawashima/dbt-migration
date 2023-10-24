with stg_cvn35dsyukabin as (
    select
        rtrim(dlrcd, ' 　') as dlrcd, --英数字
        rtrim(syubetsu, ' 　') as syubetsu, --英数字
        rtrim(yusokbn, ' 　') as yusokbn, --英数字
        rtrim(syukkakyotenkbn, ' 　') as syukkakyotenkbn, --英数字
        rtrim(sykikicd, ' 　') as sykikicd, --英数字
        rtrim(satflg, ' 　') as satflg, --英数字
        rtrim(haisyahhmm, ' 　') as haisyahhmm, --英数字
        rtrim(tekiyokaisiymd, ' 　') as tekiyokaisiymd, --英数字
        rtrim(tekiyosyuryoymd, ' 　') as tekiyosyuryoymd, --英数字
        rtrim(keikanissu, ' 　') as keikanissu, --英数字
        rtrim(totyakuhhmm, ' 　') as totyakuhhmm, --英数字
        rtrim(syukkasijihhmm, ' 　') as syukkasijihhmm, --英数字
        rtrim(mtuserid, ' 　') as mtuserid, --英数字
        rtrim(mttime, ' 　') as mttime, --英数字
        ldts
    from {{ ref('substr_cvn35dsyukabin') }}
),
max_ldts as (
    select
        max(ldts) as ldts
    from {{ ref('substr_cvn35dsyukabin') }}
)
select stg_cvn35dsyukabin.* from stg_cvn35dsyukabin
inner join max_ldts on stg_cvn35dsyukabin.ldts = max_ldts.ldts