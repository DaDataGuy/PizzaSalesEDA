USE [Pizza Sales]
/* Creating temp table to hold all unique dates */
IF OBJECT_ID('tempdb..#datetable') IS NOT NULL 
DROP TABLE #datetable

SELECT DISTINCT
 [date] 
,[Order_id]
INTO #datetable
FROM [Pizza Sales].[dbo].[orders]
-------------------------------------------------
/* Creating temp table to hold all pizza counts */
-------------------------------------------------
/* Can't use window functions in HAVING clause */
-------------------------------------------------

IF OBJECT_ID('tempdb..#pizzacount') IS NOT NULL 
DROP TABLE #pizzacount

SELECT DISTINCT
  d.[date]
, od.order_id
, COUNT(od.pizza_id) OVER (PARTITION BY  od.Order_id, EOMONTH(d.[date])) as PizzaCountbyOrderID
INTO #pizzacount

FROM [Pizza Sales].[dbo].[order_details] as od
LEFT JOIN #datetable as d on (od.order_id = d.order_id)

WHERE d.[date] BETWEEN '2015-06-01' and '2015-06-30'

-------------------------------------------------
/* Selecting a specific count of pizzas*/
-------------------------------------------------
SELECT *
FROM #pizzacount
WHERE PizzaCountbyOrderID > 5

ORDER BY PizzaCountbyOrderID DESC, [date] desc