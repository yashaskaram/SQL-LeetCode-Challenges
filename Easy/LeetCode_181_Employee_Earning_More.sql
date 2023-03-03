/***************************************************************************************************
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
 
Write an SQL query to find the employees who earn more than their managers.
Return the result table in any order.
The query result format is in the following example.

Example 1:

Input: 
Employee table:
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |
+----+-------+--------+-----------+
Output: 
+----------+
| Employee |
+----------+
| Joe      |
+----------+
Explanation: Joe is the only employee who earns more than his manager.
***************************************************************************************************/

CREATE Table #Employee (id int, name varchar(25), salary int, managerId int)

INSERT INTO #Employee (id, name, salary, managerId)
VALUES
(1, 'Joe',   70000, 3),
(2, 'Henry', 80000, 4),
(3, 'Sam',   60000, NULL),
(4, 'Max',   90000, NULL)

--drop table #Employee

--********************Solution # 1***********************************

SELECT e1.name
FROM #Employee e1
WHERE e1.salary > (SELECT e2.salary 
					FROM #Employee e2 
					WHERE e2.id = e1.managerId)

--*******************************************************************

--********************Solution # 2***********************************

SELECT E1.name
FROM #Employee E1 JOIN #Employee E2
ON E1.managerId = E2.id
WHERE E1.salary > E2.salary

--*******************************************************************