/************************************************************************************************
-- Table: Product

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- | unit_price   | int     |
-- +--------------+---------+
-- product_id is the primary key of this table.
-- Table: Sales

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | seller_id   | int     |
-- | product_id  | int     |
-- | buyer_id    | int     |
-- | sale_date   | date    |
-- | quantity    | int     |
-- | price       | int     |
-- +------ ------+---------+
-- This table has no primary key, it can have repeated rows.
-- product_id is a foreign key to Product table.
 
-- Write an SQL query that reports the buyers who have bought S8 but not iPhone. Note that S8 and iPhone are products present in the Product table.

-- The query result format is in the following example:

-- Product table:
-- +------------+--------------+------------+
-- | product_id | product_name | unit_price |
-- +------------+--------------+------------+
-- | 1          | S8           | 1000       |
-- | 2          | G4           | 800        |
-- | 3          | iPhone       | 1400       |
-- +------------+--------------+------------+

-- Sales table:
-- +-----------+------------+----------+------------+----------+-------+
-- | seller_id | product_id | buyer_id | sale_date  | quantity | price |
-- +-----------+------------+----------+------------+----------+-------+
-- | 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
-- | 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
-- | 2         | 1          | 3        | 2019-06-02 | 1        | 800   |
-- | 3         | 3          | 3        | 2019-05-13 | 2        | 2800  |
-- +-----------+------------+----------+------------+----------+-------+

-- Result table:
-- +-------------+
-- | buyer_id    |
-- +-------------+
-- | 1           |
-- +-------------+
-- The buyer with id 1 bought an S8 but didn't buy an iPhone. The buyer with id 3 bought both.
************************************************************************************************/

create table #Product (product_id int, product_name varchar(25), unit_price int )

insert into #Product (product_id, product_name, unit_price)
VALUES
(1, 'S8', 1000),
(2, 'G4', 800),
(3, 'iPhone', 1400)

create table #Sales (seller_id int, product_id int, buyer_id int, sales_date DATE, quantity int, price int )

insert into #Sales (seller_id, product_id, buyer_id, sales_date, quantity, price)
VALUES
(1, 1, 1, '2019-01-21', 2, 2000),
(1, 2, 2, '2019-02-17', 1, 800),
(2, 1, 3, '2019-06-02', 1, 800),
(3, 3, 3, '2019-05-13', 2, 2800)

--drop table #Product
--drop table #Sales

/******************************Solution # 1*******************************/
Select DISTINCT s.buyer_id
from #Sales s 
where s.buyer_id in (
					select a.buyer_id 
					from #Sales a join #Product b 
					on a.product_id = b.product_id 
					where b.product_name = 'S8') --include buyers who bought S8 only OR (S8 and iPhone)
and s.buyer_id NOT in (select a.buyer_id 
					   from #Sales a join #Product b 
					   on a.product_id = b.product_id 
					   where b.product_name = 'iPhone') --eliminate buyers that bought iPhone OR iPhone and S8 
/*************************************************************************/
