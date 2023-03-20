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
 
Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

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
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+
************************************************************************************************/
CREATE TABLE #Employee (id int, salary int)

insert into #Employee (id, salary) 
values 
('1', '100'),
('2', '200'),
('3', '300')

--drop table #Employee
/******************************Solution # 1*******************************/
create function getNthHighestSalary(@N int) RETURNS INT AS
BEGIN 
	RETURN (
		select COALESCE(
		(select e1.salary 
		from #Employee e1
		where (3-1) = (select COUNT(distinct e2.salary) from #Employee e2 where e2.salary > e1.salary)
		), NULL) getNthHighestSalary 
	);
END

/*************************************************************************/

/******************************Solution # 2*******************************/
--create function getNthHighestSalary(@N int) 
--RETURNS INT AS
--	BEGIN 
--		RETURN 
--		(
--			;with cte_emp AS
--			(
--				select id, salary, DENSE_RANK() OVER(order by salary desc)  rnk
--				from #Employee
--			)
--			select COALESCE(
--			(select e.salary
--			from cte_emp e
--			where e.rnk = @N), NULL) as getNthHighestSalary 
--	END
/*************************************************************************/
