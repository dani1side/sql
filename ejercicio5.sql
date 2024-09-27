CREATE OR REPLACE TABLE keepcoding.ivr_documents AS
WITH ranked_calls AS (
  SELECT
    calls_ivr_id,
    document_type,
    document_identification,
    ROW_NUMBER() OVER (PARTITION BY cast(calls_ivr_id as string) ORDER BY calls_ivr_id, document_type) AS row_num
  FROM
    `keepcoding.ivr_detail`
)

SELECT
  calls_ivr_id,
  document_type,
  document_identification
FROM
  ranked_calls
WHERE
  row_num = 1;
