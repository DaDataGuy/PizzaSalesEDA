USE [Pizza Sales]
/* Creating temp table to hold all unique dates */
IF OBJECT_ID('tempdb..#datetable') IS NOT NULL 
DROP TABLE #datetable

SELECT DISTINCT
 [date] 
INTO #datetable
FROM [Pizza Sales].[dbo].[orders]
-------------------------------------------------
/* Selecting a specific count of pizzas*/
-------------------------------------------------
SELECT
 [date] 
FROM #datetable
ORDER BY [Date]
