select
    ivr_id,
    phone_number,
    start_date,
    llamada_anterior,
    llamada_siguiente,
    case when llamada_siguiente is null then 0 else
        case when DATETIME_DIFF(llamada_siguiente, start_date, minute) > 0 and DATETIME_DIFF(llamada_siguiente, start_date, minute) < 1440 then 1 else 0 end
    end as causa_rellamada,
    case when llamada_anterior is null then 0 else
        case when DATETIME_DIFF(start_date, llamada_anterior, minute) > 0 and DATETIME_DIFF(start_date, llamada_anterior, minute) < 1440 then 1 else 0 end
    end as llamada_repetida
from
(
  select
    ivr_id,
    phone_number,
    start_date,
    lead(start_date) over(partition by phone_number order by start_date) as llamada_siguiente,
    lag(start_date) over(partition by phone_number order by start_date) as llamada_anterior
  from `keepcoding.ivr_calls`
  order by phone_number
) as cta
