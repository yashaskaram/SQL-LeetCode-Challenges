/***************************************************************************************************
LEET Code # 180
Write a SQL query to find all numbers that appear at least three times consecutively.

-- +----+-----+
-- | Id | Num |
-- +----+-----+
-- | 1  |  1  |
-- | 2  |  1  |
-- | 3  |  1  |
-- | 4  |  2  |
-- | 5  |  1  |
-- | 6  |  2  |
-- | 7  |  2  |
-- +----+-----+
-- For example, given the above Logs table, 1 is the only number 
that appears consecutively for at least three times.

-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+
***************************************************************************************************/

CREATE TABLE #Logs
(
	Id int,
	Num int
)
--drop table #Logs
INSERT INTO #Logs (Id, Num)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 1),
(6, 2),
(7, 2)
--********************Solution # 1***********************************

SELECT DISTINCT l.Num AS ConsecutiveNums
from #Logs l
JOIN #Logs l_next on l.Id + 1 = l_next.Id
JOIN #Logs l_next2 on l_next.Id + 1 = l_next2.Id
where l.Num = l_next.Num and l_next.Num = l_next2.Num --(l.Num = l_next.Num = l_next2.Num)

--*******************************************************************

--********************Solution # 2***********************************

SELECT DISTINCT l.Num AS ConsecutiveNums
from #Logs l
where l.Num = (select l2.Num from #Logs l2 where l2.Id > l.Id ORDER BY l2.Id OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY)
and l.Num = (select l3.Num from #Logs l3 where l3.Id > l.Id ORDER BY l3.Id OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY)

--*******************************************************************

--********************Solution # 3***********************************

SELECT Num AS ConsecutiveNums
from (SELECT Num,
			LEAD(Num, 1) OVER(ORDER BY Id) as [nextNum],
			LEAD(Num, 2) OVER(ORDER BY Id) as [afterNextNum]
		From #Logs) l
where l.Num = l.nextNum and l.nextNum = l.afterNextNum 

--*******************************************************************

--********************Solution # 4***********************************

SELECT Num AS ConsecutiveNums
from (SELECT Num,
			LAG(Num, 1) OVER(ORDER BY Id desc) as [prevNum],
			LAG(Num, 2) OVER(ORDER BY Id desc) as [afterPrevNum]
		From #Logs) l
where l.Num = l.prevNum and l.prevNum = l.afterPrevNum 

--*******************************************************************

--********************Solution # 5***********************************

SELECT DISTINCT a.num AS ConsecutiveNums
FROM(
      SELECT num,
      LAG(num) OVER(ORDER BY Id) as prev,
      LEAD(num) OVER(ORDER BY Id) as [next]
      FROM #Logs) AS a
WHERE a.num = a.prev 
AND a.num = a.[next]

--*******************************************************************