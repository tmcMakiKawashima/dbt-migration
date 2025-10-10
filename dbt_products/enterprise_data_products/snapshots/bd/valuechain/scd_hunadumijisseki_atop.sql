{% snapshot scd_hunadumijisseki_atop %}
{{
    config(
        unique_key="concat_ws('-',
                    iff(hkanri is null, '', hkanri),      -- nullの場合はブランクで置き換える処理
                    iff(senmei is null, '', senmei),      -- nullの場合はブランクで置き換える処理
                    iff(disksmscd is null, '', disksmscd),      -- nullの場合はブランクで置き換える処理
                    iff(sensyacd is null, '', sensyacd),      -- nullの場合はブランクで置き換える処理
                    iff(yusokbn is null, '', yusokbn),      -- nullの場合はブランクで置き換える処理
                    iff(tumimei is null, '', tumimei),      -- nullの場合はブランクで置き換える処理
                    iff(niagmei is null, '', niagmei),      -- nullの場合はブランクで置き換える処理
                    iff(tumisvkbn is null, '', tumisvkbn),      -- nullの場合はブランクで置き換える処理
                    iff(csymd is null, '1970-01-01', csymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(funaymd is null, '1970-01-01', funaymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(eta is null, '1970-01-01', eta),      -- nullの場合は日付初期値で置き換える処理
                    iff(sstcd is null, '', sstcd),      -- nullの場合はブランクで置き換える処理
                    iff(fnsshiuntnfgox is null, 0, fnsshiuntnfgox),      -- nullの場合は0で置き換える処理
                    iff(fnzmjsklclhiy is null, '', fnzmjsklclhiy),      -- nullの場合はブランクで置き換える処理
                    iff(blno20c is null, '', blno20c),      -- nullの場合はブランクで置き換える処理
                    iff(invno is null, '', invno),      -- nullの場合はブランクで置き換える処理
                    iff(dlrcd_g_dist is null, '', dlrcd_g_dist),      -- nullの場合はブランクで置き換える処理
                    iff(dlrcd_g_fd is null, '', dlrcd_g_fd),      -- nullの場合はブランクで置き換える処理
                    iff(hanbaicd is null, '', hanbaicd),      -- nullの場合はブランクで置き換える処理
                    iff(syohnkbn is null, '', syohnkbn),      -- nullの場合はブランクで置き換える処理
                    iff(syosyakbn is null, '', syosyakbn),      -- nullの場合はブランクで置き換える処理
                    iff(tatnkbn is null, '', tatnkbn),      -- nullの場合はブランクで置き換える処理
                    iff(hanstsakcd is null, '', hanstsakcd),      -- nullの場合はブランクで置き換える処理
                    iff(kessai is null, '', kessai),      -- nullの場合はブランクで置き換える処理
                    iff(yumukbn is null, '', yumukbn),      -- nullの場合はブランクで置き換える処理
                    iff(tndkinv is null, '', tndkinv),      -- nullの場合はブランクで置き換える処理
                    iff(invhktka is null, '', invhktka),      -- nullの場合はブランクで置き換える処理
                    iff(tkytankainvgokx is null, 0, tkytankainvgokx),      -- nullの場合は0で置き換える処理
                    iff(tkytankayengokx is null, 0, tkytankayengokx),      -- nullの場合は0で置き換える処理
                    iff(invaun is null, 0, invaun),      -- nullの場合は0で置き換える処理
                    iff(hnhokn is null, 0, hnhokn),      -- nullの場合は0で置き換える処理
                    iff(pmkbn is null, '', pmkbn),      -- nullの場合はブランクで置き換える処理
                    iff(hntsrkgi is null, 0, hntsrkgi),      -- nullの場合は0で置き換える処理
                    iff(gystl is null, 0, gystl),      -- nullの場合は0で置き換える処理
                    iff(invtnisyksukei is null, 0, invtnisyksukei),      -- nullの場合は0で置き換える処理
                    iff(casesuinvgokx is null, 0, casesuinvgokx),      -- nullの場合は0で置き換える処理
                    iff(invbiymd is null, '1970-01-01', invbiymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(kansanratesyax is null, 0, kansanratesyax),      -- nullの場合は0で置き換える処理
                    iff(kansanratesyox is null, 0, kansanratesyox),      -- nullの場合は0で置き換える処理
                    iff(toricd is null, '', toricd),      -- nullの場合はブランクで置き換える処理
                    iff(gifsyohizei13 is null, 0, gifsyohizei13),      -- nullの場合は0で置き換える処理
                    iff(uriageymd is null, '1970-01-01', uriageymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(pkgsutal is null, 0, pkgsutal),      -- nullの場合は0で置き換える処理
                    iff(blno20i is null, '', blno20i),      -- nullの場合はブランクで置き換える処理
                    iff(drftno is null, '', drftno),      -- nullの場合はブランクで置き換える処理
                    iff(caseno is null, '', caseno),      -- nullの場合はブランクで置き換える処理
                    iff(grwtkg is null, 0, grwtkg),      -- nullの場合は0で置き換える処理
                    iff(ysgrs is null, 0, ysgrs),      -- nullの場合は0で置き換える処理
                    iff(pkgsu2 is null, 0, pkgsu2),      -- nullの場合は0で置き換える処理
                    iff(kpkytnkbn is null, '', kpkytnkbn),      -- nullの場合はブランクで置き換える処理
                    iff(tomkmkbn is null, '', tomkmkbn),      -- nullの場合はブランクで置き換える処理
                    iff(pshukakbn is null, '', pshukakbn),      -- nullの場合はブランクで置き換える処理
                    iff(casecd is null, '', casecd),      -- nullの場合はブランクで置き換える処理
                    iff(hanyymd is null, '1970-01-01', hanyymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(konknymd is null, '1970-01-01', konknymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(nisgt is null, '', nisgt),      -- nullの場合はブランクで置き換える処理
                    iff(rtkbn is null, '', rtkbn),      -- nullの場合はブランクで置き換える処理
                    iff(shinban is null, '', shinban),      -- nullの場合はブランクで置き換える処理
                    iff(odrno is null, '', odrno),      -- nullの場合はブランクで置き換える処理
                    iff(itemno is null, '', itemno),      -- nullの場合はブランクで置き換える処理
                    iff(juchuymd is null, '1970-01-01', juchuymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(syusiymd is null, '1970-01-01', syusiymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(shinmei is null, '', shinmei),      -- nullの場合はブランクで置き換える処理
                    iff(syukkasu is null, 0, syukkasu),      -- nullの場合は0で置き換える処理
                    iff(syukancd is null, '', syukancd),      -- nullの場合はブランクで置き換える処理
                    iff(tekiyotankaen is null, 0, tekiyotankaen),      -- nullの場合は0で置き換える処理
                    iff(tekiyotankainv is null, 0, tekiyotankainv),      -- nullの場合は0で置き換える処理
                    iff(tokeibricd is null, '', tokeibricd),      -- nullの場合はブランクで置き換える処理
                    iff(kyokacd is null, '', kyokacd),      -- nullの場合はブランクで置き換える処理
                    iff(raisenscd is null, '', raisenscd),      -- nullの場合はブランクで置き換える処理
                    iff(kknhncd is null, '', kknhncd),      -- nullの場合はブランクで置き換える処理
                    iff(basecd is null, '', basecd),      -- nullの場合はブランクで置き換える処理
                    iff(tarifcd is null, '', tarifcd),      -- nullの場合はブランクで置き換える処理
                    iff(zonecd is null, '', zonecd),      -- nullの場合はブランクで置き換える処理
                    iff(daicom is null, '', daicom),      -- nullの場合はブランクで置き換える処理
                    iff(odrzok is null, '', odrzok),      -- nullの場合はブランクで置き換える処理
                    iff(knkyudo is null, '', knkyudo),      -- nullの場合はブランクで置き換える処理
                    iff(tkytnkbn is null, '', tkytnkbn),      -- nullの場合はブランクで置き換える処理
                    iff(endsijymd is null, '1970-01-01', endsijymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(bokbn is null, '', bokbn),      -- nullの場合はブランクで置き換える処理
                    iff(pfcd is null, '', pfcd),      -- nullの場合はブランクで置き換える処理
                    iff(syohincd is null, '', syohincd),      -- nullの場合はブランクで置き換える処理
                    iff(hinmkcd is null, '', hinmkcd),      -- nullの場合はブランクで置き換える処理
                    iff(brnet is null, 0, brnet),      -- nullの場合は0で置き換える処理
                    iff(tskbn is null, '', tskbn),      -- nullの場合はブランクで置き換える処理
                    iff(gaikoksngaihkbn is null, '', gaikoksngaihkbn),      -- nullの場合はブランクで置き換える処理
                    ldts)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_hunadumijisseki_atop') }}
{% endsnapshot %}