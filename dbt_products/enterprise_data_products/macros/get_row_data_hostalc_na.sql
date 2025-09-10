{% macro get_row_data_hostalc_na(code) %}  
  {% set get_results %}
    select * from {{ source('common_tbl_db_public', 'raw_m_hostalc_psc_plantcode_kaigai') }} where server = 'NA'
  {% endset %}
  {% set results = run_query(get_results) %}
  {% if execute %}
    {% set namelist = results.columns[0].values() %}
  {% else %}
    {% set namelist = [] %}
  {% endif %}
  {% for psc_alccode in namelist %}
    {% if loop.first %}
      select * from snowpipe_db.supplydemand.hostalc_{{psc_alccode}}_{{code}}
    {% else %}
      union all
      select * from snowpipe_db.supplydemand.hostalc_{{psc_alccode}}_{{code}}
    {% endif %}
  {% endfor %}
{% endmacro %}