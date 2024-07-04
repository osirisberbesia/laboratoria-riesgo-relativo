# preguntas

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
