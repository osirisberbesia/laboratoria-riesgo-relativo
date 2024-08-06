<table><center>
  <tr>
    <td>
      <img src="logo.png" alt="alt text" width="50%"/>
    </td>
  </tr>
</table>

<h1 style="color:#8C5511;">Proyecto 3 - Banco Super Caja</h1>
<h2 style="color:#8C5511;">Riesgo Relativo</h2></center>



## Introducción

En respuesta al incremento de solicitudes de crédito debido a la reducción de tasas de interés, el banco "Super Caja" enfrenta una sobrecarga en su proceso manual de análisis de crédito. Este proyecto propone automatizar el análisis mediante técnicas avanzadas de datos para mejorar la eficiencia y precisión en la evaluación del riesgo crediticio. El objetivo es desarrollar un sistema de puntuación que clasifique a los solicitantes por riesgo, utilizando también en comparación de esta nueva métrica que se creará, una métrica existente que clasifica a los clientes entre buenos o malos pagadores, para optimizar las decisiones de concesión de crédito y reducir el riesgo de incumplimiento.


## Objetivos

* Identificar y tratar datos nulos, duplicados y outliers en el conjunto de datos.
* Crear nuevas variables y tablas auxiliares para mejorar la calidad y la riqueza del análisis.
* Calcular cuartiles para las variables de Edad y Cantidad de Préstamos para detectar posibles inconsistencias y entender la distribución.
* Segmentar la variable more_90_days_overdue para obtener insights sobre el comportamiento de los clientes en relación a su morosidad.
* Automatizar el proceso de análisis crediticio y desarrollar un nuevo score crediticio para evaluar el riesgo relativo.
* Incrementar la eficiencia operativa del banco y aliviar la sobrecarga del equipo de análisis de crédito.

## Integrante
* Osiris Berbesia
## Herramientas y Tecnologías
* SQL de BigQuery
* Visual Studio Code
* Markdown
* Google Console - Python
* Documentación de librerías Python:
  * Numpy
  * Matplotlib
  * Seaborn
  * Pandas
* OpenAI - ChatGPT
* Google Slides


## Procesamiento y análisis

* Análisis de datos nulos, sustitución de nulos por promedios de sus respectivas variables.
* Datos duplicados en variables de datos únicos, no encontrados.
* Cálculo de cuartiles para las variables que serán estudiadas.


## Creación de nuevas variables
## Unificación de tablas
## Resultados y Conclusiones
## Limitaciones-Próximos Pasos
## Limitaciones
## Próximos pasos
## Enlaces de interés


¿Qué variables influyen más en el riesgo de incumplimiento? 
¿Cómo se correlacionan estas variables entre sí y con el comportamiento de pago de los clientes? 
 ¿Cómo decidir cuántos y cuáles niveles de riesgo crear? 
 ¿Cómo determino las reglas para segmentar el riesgo basado en las variables disponibles?
 ¿Qué información es realmente importante? 
 ¿Cómo comunico los riesgos identificados de manera efectiva? ¿En qué invertir los minutos que tengo para presentar?

Creación del proyecto
project: proyecto3-riesgo-relativo 
id: id-riesgo
conjunto de datos: datos_p3
tablas:
* user_info
* outstanding
* details
* default

** NO DEBE utilizarse la variable GENERO en el modelo de datos
** Además del género, existen otras variables que no están autorizadas, como la etnia, la religión, etc

-- La multicolinealidad generalmente ocurre cuando hay altas correlaciones entre dos o más variables predictoras . En otras palabras, una variable predictora se puede utilizar para predecir la otra. Esto crea información redundante, sesgando los resultados en un modelo de regresión. Ejemplos de variables predictoras correlacionadas (también denominadas predictores multicolineales) son: la altura y el peso de una persona, la edad y el precio de venta de un automóvil, o los años de educación y los ingresos anuales.


-- **Para ayudar a tomar la decisión de cuál de estas dos variables mantener para el modelo, podemos usar la** **[desviación estándar](https://cloud.google.com/bigquery/docs/reference/standard-sql/statistical_aggregate_functions?hl=es-419#stddev)**​ **.**

Analizando los coeficientes de desviación estándar, podemos identificar cuál de las dos variables con alta correlación tiene una desviación mayor, lo que la hace más representativa y más interesante para el análisis, por lo que excluimos la variable con menor desviación.


Consultas utilizadas
-- Determinar nulos 
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

Para evaluar la correlación entre un dato y todo, se uso:
```sql
 SELECT 
 corr(edad,flag) edad_flag,
 corr(salario, flag) salario_flag,
 corr(delay_30_59,delay_60_89) delay3059_6089,
 corr(delay_60_89,more_90_days_overdue) delay6089_more90,
 corr(delay_30_59,more_90_days_overdue) delay3059_more90,
 corr(deudas_sobre_patrimonio, more_90_days_overdue)ratio_more90,
 corr(salario, more_90_days_overdue) salario_more90,
 corr(using_lines_not_secured_personal_assets, deudas_sobre_patrimonio) linea_vs_ratio,
  corr(using_lines_not_secured_personal_assets,more_90_days_overdue) linea_vs_atraso90
 FROM `id-riesgo.datos_p3.unificado`
 ```
 Donde se busca conocer la correlación entre:
 *  La edad, y si es buen o mal pagador
 * El salario y si es buen o mal pagador
 * Si cuando se tarda 30-59 días, se tardará 60-89 y más de 90, igualmente si tarda entre 60-89 días, si sobrepasará los 90 días de retraso
 * el salario y los retrasos en los pagos
 * La linea de crédito vs su ratio (deudas/patrimonio)
 * La linea de crédito y si influye en la tardanza para pagar

 Conforme a los resultados:

 ![alt text](/Imagenes/image-4.png)

 Se determina que, solo hay relación entre variables en la incidencia de retraso en el pago, es decir, que si se tarda entre 30-59 días, influye positivamente en tardarse de 60-89 días y más de 90 días.

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

Se obtiene el unificado final.



Enlaces:

Referencias:

[Recurso de referencia.](https://www.youtube.com/watch?v=sYc3uID4ObQ)


