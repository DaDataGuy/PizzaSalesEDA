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
/* Selecting a specific count of pizzas*/
-------------------------------------------------
Select DISTINCT
  EOMONTH(d.[date]) as [Date]
, COUNT(od.pizza_id) OVER (PARTITION BY  EOMONTH(d.[date])) as PizzaCountbyMonth

FROM [Pizza Sales].[dbo].[order_details] as od
LEFT JOIN #datetable as d on (od.order_id = d.order_id)

ORDER BY EOMONTH(d.[date]) 