Se estandarizó la columna de loan_type al mismo tiempo que se unificaron los datos para la sumatoria del tipo de préstamo para cada user_id, con la siguiente formula:

 ```sql
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

```
Quedando como resultado 35.575 usuarios de los que tenemos detalle de sus préstamos, en comparación con los  36.000 usuarios que manejamos en nuestra base de datos.

Para la unificación final,  para todos los usuarios que no tienen detalle de si su tipo de préstamo es Real Estate u Otro, se asignará 0 a estos valores.

A través de la siguiente consulta:

```sql
select
a.*,
IF(b.total_loans is null, 0, b.total_loans) total_loans,
IF(b.conteo_others is null, 0 , b.conteo_others ) conteo_others,
IF(b.conteo_real_estate is null, 0, b.conteo_real_estate) conteo_real_estate
from
`id-riesgo.datos_p3.info_user` a
LEFT join
`id-riesgo.datos_p3.loan_id_group` b
ON

a.id_usuario = b.user_id
```
