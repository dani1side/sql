CREATE OR REPLACE TABLE keepcoding.ivr_customers_phone AS
WITH ranked_calls AS (
  SELECT
    calls_ivr_id,
    customer_phone,
    ROW_NUMBER() OVER (PARTITION BY cast(calls_ivr_id as string) ORDER BY calls_ivr_id, customer_phone) AS row_num
  FROM
    `keepcoding.ivr_detail`
)

SELECT
  calls_ivr_id,
  customer_phone
FROM
  ranked_calls
WHERE
  row_num = 1;
