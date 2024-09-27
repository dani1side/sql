CREATE OR REPLACE TABLE keepcoding.ivr_bill_account_id AS
WITH ranked_calls AS (
  SELECT
    calls_ivr_id,
    billing_account_id,
    ROW_NUMBER() OVER (PARTITION BY cast(calls_ivr_id as string) ORDER BY calls_ivr_id, billing_account_id) AS row_num
  FROM
    `keepcoding.ivr_detail`
)

SELECT
  calls_ivr_id,
  billing_account_id
FROM
  ranked_calls
WHERE
  row_num = 1;
