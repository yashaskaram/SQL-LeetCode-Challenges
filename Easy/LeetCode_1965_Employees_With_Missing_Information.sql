/************************************************************************************************
Table: Employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the name of the employee whose ID is employee_id.
 
Table: Salaries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| salary      | int     |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the salary of the employee whose ID is employee_id.
 
Write an SQL query to report the IDs of all the employees with missing information. The information of an employee is missing if:

The employee's name is missing, or
The employee's salary is missing.
Return the result table ordered by employee_id in ascending order.

The query result format is in the following example.

Example 1:

Input: 
Employees table:
+-------------+----------+
| employee_id | name     |
+-------------+----------+
| 2           | Crew     |
| 4           | Haven    |
| 5           | Kristian |
+-------------+----------+
Salaries table:
+-------------+--------+
| employee_id | salary |
+-------------+--------+
| 5           | 76071  |
| 1           | 22517  |
| 4           | 63539  |
+-------------+--------+
Output: 
+-------------+
| employee_id |
+-------------+
| 1           |
| 2           |
+-------------+
Explanation: 
Employees 1, 2, 4, and 5 are working at this company.
The name of employee 1 is missing.
The salary of employee 2 is missing.
************************************************************************************************/
Create table #Employees (employee_id int, name varchar(30))

insert into #Employees (employee_id, name) 
values 
(2, 'Crew'),
(4, 'Haven'),
(5, 'Kristian')

Create table #Salaries (employee_id int, salary int)
insert into #Salaries (employee_id, salary) 
values 
(5, 76071),
(1, 22517),
(4, 63539)

--drop table #Employees
--drop table #Salaries
/******************************Solution # 1*******************************/
select ISNULL(s.employee_id, e.employee_id) employee_id
		--CASE
		--	WHEN s.employee_id IS NULL THEN e.employee_id
		--	WHEN e.employee_id IS NULL THEN s.employee_id
		--	ELSE null
		--END employee_id
from #Employees e FULL OUTER JOIN #Salaries s
on e.employee_id = s.employee_id
where s.employee_id IS NULL OR e.employee_id IS NULL
order by employee_id
/*************************************************************************/

/******************************Solution # 1*******************************/
select employee_id --, COUNT(*)
from (select employee_id from #Employees 
     union all
     select employee_id from #Salaries) temp
group by employee_id
having count(*) = 1
order by employee_id
/*************************************************************************/