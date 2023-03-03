/**************************************************************************************************
185. Department Top Three Salaries

Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key column for this table.
departmentId is a foreign key of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 
Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of a department and its name.

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write an SQL query to find the employees who are high earners in each of the departments.

Return the result table in any order.

The query result format is in the following example.

Example 1:

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
Explanation: 
In the IT department:
- Max earns the highest unique salary
- Both Randy and Joe earn the second-highest unique salary
- Will earns the third-highest unique salary

In the Sales department:
- Henry earns the highest salary
- Sam earns the second-highest salary
- There is no third-highest salary as there are only two employees

**************************************************************************************************/
CREATE TABLE #Employee (id int, name varchar(25), salary int, departmentId int)
insert into #Employee (id, name, salary, departmentId)
VALUES 
(1, 'Joe',   85000, 1),
(2, 'Henry', 80000, 2),
(3, 'Sam',   60000, 2),
(4, 'Max',   90000, 1),
(5, 'Janet', 69000, 1),
(6, 'Randy', 85000, 1),
(7, 'Will',  70000, 1)

CREATE TABLE #Department (id int, name varchar(25))
insert into #Department (id, name)
VALUES
(1, 'IT'),
(2, 'Sales')

--drop table #Employee
--drop table #Department

--********************Solution # 1***********************************

select d.name Department, e.name Employee, e.salary Salary
from #Employee e JOIN #Department d
on e.departmentId = d.id
where e.salary in (select DISTINCT TOP (3) e1.salary 
					from #Employee e1 
					where e1.departmentId = e.departmentId 
					order by salary desc)

--*******************************************************************

--********************Solution # 2***********************************

select d.name Department, r.name Employee, r.salary Salary
from 
(select  e.departmentId, e.name, e.salary,
		DENSE_RANK() OVER(PARTITION BY e.departmentId ORDER BY e.salary Desc) salaryRank
from #Employee e) r JOIN #Department d
on r.departmentId = d.id
where r.salaryRank <= 3

--*******************************************************************



