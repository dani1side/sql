CREATE OR REPLACE TABLE keepcoding.calls_aggregation AS
SELECT calls.ivr_id,
        (CASE
            when STARTS_WITH(calls.vdn_label, 'ATC') then 'FRONT'
            when left(calls.vdn_label, 4) = 'TECH' then 'TECH'
            when calls.vdn_label = 'ABSORPTION' then 'ABSORPTION'
        else 'RESTO'
        end) AS vdn_aggregation
FROM `keepcoding.ivr_calls` calls
