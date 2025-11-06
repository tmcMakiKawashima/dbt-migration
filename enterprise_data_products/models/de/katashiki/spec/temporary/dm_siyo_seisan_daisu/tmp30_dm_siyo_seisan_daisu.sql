with t3 as (
  select
	  shashu_cd,
	  r_katashiki,
	  sk_y,
	  sk_m,
	  r_dist_code,
	  r_sfx_code,
      (
          max(case r_spec_keta when '001' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '002' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '003' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '004' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '005' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '006' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '007' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '008' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '009' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '010' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '011' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '012' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '013' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '014' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '015' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '016' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '017' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '018' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '019' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '020' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '021' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '022' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '023' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '024' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '025' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '026' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '027' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '028' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '029' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '030' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '031' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '032' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '033' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '034' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '035' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '036' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '037' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '038' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '039' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '040' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '041' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '042' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '043' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '044' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '045' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '046' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '047' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '048' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '049' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '050' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '051' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '052' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '053' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '054' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '055' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '056' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '057' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '058' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '059' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '060' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '061' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '062' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '063' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '064' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '065' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '066' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '067' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '068' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '069' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '070' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '071' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '072' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '073' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '074' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '075' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '076' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '077' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '078' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '079' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '080' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '081' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '082' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '083' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '084' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '085' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '086' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '087' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '088' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '089' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '090' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '091' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '092' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '093' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '094' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '095' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '096' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '097' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '098' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '099' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '100' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '101' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '102' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '103' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '104' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '105' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '106' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '107' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '108' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '109' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '110' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '111' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '112' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '113' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '114' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '115' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '116' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '117' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '118' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '119' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '120' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '121' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '122' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '123' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '124' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '125' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '126' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '127' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '128' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '129' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '130' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '131' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '132' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '133' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '134' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '135' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '136' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '137' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '138' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '139' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '140' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '141' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '142' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '143' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '144' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '145' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '146' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '147' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '148' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '149' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '150' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '151' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '152' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '153' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '154' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '155' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '156' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '157' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '158' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '159' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '160' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '161' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '162' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '163' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '164' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '165' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '166' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '167' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '168' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '169' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '170' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '171' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '172' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '173' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '174' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '175' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '176' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '177' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '178' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '179' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '180' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '181' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '182' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '183' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '184' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '185' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '186' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '187' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '188' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '189' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '190' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '191' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '192' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '193' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '194' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '195' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '196' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '197' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '198' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '199' then r_spec_kigo else ' ' end) ||
          max(case r_spec_keta when '200' then r_spec_kigo else ' ' end)
    ) AS SPEC200
--    from {{ref('tmp20_dm_siyo_seisan_daisu')}}
    from {{source('katashiki_db_spec','raw_tmp20_dm_siyo_seisan_daisu_test')}}
    group by
	    shashu_cd,
	    r_katashiki,
	    sk_y,
	    sk_m,
	    r_dist_code,
	    r_sfx_code
)
select * from t3