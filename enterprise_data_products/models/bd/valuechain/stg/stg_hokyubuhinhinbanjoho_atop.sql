with stg_hokyubuhinhinbanjoho_atop as (
    select
        rtrim(hinban, ' 　')::varchar(20) as hinban,
        iff(trim(hinmeien, ' 　') = '',null,rtrim(hinmeien, ' 　'))::varchar(20) as hinmeien,
        iff(trim(zensekaisiki, ' 　') = '',null,rtrim(zensekaisiki, ' 　'))::varchar(6) as zensekaisiki,
        iff(trim(zensekaisyuki, ' 　') = '',null,rtrim(zensekaisyuki, ' 　'))::varchar(6) as zensekaisyuki,
        iff(trim(nihonkyokusiki, ' 　') = '',null,rtrim(nihonkyokusiki, ' 　'))::varchar(6) as nihonkyokusiki,
        iff(trim(nihonkyokusyuki, ' 　') = '',null,rtrim(nihonkyokusyuki, ' 　'))::varchar(6) as nihonkyokusyuki,
        iff(trim(bhntehaikaisiym, ' 　') = '',null,rtrim(bhntehaikaisiym, ' 　'))::varchar(6) as bhntehaikaisiym,
        iff(trim(sinsetusppnnmbr, ' 　') = '',null,rtrim(sinsetusppnnmbr, ' 　'))::varchar(10) as sinsetusppnnmbr,
        iff(trim(haisinsppnnmbr, ' 　') = '',null,rtrim(haisinsppnnmbr, ' 　'))::varchar(10) as haisinsppnnmbr,
        iff(trim(brnet, ' 　') = '',null,to_decimal(to_decimal(brnet)/10,9,1))::decimal(9,1) as brnet,
        iff(trim(buturyutani1, ' 　') = '',null,to_decimal(buturyutani1,7,0))::decimal(7,0) as buturyutani1,
        iff(trim(buturyutani2, ' 　') = '',null,to_decimal(buturyutani2,7,0))::decimal(7,0) as buturyutani2,
        iff(trim(buturyutani3, ' 　') = '',null,to_decimal(buturyutani3,7,0))::decimal(7,0) as buturyutani3,
        iff(trim(zantikbn, ' 　') = '',null,rtrim(zantikbn, ' 　'))::varchar(1) as zantikbn,
        iff(trim(mtuserid, ' 　') = '',null,rtrim(mtuserid, ' 　'))::varchar(16) as mtuserid,
        iff(trim(mttime, ' 　') = '',null,try_to_timestamp_ntz(mttime,'YYYY-MM-DD-HH24.MI.SS.FF9')) as mttime,
        ldts,
        row_number() over (
            partition by 
                hinban
            order by line_number desc
        ) aggkey
    from {{ ref('substr_ktrla01vzz0kvs00m1') }}
    where ldts = (select max(ldts) from {{ ref('substr_ktrla01vzz0kvs00m1') }})
)
select * exclude(aggkey)
from stg_hokyubuhinhinbanjoho_atop
where aggkey = 1