 /*
  Si calculamos la correlación entre las variables
  more_90_days_overdue y number_times_delayed_payment_loan_30_59_days 
  de la tabla loans_detail encontramos un valor de 0,98
 */

 with temporal as (SELECT 

distinct(user_i.`user_id`) id_usuario,
user_i.`age` edad,
IF(user_i.`last_month_salary` is null, IF(deff.default_flag = 0,5400,4000),cast(user_i.`last_month_salary` as int64)) salario,
IF(user_i.`number_dependents` is null,0,user_i.`number_dependents`) AS dependents,

cast(round(ddet.`using_lines_not_secured_personal_assets`) as int64) as using_lines_not_secured_personal_assets,	
cast(ddet.`debt_ratio` as int64)  as debt_ratio,

ddet.`number_times_delayed_payment_loan_30_59_days` number_times_delayed_payment_loan_30_59_days,	
ddet.`number_times_delayed_payment_loan_60_89_days` as umber_times_delayed_payment_loan_60_89_days,
ddet.`more_90_days_overdue` more_90_days_overdue,	

deff.`default_flag` as flag,
IF(deff.default_flag = 0, "Paga bien", "Paga mal") AS grupo_pago


FROM `id-riesgo.datos_p3.user_info` user_i

LEFT JOIN

 `id-riesgo.datos_p3.details` ddet

 on

 user_i.user_id = ddet.user_id

 INNER JOIN 

 `id-riesgo.datos_p3.default` deff

 ON

 user_i.user_id = deff.user_id)

 SELECT 
 corr(edad,flag) edad_flag,
 corr(salario, flag) salario_flag,
 corr(number_times_delayed_payment_loan_30_59_days,umber_times_delayed_payment_loan_60_89_days) delay3059_6089,
 corr(umber_times_delayed_payment_loan_60_89_days,more_90_days_overdue) delay6089_more90,
 corr(number_times_delayed_payment_loan_30_59_days,more_90_days_overdue) delay3059_more90,
 corr(debt_ratio, more_90_days_overdue)ratio_more90,
 corr(salario, more_90_days_overdue) salario_more90,
 corr(using_lines_not_secured_personal_assets, debt_ratio) linea_vs_ratio,
  corr(using_lines_not_secured_personal_assets,more_90_days_overdue) linea_vs_atraso90
 FROM temporal
 -- resultado 0.9829168066