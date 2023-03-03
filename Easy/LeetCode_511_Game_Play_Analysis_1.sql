/**************************************************************************************************
511. Game Play Analysis I

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
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
Write an SQL query to report the first login date for each player.

Return the result table in any order.

The query result format is in the following example.

Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
**************************************************************************************************/
create table #Activity (player_id int, device_id int, event_date date, games_played int)

insert into #Activity (player_id, device_id, event_date, games_played)
VALUES
(1, 2, '2016-03-01', 5), (1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1), (3, 1, '2016-03-02', 0),
(3, 1, '2018-07-03', 5)

--drop table #Activity

--*****************************Solution #1*****************************

select player_id, MIN(event_date) eventDate
from #Activity a
group by a.player_id

--*********************************************************************

--*****************************Solution #2*****************************

select r.player_id, r.first_login 
FROM (
select a.player_id, a.event_date first_login, 
		DENSE_RANK() OVER(PARTITION BY a.player_id ORDER BY a.event_date) rnk
from #Activity a) r
where r.rnk = 1

--*********************************************************************