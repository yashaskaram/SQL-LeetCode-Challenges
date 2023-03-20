/************************************************************************************************
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 
Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, 
the query should report null.

The query result format is in the following example.

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
************************************************************************************************/
CREATE TABLE #Employee (id int, salary int)

insert into #Employee (id, salary) 
values ('1', '100'),
('2', '200'),
('3', '300')

--drop table #Employee
/******************************Solution # 1*******************************/
select COALESCE(
(select TOP (1) e.salary
from #Employee e
where salary < (select MAX(salary) highestSalary from #Employee)
order by salary desc), NULL) SecondHighestSalary
/*************************************************************************/

/******************************Solution # 2*******************************/
with cte_emp AS
(
	select id, salary, DENSE_RANK() OVER(order by salary desc)  rnk
	from #Employee
)
select COALESCE(
(select e.salary
from cte_emp e
where e.rnk = 2), NULL) SecondHighestSalary
/*************************************************************************/
