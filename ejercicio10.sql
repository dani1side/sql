CREATE OR REPLACE TABLE keepcoding.ivr_info_by_dni AS

WITH info_by_dni AS (
  SELECT
    calls_ivr_id,
    count(*) as dni
  FROM
    `keepcoding.ivr_detail`
  where step_name = 'CUSTOMERINFOBYDNI.TX' and step_result = 'OK'
  group by calls_ivr_id
)

select
  cta.ivr_id,
  case when dni is null then 0 else 1 end as info_by_dni_lg
from
(
  SELECT
    calls.ivr_id,
    info_by_dni.dni
  FROM
    keepcoding.ivr_calls calls
  left join
    info_by_dni on(calls.ivr_id = info_by_dni.calls_ivr_id)
) as cta
