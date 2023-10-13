with
    order_joho as (
        select
            ordrkey,
            dlrcd,
            iff(yusokbn is null, '', yusokbn) yusokbn,
            odrno,
            juchuymd,
            jhinban,
            syubetsu,
            juchusu,
            rimak1,
            rimak2
        from {{ ref("stg_dvnp0680") }}  -- オーダー情報ファイル
        where kokagkbn = '1'
    ),
    noshi_latest as (
        select
            ordrkey,
            juchuymd,
            hnskiboymd,
            hoskiboymd,
            hsskiboymd,
            skibohenkokaisu,
            hnhonyoyakuymd,
            hshonyoyakuymd,
            hnnksyytime,
            honksyytime,
            hsnksyytime,
            allnosicansu,
            hnnosicansu,
            hnnosicantime,
            honosicantime,
            hsnosicantime,
            nosicankaisu,
            iphonyoyakuymd,
            nosikbn hnnosikbn,
            case
                when (hnhonyoyakuymd <> juchuymd) then juchuymd else ''
            end kariyoyakuymd
        from {{ ref("stg_cvn18nosiodrjyoho_latest") }}
    ),
    noshi_initial as (
        select ordrkey, juchuymd, nosikbn as hsnosikbn
        from {{ ref("stg_cvn18nosiodrjyoho_initial") }}
    ),
    noshi_previous as (
        select ordrkey, juchuymd, nosikbn as honosikbn
        from {{ ref("stg_cvn18nosiodrjyoho_previous") }}
    ),
    bo_kaito as (
        select
            ordrkey,
            juchuymd,
            hnnoytime,
            hnsyytime,
            hntoytime,
            hsnoytime,
            hssyytime,
            ptopflg,
            hskkbn,
            hstaytime,
            hstoytime,
            hokkbn,
            honoytime,
            hotaytime,
            hosyytime,
            hotoytime,
            mkaitocd,
            hnkkbn,
            hntaytime,
            ipsyytmie
        from {{ ref("stg_dvnp0710") }}
        where kokagkbn = '1'
    ),
    bo_kanri as (
        select ordrkey, juchuymd, martflg
        from {{ ref("stg_dvnp6490") }}
        where kokagkbn = '1'
    )
select
    jh.*,
    nl.* exclude (ordrkey, juchuymd),
    ni.* exclude (ordrkey, juchuymd),
    np.* exclude (ordrkey, juchuymd),
    bkai.* exclude (ordrkey, juchuymd),
    bkan.* exclude (ordrkey, juchuymd)
from order_joho jh
left outer join noshi_latest nl on jh.ordrkey = nl.ordrkey and jh.juchuymd = nl.juchuymd
left outer join
    noshi_initial ni on jh.ordrkey = ni.ordrkey and jh.juchuymd = ni.juchuymd
left outer join
    noshi_previous np on jh.ordrkey = np.ordrkey and jh.juchuymd = np.juchuymd
left outer join
    bo_kaito bkai on jh.ordrkey = bkai.ordrkey and jh.juchuymd = bkai.juchuymd
left outer join
    bo_kanri bkan on jh.ordrkey = bkan.ordrkey and jh.juchuymd = bkan.juchuymd
