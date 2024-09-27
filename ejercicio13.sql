CREATE OR REPLACE FUNCTION keepcoding.fnc_clean_integer (entero INT64) RETURNS INT64 AS
  ((SELECT ifnull(entero, -999999)))

  --select keepcoding.fnc_clean_integer(6) as resultado
  --select keepcoding.fnc_clean_integer(null) as resultado
