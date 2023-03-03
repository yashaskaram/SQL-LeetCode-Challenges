/************************************************************************************************
Table: Activity

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
The activity_type column is an ENUM of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.
 

Write an SQL query to find the average number of sessions per user for a period of 30 days ending 2019-07-27 inclusively, rounded to 2 decimal places. 
The sessions we want to count for a user are those with at least one activity in that time period.
Return the result table in any order.

The query result format is in the following example.

Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 3       | 5          | 2019-07-21    | open_session  |
| 3       | 5          | 2019-07-21    | scroll_down   |
| 3       | 5          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+

Result table:
+---------------------------+ 
| average_sessions_per_user |
+---------------------------+ 
| 1.33                      |
+---------------------------+ 
User 1 and 2 each had 1 session in the past 30 days while user 3 had 2 sessions so the average is (1 + 1 + 2) / 3 = 1.33.
************************************************************************************************/
create table #ActivityType (ActivityTypeId int, activity_type varchar(25))

insert into #ActivityType (ActivityTypeId, activity_type)
VALUES
(1, 'open_session'), (2, 'end_session'), (3, 'scroll_down'), (4, 'send_message')

--drop table #ActivityType

create table #Activity ([user_id] int, session_id int, activity_date date, activity_type varchar(25))

insert into #Activity ([user_id], session_id, activity_date, activity_type)
VALUES
(1, 1, '2019-07-20', 'open_session'),
(1, 1, '2019-07-20', 'scroll_down' ),
(1, 1, '2019-07-20', 'end_session' ),
(2, 4, '2019-07-20', 'open_session'),
(2, 4, '2019-07-21', 'send_message'),
(2, 4, '2019-07-21', 'end_session' ),
(3, 2, '2019-07-21', 'open_session'),
(3, 2, '2019-07-21', 'send_message'),
(3, 2, '2019-07-21', 'end_session' ),
(3, 5, '2019-07-21', 'open_session'),
(3, 5, '2019-07-21', 'send_message'),
(3, 5, '2019-07-21', 'end_session' ),
(4, 3, '2019-06-25', 'open_session'),
(4, 3, '2019-06-25', 'end_session' )


--drop table #Activity

--******************************Solution**********************************
select CAST(AVG(a.num) as decimal(10,2)) as average_sessions_per_user
from (
select count(distinct session_id) as num
from #Activity
where activity_date between '2019-06-28' and '2019-07-27'
group by user_id) a
--************************************************************************

