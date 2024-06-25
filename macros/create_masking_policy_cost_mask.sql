{% macro create_masking_policy_cost_mask(node_database,node_schema) %}
CREATE MASKING POLICY IF NOT EXISTS {{node_database}}.{{node_schema}}.cost_mask AS (val number) 
  RETURNS number -> 0
{% endmacro %}
