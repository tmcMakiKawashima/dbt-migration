with stg_oemseisan200 as (
    select syadai_kt, frmno, '1' as sketa, substr(sn_spec, 1, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '2' as sketa, substr(sn_spec, 2, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '3' as sketa, substr(sn_spec, 3, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '4' as sketa, substr(sn_spec, 4, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '5' as sketa, substr(sn_spec, 5, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '6' as sketa, substr(sn_spec, 6, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '7' as sketa, substr(sn_spec, 7, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '8' as sketa, substr(sn_spec, 8, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '9' as sketa, substr(sn_spec, 9, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '10' as sketa, substr(sn_spec, 10, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '11' as sketa, substr(sn_spec, 11, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '12' as sketa, substr(sn_spec, 12, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '13' as sketa, substr(sn_spec, 13, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '14' as sketa, substr(sn_spec, 14, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '15' as sketa, substr(sn_spec, 15, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '16' as sketa, substr(sn_spec, 16, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '17' as sketa, substr(sn_spec, 17, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '18' as sketa, substr(sn_spec, 18, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '19' as sketa, substr(sn_spec, 19, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '20' as sketa, substr(sn_spec, 20, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '21' as sketa, substr(sn_spec, 21, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '22' as sketa, substr(sn_spec, 22, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '23' as sketa, substr(sn_spec, 23, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '24' as sketa, substr(sn_spec, 24, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '25' as sketa, substr(sn_spec, 25, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '26' as sketa, substr(sn_spec, 26, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '27' as sketa, substr(sn_spec, 27, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '28' as sketa, substr(sn_spec, 28, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '29' as sketa, substr(sn_spec, 29, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '30' as sketa, substr(sn_spec, 30, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '31' as sketa, substr(sn_spec, 31, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '32' as sketa, substr(sn_spec, 32, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '33' as sketa, substr(sn_spec, 33, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '34' as sketa, substr(sn_spec, 34, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '35' as sketa, substr(sn_spec, 35, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '36' as sketa, substr(sn_spec, 36, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '37' as sketa, substr(sn_spec, 37, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '38' as sketa, substr(sn_spec, 38, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '39' as sketa, substr(sn_spec, 39, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '40' as sketa, substr(sn_spec, 40, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '41' as sketa, substr(sn_spec, 41, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '42' as sketa, substr(sn_spec, 42, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '43' as sketa, substr(sn_spec, 43, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '44' as sketa, substr(sn_spec, 44, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '45' as sketa, substr(sn_spec, 45, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '46' as sketa, substr(sn_spec, 46, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '47' as sketa, substr(sn_spec, 47, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '48' as sketa, substr(sn_spec, 48, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '49' as sketa, substr(sn_spec, 49, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '50' as sketa, substr(sn_spec, 50, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '51' as sketa, substr(sn_spec, 51, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '52' as sketa, substr(sn_spec, 52, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '53' as sketa, substr(sn_spec, 53, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '54' as sketa, substr(sn_spec, 54, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '55' as sketa, substr(sn_spec, 55, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '56' as sketa, substr(sn_spec, 56, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '57' as sketa, substr(sn_spec, 57, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '58' as sketa, substr(sn_spec, 58, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '59' as sketa, substr(sn_spec, 59, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '60' as sketa, substr(sn_spec, 60, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '61' as sketa, substr(sn_spec, 61, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '62' as sketa, substr(sn_spec, 62, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '63' as sketa, substr(sn_spec, 63, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '64' as sketa, substr(sn_spec, 64, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '65' as sketa, substr(sn_spec, 65, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '66' as sketa, substr(sn_spec, 66, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '67' as sketa, substr(sn_spec, 67, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '68' as sketa, substr(sn_spec, 68, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '69' as sketa, substr(sn_spec, 69, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '70' as sketa, substr(sn_spec, 70, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '71' as sketa, substr(sn_spec, 71, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '72' as sketa, substr(sn_spec, 72, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '73' as sketa, substr(sn_spec, 73, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '74' as sketa, substr(sn_spec, 74, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '75' as sketa, substr(sn_spec, 75, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '76' as sketa, substr(sn_spec, 76, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '77' as sketa, substr(sn_spec, 77, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '78' as sketa, substr(sn_spec, 78, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '79' as sketa, substr(sn_spec, 79, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '80' as sketa, substr(sn_spec, 80, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '81' as sketa, substr(sn_spec, 81, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '82' as sketa, substr(sn_spec, 82, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '83' as sketa, substr(sn_spec, 83, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '84' as sketa, substr(sn_spec, 84, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '85' as sketa, substr(sn_spec, 85, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '86' as sketa, substr(sn_spec, 86, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '87' as sketa, substr(sn_spec, 87, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '88' as sketa, substr(sn_spec, 88, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '89' as sketa, substr(sn_spec, 89, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '90' as sketa, substr(sn_spec, 90, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '91' as sketa, substr(sn_spec, 91, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '92' as sketa, substr(sn_spec, 92, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '93' as sketa, substr(sn_spec, 93, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '94' as sketa, substr(sn_spec, 94, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '95' as sketa, substr(sn_spec, 95, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '96' as sketa, substr(sn_spec, 96, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '97' as sketa, substr(sn_spec, 97, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '98' as sketa, substr(sn_spec, 98, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '99' as sketa, substr(sn_spec, 99, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '100' as sketa, substr(sn_spec, 100, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '101' as sketa, substr(sn_spec, 101, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '102' as sketa, substr(sn_spec, 102, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '103' as sketa, substr(sn_spec, 103, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '104' as sketa, substr(sn_spec, 104, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '105' as sketa, substr(sn_spec, 105, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '106' as sketa, substr(sn_spec, 106, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '107' as sketa, substr(sn_spec, 107, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '108' as sketa, substr(sn_spec, 108, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '109' as sketa, substr(sn_spec, 109, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '110' as sketa, substr(sn_spec, 110, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '111' as sketa, substr(sn_spec, 111, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '112' as sketa, substr(sn_spec, 112, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '113' as sketa, substr(sn_spec, 113, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '114' as sketa, substr(sn_spec, 114, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '115' as sketa, substr(sn_spec, 115, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '116' as sketa, substr(sn_spec, 116, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '117' as sketa, substr(sn_spec, 117, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '118' as sketa, substr(sn_spec, 118, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '119' as sketa, substr(sn_spec, 119, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '120' as sketa, substr(sn_spec, 120, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '121' as sketa, substr(sn_spec, 121, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '122' as sketa, substr(sn_spec, 122, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '123' as sketa, substr(sn_spec, 123, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '124' as sketa, substr(sn_spec, 124, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '125' as sketa, substr(sn_spec, 125, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '126' as sketa, substr(sn_spec, 126, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '127' as sketa, substr(sn_spec, 127, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '128' as sketa, substr(sn_spec, 128, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '129' as sketa, substr(sn_spec, 129, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '130' as sketa, substr(sn_spec, 130, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '131' as sketa, substr(sn_spec, 131, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '132' as sketa, substr(sn_spec, 132, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '133' as sketa, substr(sn_spec, 133, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '134' as sketa, substr(sn_spec, 134, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '135' as sketa, substr(sn_spec, 135, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '136' as sketa, substr(sn_spec, 136, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '137' as sketa, substr(sn_spec, 137, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '138' as sketa, substr(sn_spec, 138, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '139' as sketa, substr(sn_spec, 139, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '140' as sketa, substr(sn_spec, 140, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '141' as sketa, substr(sn_spec, 141, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '142' as sketa, substr(sn_spec, 142, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '143' as sketa, substr(sn_spec, 143, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '144' as sketa, substr(sn_spec, 144, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '145' as sketa, substr(sn_spec, 145, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '146' as sketa, substr(sn_spec, 146, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '147' as sketa, substr(sn_spec, 147, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '148' as sketa, substr(sn_spec, 148, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '149' as sketa, substr(sn_spec, 149, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '150' as sketa, substr(sn_spec, 150, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '151' as sketa, substr(sn_spec, 151, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '152' as sketa, substr(sn_spec, 152, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '153' as sketa, substr(sn_spec, 153, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '154' as sketa, substr(sn_spec, 154, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '155' as sketa, substr(sn_spec, 155, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '156' as sketa, substr(sn_spec, 156, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '157' as sketa, substr(sn_spec, 157, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '158' as sketa, substr(sn_spec, 158, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '159' as sketa, substr(sn_spec, 159, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '160' as sketa, substr(sn_spec, 160, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '161' as sketa, substr(sn_spec, 161, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '162' as sketa, substr(sn_spec, 162, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '163' as sketa, substr(sn_spec, 163, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '164' as sketa, substr(sn_spec, 164, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '165' as sketa, substr(sn_spec, 165, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '166' as sketa, substr(sn_spec, 166, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '167' as sketa, substr(sn_spec, 167, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '168' as sketa, substr(sn_spec, 168, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '169' as sketa, substr(sn_spec, 169, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '170' as sketa, substr(sn_spec, 170, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '171' as sketa, substr(sn_spec, 171, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '172' as sketa, substr(sn_spec, 172, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '173' as sketa, substr(sn_spec, 173, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '174' as sketa, substr(sn_spec, 174, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '175' as sketa, substr(sn_spec, 175, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '176' as sketa, substr(sn_spec, 176, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '177' as sketa, substr(sn_spec, 177, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '178' as sketa, substr(sn_spec, 178, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '179' as sketa, substr(sn_spec, 179, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '180' as sketa, substr(sn_spec, 180, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '181' as sketa, substr(sn_spec, 181, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '182' as sketa, substr(sn_spec, 182, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '183' as sketa, substr(sn_spec, 183, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '184' as sketa, substr(sn_spec, 184, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '185' as sketa, substr(sn_spec, 185, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '186' as sketa, substr(sn_spec, 186, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '187' as sketa, substr(sn_spec, 187, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '188' as sketa, substr(sn_spec, 188, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '189' as sketa, substr(sn_spec, 189, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '190' as sketa, substr(sn_spec, 190, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '191' as sketa, substr(sn_spec, 191, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '192' as sketa, substr(sn_spec, 192, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '193' as sketa, substr(sn_spec, 193, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '194' as sketa, substr(sn_spec, 194, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '195' as sketa, substr(sn_spec, 195, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '196' as sketa, substr(sn_spec, 196, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '197' as sketa, substr(sn_spec, 197, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '198' as sketa, substr(sn_spec, 198, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '199' as sketa, substr(sn_spec, 199, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
    union all
    select syadai_kt, frmno, '200' as sketa, substr(sn_spec, 200, 1) as skigo, updatetime, ldts from {{ref('stg_oemseisan')}} where skigo <> ' '
)
select * from stg_oemseisan200