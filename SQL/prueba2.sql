
WITH
  temporal AS (
  SELECT
    DISTINCT po.loan_id,
    po.user_id,
    CASE
      WHEN LOWER(po.loan_type) = "real estate" THEN "Real Estate"
      ELSE "Others"
  END
    AS loan_type_standard
  FROM
    `id-riesgo.datos_p3.prestamos_out` po
  JOIN
    `id-riesgo.datos_p3.user_info` ui
  ON
    po.user_id = ui.user_id
  ORDER BY
    po.user_id )

SELECT
  user_id,
  COUNT(loan_id) AS total_loans,
  SUM(CASE WHEN loan_type_standard = "Others" THEN 1 ELSE 0 END) AS conteo_others,
  SUM(CASE WHEN loan_type_standard = "Real Estate" THEN 1 ELSE 0 END) AS conteo_real_estate
FROM
  temporal
  
GROUP BY
  user_id
ORDER BY
  user_id
