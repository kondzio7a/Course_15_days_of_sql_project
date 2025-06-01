-- Course Project 
--Task 1.1
create table employees (
emp_id int PRIMARY KEY,
first_name varchar(20) NOT NULL,
last_name varchar(30) NOT NULL,
job_position varchar(20) NOT NULL,
salary numeric(8,2),
start_date DATE NOT NULL,
birth_date DATE NOT NULL,
store_id int,
departament_id int,
manager_id int
)
--Task 1.2 
create table departaments(
departament_id int Primary key,
departament text not null,
division text not null
)


--Task 2
alter table employees 
alter column departament_id set not null,
alter column start_date set default current_date,
add column end_date date,
alter table employees
add constraint birth_check check(birth_date<current_date)
alter table employees
rename job_position to position_title

--Task 3.1
insert into employees 
values 
(1,'Morrie','Conaboy','CTO',21268.94,'2005-04-30','1983-07-10',1,1,NULL,NULL),
(2,'Miller','McQuarter','Head of BI',14614.00,'2019-07-23','1978-11-09',1,1,1,NULL),
(3,'Christalle','McKenny','Head of Sales',12587.00,'1999-02-05','1973-01-09',2,3,1,NULL),
(4,'Sumner','Seares','SQL Analyst',9515.00,'2006-05-31','1976-08-03',2,1,6,NULL),
(5,'Romain','Hacard','BI Consultant',7107.00,'2012-09-24','1984-07-14',1,1,6,NULL),
(6,'Ely','Luscombe','Team Lead Analytics',12564.00,'2002-06-12','1974-08-01',1,1,2,NULL),
(7,'Clywd','Filyashin','Senior SQL Analyst',10510.00,'2010-04-05','1989-07-23',2,1,2,NULL),
(8,'Christopher','Blague','SQL Analyst',9428.00,'2007-09-30','1990-12-07',2,2,6,NULL),
(9,'Roddie','Izen','Software Engineer',4937.00,'2019-03-22','2008-08-30',1,4,6,NULL),
(10,'Ammamaria','Izhak','Customer Support',2355.00,'2005-03-17','1974-07-27',2,5,3,'2013-04-14'),
(11,'Carlyn','Stripp','Customer Support',3060.00,'2013-09-06','1981-09-05',1,5,3,NULL),
(12,'Reuben','McRorie','Software Engineer',7119.00,'1995-12-31','1958-08-15',1,5,6,NULL),
(13,'Gates','Raison','Marketing Specialist',3910.00,'2013-07-18','1986-06-24',1,3,3,NULL),
(14,'Jordanna','Raitt','Marketing Specialist',5844.00,'2011-10-23','1993-03-16',2,3,3,NULL),
(15,'Guendolen','Motton','BI Consultant',8330.00,'2011-01-10','1980-10-22',2,3,6,NULL),
(16,'Doria','Turbat','Senior SQL Analyst',9278.00,'2010-08-15','1983-01-11',1,1,6,NULL),
(17,'Cort','Bewlie','Project Manager',5463.00,'2013-05-26','1986-10-05',1,5,3,NULL),
(18,'Margarita','Eaden','SQL Analyst',5977.00,'2014-09-24','1978-10-08',2,1,6,'2020-03-16'),
(19,'Hetty','Kingaby','SQL Analyst',7541.00,'2009-08-17','1999-04-25',1,2,6,NULL),
(20,'Lief','Robardley','SQL Analyst',8981.00,'2002-10-23','1971-01-25',2,3,6,'2016-07-01'),
(21,'Zaneta','Carlozzi','Working Student',1525.00,'2006-08-29','1995-04-16',1,3,6,'2012-02-19'),
(22,'Giana','Matz','Working Student',1036.00,'2016-03-18','1987-09-25',1,3,6,NULL),
(23,'Hamil','Evershed','Web Developper',3088.00,'2022-02-03','2012-03-30',1,4,2,NULL),
(24,'Lowe','Diamant','Web Developper',6418.00,'2018-12-31','2002-09-07',1,4,2,NULL),
(25,'Jack','Franklin','SQL Analyst',6771.00,'2013-05-18','2005-10-04',1,2,2,NULL),
(26,'Jessica','Brown','SQL Analyst',8566.00,'2003-10-23','1965-01-29',1,1,2,NULL);

