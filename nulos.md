```sql
SELECT 

 COUNT(CASE WHEN user_i.`user_id` IS NULL then 1 END) AS user_null,
 COUNT(CASE WHEN user_i.`age` IS NULL then 1 END) AS  nulos_age,
 COUNT(CASE WHEN user_i.`last_month_salary` IS NULL then 1 END) AS nulos_salario,
 COUNT(CASE WHEN user_i.`number_dependents` IS NULL then 1 END) AS nulos_n_dependents
 FROM `id-riesgo.datos_p3.user_info` user_i; 

 SELECT 

 COUNT(CASE WHEN outd.`loan_id` is null then 1 end) AS nulos_loan,
COUNT(CASE WHEN outd.`loan_type` is null then 1 end) AS nulos_l_type

FROM  `id-riesgo.datos_p3.outstanding` outd;

SELECT

COUNT(CASE WHEN ddet.`more_90_days_overdue` is null then 1 end) as nulos_more90,	
COUNT(CASE WHEN ddet.`using_lines_not_secured_personal_assets` is null then 1 end) as nulos_lines,	
COUNT(CASE WHEN ddet.`number_times_delayed_payment_loan_30_59_days` is null then 1 end) as nulos_number30_59,	
COUNT(CASE WHEN ddet.`debt_ratio` is null then 1 end) as nulos_debt,
COUNT(CASE WHEN ddet.`number_times_delayed_payment_loan_60_89_days` is null then 1 end) as nulos_60_89

FROM `id-riesgo.datos_p3.details` ddet;


SELECT
COUNT(CASE WHEN deff.`user_id` is null then 1 end)  as nulos_user_flag,
COUNT(CASE WHEN deff.`default_flag` is null then 1 end)  as nulos_flag	


FROM `id-riesgo.datos_p3.default` deff;

```

Determinando los nulos se tiene que:
![alt text](/Imagenes/image.png)

De todos nuestros datos, tenemos nulos en 2 de nuestros datos.

Para la variable dependents, se sustituyen los nulos con 0.
Para la variable `last_month_salary` se decide, basado en las medidas estadísticas, se obtiene que, separando en grupos de los que pagan bien contra los que pagan mal, que los resultados son:

![alt text](/Imagenes/image-1.png)

Los datos faltantes son en mayor proporción:
![alt text](/Imagenes/image-3.png)

* Para los dependientes, los valores nulos son en mayor proporción (933 vs 10) de mas nulos, para los que pagan bien.

![alt text](/Imagenes/image-2.png)
* Para el último salario mensual reportado, los valores nulos son en mayor proporción (7069 vs 130) de más nulos, para los que pagan bien.

Y de esta forma se decide asignar el valor de la mediana para cada grupo, para así evitar tener valores nulos y poder tomar decisiones más cercanas a la situación de cada grupo de pagadores. 