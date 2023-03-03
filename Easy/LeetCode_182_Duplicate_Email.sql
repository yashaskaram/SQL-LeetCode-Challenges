/**************************************************************************************************
Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.

Write an SQL query to report all the duplicate emails.
Return the result table in any order.
The query result format is in the following example.

Example 1:

Input: 
Person table:
+----+---------+
| id | email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
Output: 
+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Explanation: a@b.com is repeated two times.

**************************************************************************************************/

create table #Person (id int, email varchar(50))

INSERT into #Person (id, email)
VALUES
(1, 'a@b.com'),
(2, 'c@d.com'),
(3, 'a@b.com'),
(4, 'e@f.com'),
(5, 'c@d.com'),
(6, 'e@f.com'),
(7, 'a@b.com')

--drop table #Person

--********************Solution # 1***********************************

select distinct p1.email
from #Person p1
where p1.email = (select distinct p2.email 
					from #Person p2 
				  where p2.id > p1.id 
				  and p1.email = p2.email)

--*******************************************************************

--********************Solution # 2***********************************

select distinct p1.email
from #Person p1 join #Person p2 
on p2.id > p1.id
where p1.email = p2.email

--*******************************************************************

--********************Solution # 3***********************************

select email
from #Person p
group by p.email
having COUNT(p.email) > 1

--*******************************************************************
