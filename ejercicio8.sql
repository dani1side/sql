CREATE OR REPLACE TABLE keepcoding.ivr_masiva_lg AS

WITH averias_calls AS (
  SELECT
    calls_ivr_id,
    count(*) as averia
  FROM
    `keepcoding.ivr_detail`
  where module_name = 'AVERIA_MASIVA'
  group by calls_ivr_id
)

select
  cta.ivr_id,
  case when averia is null then 0 else 1 end as masiva_lg
from
(
  SELECT
    calls.ivr_id,
    averias_calls.averia
  FROM
    keepcoding.ivr_calls calls
  left join
    averias_calls on(calls.ivr_id = averias_calls.calls_ivr_id)
) as cta
