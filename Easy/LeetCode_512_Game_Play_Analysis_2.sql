/**************************************************************************************************
511. Game Play Analysis II

Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) 
before logging out on someday using some device.
 
-- Write a SQL query that reports the device that is first logged in for each player.

-- The query result format is in the following example:

-- Activity table:
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-05-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-02 | 0            |
-- | 3         | 4         | 2018-07-03 | 5            |
-- +-----------+-----------+------------+--------------+

-- Result table:
-- +-----------+-----------+
-- | player_id | device_id |
-- +-----------+-----------+
-- | 1         | 2         |
-- | 2         | 3         |
-- | 3         | 1         |
-- +-----------+-----------+

**************************************************************************************************/
create table #Activity (player_id int, device_id int, event_date date, games_played int)

insert into #Activity (player_id, device_id, event_date, games_played)
VALUES
(1, 2, '2016-03-01', 5), (1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1), (3, 1, '2016-03-02', 0),
(3, 1, '2018-07-03', 5)

--drop table #Activity

--*****************************Solution #1*****************************

select player_id, device_id
from #Activity a
where a.event_date IN (select MIN(a1.event_date) 
						from #Activity a1 
					   group by a1.player_id)


--*********************************************************************

--*****************************Solution #2*****************************

select r.player_id, r.device_id 
FROM (
select a.player_id, a.device_id, 
		DENSE_RANK() OVER(PARTITION BY a.player_id ORDER BY a.event_date) rnk
from #Activity a) r
where r.rnk = 1

--*********************************************************************