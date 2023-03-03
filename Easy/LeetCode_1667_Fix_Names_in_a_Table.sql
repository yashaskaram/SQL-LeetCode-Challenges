/************************************************************************************************
Table: Users
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 
Write an SQL query to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.

The query result format is in the following example.

Example 1:

Input: 
Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+
Output: 
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+
************************************************************************************************/

create table #Users ([user_id] int, name varchar(50) )

insert into #Users ([user_id], name)
VALUES
(1, 'aLice'),
(2, 'bOB'),
(3, 'chArlie')

--drop table #Users
/******************************Solution # 1*******************************/
select [user_id], STUFF(LOWER(u.name), 1, 1, UPPER(LEFT(u.name, 1))) name
from #Users u
order by [user_id] 
/*************************************************************************/
