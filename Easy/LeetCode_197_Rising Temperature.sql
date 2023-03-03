/**************************************************************************************************
197. Rising Temperature

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature on a certain day.
 
Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The query result format is in the following example.

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).

**************************************************************************************************/

create table #Weather (id int, recordDate date, temprature int)

insert into #Weather (id, recordDate, temprature)
VALUES
(1, '2015-01-01', 10), (2, '2015-01-02', 25),
(3, '2015-01-03', 20),(4, '2015-01-04', 30)

--drop table #Weather
--select * from #Weather

--********************Solution # 1***********************************

select w1.id
from #Weather w1 LEFT JOIN #Weather w2
on w1.recordDate = DATEADD(DAY, 1, w2.recordDate)
where w1.temprature > w2.temprature

--*******************************************************************

--********************Solution # 2***********************************

with wCTE as
(
	select w.id, w.recordDate, w.temprature, 
		LAG(w.temprature) OVER(ORDER BY w.recordDate) prevDayTemp,
		LAG(w.recordDate) OVER(ORDER BY w.recordDate) prevDay
	from #Weather w
)
select w.id
from wCTE w
where w.temprature > w.prevDayTemp
and DATEDIFF(DAY, w.prevDay, w.recordDate) = 1

--*******************************************************************