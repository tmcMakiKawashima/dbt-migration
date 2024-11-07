{% macro create_masking_policy_cost_mask(node_database,node_schema) %}

-- snowflake上で作成されているため、暫定対応でダミーを定義（要修正）
create masking policy if not exists {{node_database}}.{{node_schema}}.dummy_mask AS (val string) 
  returns string ->
      case when current_role() in ('dbt_role') then val 
      else '********'
      end

{% endmacro %}