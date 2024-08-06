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