--Task 3.2 
insert into departaments values
(1,'Analytics','IT'),
(2,'Finanse','Administration'),
(3,'Sales','Sales'),
(4,'Website','IT'),
(5,'Back Office','Administration');

--Task 4.1 
select * from employees
where position_title like '%SQL%'

update employees set  
position_title = 'Senior SQL Analyst'
where first_name = 'Jack' and last_name = 'Franklin'
update employees set  
salary = 7200
where first_name = 'Jack' and last_name = 'Franklin'
--Task 4.2 
update employees 
set position_title = 'Customer Specialist'
where position_title = 'Customer Support'
--Task 4.3
update employees 
set salary = salary * 1.06
where position_title like '%SQL%'
--Task 4.4 
select round(avg(salary),2) as average_salary_SQL_Analyst from employees 
where position_title like '%SQL%' 
and position_title not like 'Senior SQL Analyst'
--Task 5.1 
select t1.*,
case when t1.end_date is null then 'True'
else 'False' end as is_active ,t2.first_name ||' '|| t2.last_name as manager
from employees as t1 left join employees as t2 on t1.manager_id = t2.manager_id

--Task 5.2 
create view v_employees_info
as 
select t1.*,
case when t1.end_date is null then 'True'
else 'False' end as is_active ,t2.first_name ||' '|| t2.last_name as manager
from employees as t1 left join employees as t2 on t1.manager_id = t2.manager_id
;

--Task 6 
select round(avg(salary) over(PARTITION by position_title),2) 
from employees where position_title='Software Engineer' limit 1 

--Task 7 
select division, round(avg(salary),2) from employees e left join departaments d on e.departament_id = d.departament_id
group by division 

--Task 8.1
select emp_id,first_name,last_name,position_title,salary, round(avg(salary) over(PARTITION by position_title),2)
from employees
order by emp_id

--Task 8.2
select count(*) from (select emp_id,first_name,last_name,position_title,salary,round(avg(salary) over(PARTITION by position_title),2) as avg_salary_position
from employees)
where salary < avg_salary_position

--Task 9
select * from(select emp_id, salary, start_date, sum(salary) over(order by start_date) from employees
) where start_date = '2018-12-31'

--Task 10
select sum from (select *, sum(salary) over(order by start_date) 
from (select emp_id, salary, start_date from employees
union
select emp_id, -salary, end_date  from employees where end_date is not null
)) where start_date = '2018-12-31'
--Task 11.1
select * from (select first_name, last_name, position_title, salary,
rank() over(partition by  position_title order by salary desc) from employees
) where rank = 1 and position_title = 'SQL Analyst'
--Task 11.2
select * from (select first_name, last_name, position_title, salary,
rank() over(partition by  position_title order by salary desc),
round(avg(salary) over (partition by position_title),2) as avg_salary_per_position from employees
) where rank = 1 and position_title = 'SQL Analyst'
--Task 11.3 
select * from (select first_name, last_name, position_title, salary,
rank() over(partition by  position_title order by salary desc),
round(avg(salary) over (partition by position_title),2) as avg_salary_per_position from employees
) where avg_salary_per_position <> salary
--Task 12 
select division, departament, position_title, sum(salary), count(emp_id), round(avg(salary),2) from employees e 
left join departaments d on e.departament_id = d.departament_id
group by grouping sets ((division, departament),(division, departament, position_title))
order by division, departament, position_title
--Task 13
select emp_id,position_title, departament, salary,rank() over(partition by departament order by salary desc) from employees e 
left join departaments d on e.departament_id = d.departament_id
--Task 14
select * from (select emp_id,position_title, departament, salary,rank() over(partition by departament order by salary desc) from employees e 
left join departaments d on e.departament_id = d.departament_id) where rank = 1 
