{% snapshot scd_mitsumori_ordersyorikekka_atop %}
{{
    config(
        unique_key="concat_ws('-',
                    iff(dataid4 is null, '', dataid4),      -- nullの場合はブランクで置き換える処理
                    iff(ordmtmrzok is null, '', ordmtmrzok),      -- nullの場合はブランクで置き換える処理
                    iff(datazok is null, '', datazok),      -- nullの場合はブランクで置き換える処理
                    iff(dlrcd is null, '', dlrcd),      -- nullの場合はブランクで置き換える処理
                    iff(juchuymd is null, '1970-01-01', juchuymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(odrno is null, '', odrno),      -- nullの場合はブランクで置き換える処理
                    iff(itemno is null, '', itemno),      -- nullの場合はブランクで置き換える処理
                    iff(jurrsymd is null, '1970-01-01', jurrsymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(portcd is null, '', portcd),      -- nullの場合はブランクで置き換える処理
                    iff(yusokbn is null, '', yusokbn),      -- nullの場合はブランクで置き換える処理
                    iff(ordrtype is null, '', ordrtype),      -- nullの場合はブランクで置き換える処理
                    iff(ordtsyri is null, '', ordtsyri),      -- nullの場合はブランクで置き換える処理
                    iff(knkyudo is null, '', knkyudo),      -- nullの場合はブランクで置き換える処理
                    iff(odrzok is null, '', odrzok),      -- nullの場合はブランクで置き換える処理
                    iff(yumukbn is null, '', yumukbn),      -- nullの場合はブランクで置き換える処理
                    iff(hyoftnbs is null, '', hyoftnbs),      -- nullの場合はブランクで置き換える処理
                    iff(kyoseicd is null, '', kyoseicd),      -- nullの場合はブランクで置き換える処理
                    iff(hanbaicd is null, '', hanbaicd),      -- nullの場合はブランクで置き換える処理
                    iff(bocd is null, '', bocd),      -- nullの場合はブランクで置き換える処理
                    iff(extehacd is null, '', extehacd),      -- nullの場合はブランクで置き換える処理
                    iff(spdiscount is null, '', spdiscount),      -- nullの場合はブランクで置き換える処理
                    iff(tuikakbn is null, '', tuikakbn),      -- nullの場合はブランクで置き換える処理
                    iff(kkksrkbn is null, '', kkksrkbn),      -- nullの場合はブランクで置き換える処理
                    iff(sagyokgnymd is null, '1970-01-01', sagyokgnymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(zuizikbn is null, '', zuizikbn),      -- nullの場合はブランクで置き換える処理
                    iff(zuizirtu is null, '', zuizirtu),      -- nullの場合はブランクで置き換える処理
                    iff(betmkcd is null, '', betmkcd),      -- nullの場合はブランクで置き換える処理
                    iff(jhinban is null, '', jhinban),      -- nullの場合はブランクで置き換える処理
                    iff(juchusu is null, 0, juchusu),      -- nullの場合は0で置き換える処理
                    iff(tarifcd is null, '', tarifcd),      -- nullの場合はブランクで置き換える処理
                    iff(zonecd is null, '', zonecd),      -- nullの場合はブランクで置き換える処理
                    iff(distcom is null, '', distcom),      -- nullの場合はブランクで置き換える処理
                    iff(tansjymd is null, '1970-01-01', tansjymd),      -- nullの場合は日付初期値で置き換える処理
                    iff(dlrmei is null, '', dlrmei),      -- nullの場合はブランクで置き換える処理
                    iff(pshukakbn is null, '', pshukakbn),      -- nullの場合はブランクで置き換える処理
                    iff(douknhukakbn is null, '', douknhukakbn),      -- nullの場合はブランクで置き換える処理
                    iff(sytyubanflg is null, '', sytyubanflg),      -- nullの場合はブランクで置き換える処理
                    iff(tandkban is null, '', tandkban),      -- nullの場合はブランクで置き換える処理
                    iff(knpktcd is null, '', knpktcd),      -- nullの場合はブランクで置き換える処理
                    iff(hanstsakcd is null, '', hanstsakcd),      -- nullの場合はブランクで置き換える処理
                    iff(snttsryokey is null, '', snttsryokey),      -- nullの場合はブランクで置き換える処理
                    iff(kessai is null, '', kessai),      -- nullの場合はブランクで置き換える処理
                    iff(tatnkbn is null, '', tatnkbn),      -- nullの場合はブランクで置き換える処理
                    iff(tndkinv is null, '', tndkinv),      -- nullの場合はブランクで置き換える処理
                    iff(tarifdkn is null, '', tarifdkn),      -- nullの場合はブランクで置き換える処理
                    iff(syukkakyotenkbn is null, '', syukkakyotenkbn),      -- nullの場合はブランクで置き換える処理
                    iff(shinban is null, '', shinban),      -- nullの場合はブランクで置き換える処理
                    iff(daitityp is null, '', daitityp),      -- nullの場合はブランクで置き換える処理
                    iff(hinmeien is null, '', hinmeien),      -- nullの場合はブランクで置き換える処理
                    iff(tkytnkbn is null, '', tkytnkbn),      -- nullの場合はブランクで置き換える処理
                    iff(tkytnkinvkgi1 is null, 0, tkytnkinvkgi1),      -- nullの場合は0で置き換える処理
                    iff(siteitnk11syo is null, 0, siteitnk11syo),      -- nullの場合は0で置き換える処理
                    iff(tukacd is null, '', tukacd),      -- nullの場合はブランクで置き換える処理
                    iff(tokeibricd is null, '', tokeibricd),      -- nullの場合はブランクで置き換える処理
                    iff(situryog8 is null, 0, situryog8),      -- nullの場合は0で置き換える処理
                    iff(yoseki3 is null, 0, yoseki3),      -- nullの場合は0で置き換える処理
                    iff(syusisu6 is null, 0, syusisu6),      -- nullの場合は0で置き換える処理
                    iff(cansijsu is null, 0, cansijsu),      -- nullの場合は0で置き換える処理
                    iff(hinmkcd is null, '', hinmkcd),      -- nullの場合はブランクで置き換える処理
                    iff(bohcd is null, '', bohcd),      -- nullの場合はブランクで置き換える処理
                    iff(racd is null, '', racd),      -- nullの場合はブランクで置き換える処理
                    iff(rejectcd is null, '', rejectcd),      -- nullの場合はブランクで置き換える処理
                    iff(propenid is null, '', propenid),      -- nullの場合はブランクで置き換える処理
                    iff(ordpenid is null, '', ordpenid),      -- nullの場合はブランクで置き換える処理
                    iff(tantokbn is null, '', tantokbn),      -- nullの場合はブランクで置き換える処理
                    iff(kaiseisyahinumu is null, '', kaiseisyahinumu),      -- nullの場合はブランクで置き換える処理
                    iff(kaiseisyahinkbn is null, '', kaiseisyahinkbn),      -- nullの場合はブランクで置き換える処理
                    iff(siyusnsyasyucd is null, '', siyusnsyasyucd),      -- nullの場合はブランクで置き換える処理
                    iff(syasyukbn is null, '', syasyukbn),      -- nullの場合はブランクで置き換える処理
                    iff(siyusnkyokucd is null, '', siyusnkyokucd),      -- nullの場合はブランクで置き換える処理
                    iff(sksjkyokucd is null, '', sksjkyokucd),      -- nullの場合はブランクで置き換える処理
                    iff(kaiseisyaracd is null, '', kaiseisyaracd),      -- nullの場合はブランクで置き換える処理
                    ldts)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_mitsumori_ordersyorikekka_atop') }}
{% endsnapshot %}