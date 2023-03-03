/**************************************************************************************************
196. Delete Duplicate Emails

Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. Note that you are supposed to write a DELETE statement and not a SELECT one.

After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.

The query result format is in the following example.

Example 1:

Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Output: 
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Explanation: john@example.com is repeated two times. We keep the row with the smallest Id = 1.
**************************************************************************************************/
create table #Person (id int, email varchar(50))

insert into #Person (id, email)
values 
(1, 'john@example.com'), (2, 'bob@example.com'), (3, 'john@example.com'), (4, 'bob@example.com'), (5, 'vik@example.com')

--drop table #Person

--********************Solution # 1***********************************

delete p2
from #Person p1 JOIN #Person p2
on p1.email = p2.email and p2.id > p1.id;

--*******************************************************************

--********************Solution # 2***********************************
with emailCTE as
(
	select p.id, p.email, ROW_NUMBER() OVER(PARTITION BY p.email order by p.id) rownum
	from #Person p

)
delete p
--select *
from #Person p
where p.id in (select t.id from emailCTE t where t.rownum > 1)

--*******************************************************************

