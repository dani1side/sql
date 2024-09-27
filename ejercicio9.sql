CREATE OR REPLACE TABLE keepcoding.ivr_info_by_phone AS

WITH info_by_phone AS (
  SELECT
    calls_ivr_id,
    count(*) as step
  FROM
    `keepcoding.ivr_detail`
  where step_name = 'CUSTOMERINFOBYPHONE.TX' and step_result = 'OK'
  group by calls_ivr_id
)

select
  cta.ivr_id,
  case when step is null then 0 else 1 end as info_by_phone_lg
from
(
  SELECT
    calls.ivr_id,
    info_by_phone.step
  FROM
    keepcoding.ivr_calls calls
  left join
    info_by_phone on(calls.ivr_id = info_by_phone.calls_ivr_id)
) as cta
