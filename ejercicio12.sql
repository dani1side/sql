CREATE OR REPLACE TABLE keepcoding.ivr_summary AS
WITH calls AS
(
  select *
  from `keepcoding.ivr_detail`
  QUALIFY ROW_NUMBER() OVER(PARTITION BY cast(calls_ivr_id as string) ORDER BY calls_ivr_id DESC) = 1)
, modules AS
(
  select ivr_id, COUNT(*) AS modulos
  from `keepcoding.ivr_modules`
  GROUP BY ivr_id
)

select
    calls.calls_ivr_id,
    calls.calls_phone_number,
    calls.calls_ivr_result,
    aggregation.vdn_aggregation,
    calls.calls_start_date,
    calls.calls_end_date,
    calls.calls_total_duration,
    calls.calls_customer_segment,
    calls.calls_ivr_language,
    modules.modulos,
    calls.calls_module_aggregation,
    documents.document_type,
    documents.document_identification,
    phone.customer_phone,
    bill.billing_account_id,
    masiva.masiva_lg,
    info_phone.info_by_phone_lg,
    dni.info_by_dni_lg,
    recall.llamada_repetida,
    recall.causa_rellamada
FROM calls
LEFT
JOIN modules
  ON calls.calls_ivr_id = modules.ivr_id
LEFT
JOIN `keepcoding.calls_aggregation` aggregation
  ON calls.calls_ivr_id = aggregation.ivr_id
LEFT
JOIN `keepcoding.ivr_documents` documents
  ON calls.calls_ivr_id = documents.calls_ivr_id
LEFT
JOIN `keepcoding.ivr_customers_phone` phone
  ON calls.calls_ivr_id = phone.calls_ivr_id
LEFT
JOIN `keepcoding.ivr_bill_account_id` bill
  ON calls.calls_ivr_id = bill.calls_ivr_id
LEFT
JOIN `keepcoding.ivr_masiva_lg` masiva
  ON calls.calls_ivr_id = masiva.ivr_id
LEFT
JOIN `keepcoding.ivr_info_by_dni` dni
  ON calls.calls_ivr_id = dni.ivr_id
LEFT
JOIN `keepcoding.ivr_info_by_phone` info_phone
  ON calls.calls_ivr_id = info_phone.ivr_id
LEFT
JOIN `keepcoding.ivr_repeat_recall` recall
  ON calls.calls_ivr_id = recall.ivr_id
