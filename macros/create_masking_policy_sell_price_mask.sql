{% macro create_masking_policy_sell_price_mask(node_database,node_schema) %}
CREATE MASKING POLICY IF NOT EXISTS {{node_database}}.{{node_schema}}.sell_price_mask AS (val number) 
  RETURNS number -> 0
{% endmacro %}
