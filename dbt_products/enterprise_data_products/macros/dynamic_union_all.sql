-- 引数：
--   dbt_model: 動的union allを行うdbtモデル
{% macro dynamic_union_all(out_db_name, out_schema_name, out_view_name) %}

  -- union all対象のDB名、スキーマ名、テーブル名を取得
  {% set get_results %}
    select * from {{ source('common_tbl_db_public', 'raw_dbt_union_all_tables') }}
     where out_db_name = '{{ out_db_name }}'
       and out_schema_name = '{{ out_schema_name }}'
       and out_view_name = '{{ out_view_name }}'
  {% endset %}

  {% set results = run_query(get_results) %}

  {% if execute %}
    -- 取得したDB名、スキーマ名、テーブル名でunion all句を作成
    {{ print('execute') }}
    {{ print(results | length) }}

    {% for item in results %}
      {{ print(item) }}
      {% if loop.first %}
        select * from {{ item[0] }}.{{ item[1] }}.{{ item[2] }}
      {% else %}
        union all
        select * from {{ item[0] }}.{{ item[1] }}.{{ item[2] }}
      {% endif %}
    {% endfor %}

  {% else %}
    {{ print('no execute') }}
  {% endif %}

{% endmacro %}