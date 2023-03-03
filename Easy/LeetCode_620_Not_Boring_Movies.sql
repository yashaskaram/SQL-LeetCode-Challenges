/************************************************************************************************
620. Not Boring Movies

Table: Cinema
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]
 
Write an SQL query to report the movies with an odd-numbered ID and a description that is not "boring".

Return the result table ordered by rating in descending order.

The query result format is in the following example.
************************************************************************************************/

create table #Cinema (id int, movie varchar(25), description varchar(50), rating decimal(3,1))

insert into #Cinema (id, movie, description, rating)
VALUES
(1, 'War',		'great 3D', 8.9),
(2, 'Science',  'fiction',  8.5),
(3, 'irish',	'boring',  6.2),
(4, 'Ice song', 'Fantacy', 8.6),
(5, 'House card', 'Interesting', 9.1)

--drop table #Cinema

--******************************Solution*******************************

select c.id, c.movie, c.description, CAST(rating as numeric(3, 1))
from #Cinema c
where c.id % 2 != 0 
and c.description <> 'boring' 
order by c.rating desc

--*********************************************************************