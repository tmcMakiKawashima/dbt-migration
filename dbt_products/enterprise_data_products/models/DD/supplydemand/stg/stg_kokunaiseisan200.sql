{{
    config(
        materialized='incremental',
        incremental_strategy = 'append',
        post_hook = '
            delete from {{this}}
            where (syadai_kt, frmno, ldts) in (
                with ranked as (
                    select syadai_kt, frmno, ldts,
                        rank() over(partition by syadai_kt, frmno order by ldts desc) as aggkey
                    from {{this}}
                )
                select syadai_kt, frmno, ldts
                from ranked
                where aggkey <> 1
                group by all
            )
            '
    )
}}
with kokunaiseisan200 as (
    select syadai_kt, frmno, spec, '1' as sketa, substr(spec, 1, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '2' as sketa, substr(spec, 2, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '3' as sketa, substr(spec, 3, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '4' as sketa, substr(spec, 4, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '5' as sketa, substr(spec, 5, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '6' as sketa, substr(spec, 6, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '7' as sketa, substr(spec, 7, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '8' as sketa, substr(spec, 8, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '9' as sketa, substr(spec, 9, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '10' as sketa, substr(spec, 10, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '11' as sketa, substr(spec, 11, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '12' as sketa, substr(spec, 12, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '13' as sketa, substr(spec, 13, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '14' as sketa, substr(spec, 14, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '15' as sketa, substr(spec, 15, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '16' as sketa, substr(spec, 16, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '17' as sketa, substr(spec, 17, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '18' as sketa, substr(spec, 18, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '19' as sketa, substr(spec, 19, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '20' as sketa, substr(spec, 20, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '21' as sketa, substr(spec, 21, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '22' as sketa, substr(spec, 22, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '23' as sketa, substr(spec, 23, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '24' as sketa, substr(spec, 24, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '25' as sketa, substr(spec, 25, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '26' as sketa, substr(spec, 26, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '27' as sketa, substr(spec, 27, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '28' as sketa, substr(spec, 28, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '29' as sketa, substr(spec, 29, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '30' as sketa, substr(spec, 30, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '31' as sketa, substr(spec, 31, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '32' as sketa, substr(spec, 32, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '33' as sketa, substr(spec, 33, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '34' as sketa, substr(spec, 34, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '35' as sketa, substr(spec, 35, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '36' as sketa, substr(spec, 36, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '37' as sketa, substr(spec, 37, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '38' as sketa, substr(spec, 38, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '39' as sketa, substr(spec, 39, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '40' as sketa, substr(spec, 40, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '41' as sketa, substr(spec, 41, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '42' as sketa, substr(spec, 42, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '43' as sketa, substr(spec, 43, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '44' as sketa, substr(spec, 44, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '45' as sketa, substr(spec, 45, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '46' as sketa, substr(spec, 46, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '47' as sketa, substr(spec, 47, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '48' as sketa, substr(spec, 48, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '49' as sketa, substr(spec, 49, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '50' as sketa, substr(spec, 50, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '51' as sketa, substr(spec, 51, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '52' as sketa, substr(spec, 52, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '53' as sketa, substr(spec, 53, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '54' as sketa, substr(spec, 54, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '55' as sketa, substr(spec, 55, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '56' as sketa, substr(spec, 56, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '57' as sketa, substr(spec, 57, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '58' as sketa, substr(spec, 58, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '59' as sketa, substr(spec, 59, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '60' as sketa, substr(spec, 60, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '61' as sketa, substr(spec, 61, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '62' as sketa, substr(spec, 62, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '63' as sketa, substr(spec, 63, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '64' as sketa, substr(spec, 64, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '65' as sketa, substr(spec, 65, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '66' as sketa, substr(spec, 66, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '67' as sketa, substr(spec, 67, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '68' as sketa, substr(spec, 68, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '69' as sketa, substr(spec, 69, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '70' as sketa, substr(spec, 70, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '71' as sketa, substr(spec, 71, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '72' as sketa, substr(spec, 72, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '73' as sketa, substr(spec, 73, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '74' as sketa, substr(spec, 74, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '75' as sketa, substr(spec, 75, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '76' as sketa, substr(spec, 76, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '77' as sketa, substr(spec, 77, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '78' as sketa, substr(spec, 78, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '79' as sketa, substr(spec, 79, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '80' as sketa, substr(spec, 80, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '81' as sketa, substr(spec, 81, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '82' as sketa, substr(spec, 82, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '83' as sketa, substr(spec, 83, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '84' as sketa, substr(spec, 84, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '85' as sketa, substr(spec, 85, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '86' as sketa, substr(spec, 86, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '87' as sketa, substr(spec, 87, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '88' as sketa, substr(spec, 88, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '89' as sketa, substr(spec, 89, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '90' as sketa, substr(spec, 90, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '91' as sketa, substr(spec, 91, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '92' as sketa, substr(spec, 92, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '93' as sketa, substr(spec, 93, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '94' as sketa, substr(spec, 94, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '95' as sketa, substr(spec, 95, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '96' as sketa, substr(spec, 96, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '97' as sketa, substr(spec, 97, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '98' as sketa, substr(spec, 98, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '99' as sketa, substr(spec, 99, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '100' as sketa, substr(spec, 100, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '101' as sketa, substr(spec, 101, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '102' as sketa, substr(spec, 102, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '103' as sketa, substr(spec, 103, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '104' as sketa, substr(spec, 104, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '105' as sketa, substr(spec, 105, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '106' as sketa, substr(spec, 106, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '107' as sketa, substr(spec, 107, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '108' as sketa, substr(spec, 108, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '109' as sketa, substr(spec, 109, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '110' as sketa, substr(spec, 110, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '111' as sketa, substr(spec, 111, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '112' as sketa, substr(spec, 112, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '113' as sketa, substr(spec, 113, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '114' as sketa, substr(spec, 114, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '115' as sketa, substr(spec, 115, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '116' as sketa, substr(spec, 116, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '117' as sketa, substr(spec, 117, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '118' as sketa, substr(spec, 118, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '119' as sketa, substr(spec, 119, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '120' as sketa, substr(spec, 120, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '121' as sketa, substr(spec, 121, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '122' as sketa, substr(spec, 122, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '123' as sketa, substr(spec, 123, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '124' as sketa, substr(spec, 124, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '125' as sketa, substr(spec, 125, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '126' as sketa, substr(spec, 126, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '127' as sketa, substr(spec, 127, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '128' as sketa, substr(spec, 128, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '129' as sketa, substr(spec, 129, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '130' as sketa, substr(spec, 130, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '131' as sketa, substr(spec, 131, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '132' as sketa, substr(spec, 132, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '133' as sketa, substr(spec, 133, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '134' as sketa, substr(spec, 134, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '135' as sketa, substr(spec, 135, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '136' as sketa, substr(spec, 136, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '137' as sketa, substr(spec, 137, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '138' as sketa, substr(spec, 138, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '139' as sketa, substr(spec, 139, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '140' as sketa, substr(spec, 140, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '141' as sketa, substr(spec, 141, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '142' as sketa, substr(spec, 142, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '143' as sketa, substr(spec, 143, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '144' as sketa, substr(spec, 144, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '145' as sketa, substr(spec, 145, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '146' as sketa, substr(spec, 146, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '147' as sketa, substr(spec, 147, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '148' as sketa, substr(spec, 148, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '149' as sketa, substr(spec, 149, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '150' as sketa, substr(spec, 150, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '151' as sketa, substr(spec, 151, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '152' as sketa, substr(spec, 152, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '153' as sketa, substr(spec, 153, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '154' as sketa, substr(spec, 154, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '155' as sketa, substr(spec, 155, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '156' as sketa, substr(spec, 156, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '157' as sketa, substr(spec, 157, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '158' as sketa, substr(spec, 158, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '159' as sketa, substr(spec, 159, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '160' as sketa, substr(spec, 160, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '161' as sketa, substr(spec, 161, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '162' as sketa, substr(spec, 162, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '163' as sketa, substr(spec, 163, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '164' as sketa, substr(spec, 164, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '165' as sketa, substr(spec, 165, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '166' as sketa, substr(spec, 166, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '167' as sketa, substr(spec, 167, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '168' as sketa, substr(spec, 168, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '169' as sketa, substr(spec, 169, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '170' as sketa, substr(spec, 170, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '171' as sketa, substr(spec, 171, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '172' as sketa, substr(spec, 172, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '173' as sketa, substr(spec, 173, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '174' as sketa, substr(spec, 174, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '175' as sketa, substr(spec, 175, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '176' as sketa, substr(spec, 176, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '177' as sketa, substr(spec, 177, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '178' as sketa, substr(spec, 178, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '179' as sketa, substr(spec, 179, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '180' as sketa, substr(spec, 180, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '181' as sketa, substr(spec, 181, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '182' as sketa, substr(spec, 182, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '183' as sketa, substr(spec, 183, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '184' as sketa, substr(spec, 184, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '185' as sketa, substr(spec, 185, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '186' as sketa, substr(spec, 186, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '187' as sketa, substr(spec, 187, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '188' as sketa, substr(spec, 188, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '189' as sketa, substr(spec, 189, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '190' as sketa, substr(spec, 190, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '191' as sketa, substr(spec, 191, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '192' as sketa, substr(spec, 192, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '193' as sketa, substr(spec, 193, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '194' as sketa, substr(spec, 194, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '195' as sketa, substr(spec, 195, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '196' as sketa, substr(spec, 196, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '197' as sketa, substr(spec, 197, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '198' as sketa, substr(spec, 198, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '199' as sketa, substr(spec, 199, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, spec, '200' as sketa, substr(spec, 200, 1) as skigo, updatetime, ldts from {{ref('stg_kokunaiseisan')}} where skigo <> ' '
)
select syadai_kt, frmno, sketa, skigo, updatetime, ldts from kokunaiseisan200

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
{% endif %}