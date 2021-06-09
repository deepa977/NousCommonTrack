create database TrainingDB

use TrainingDB

create table EMP
(empid int,
ename nvarchar(30))

--rename a table after it is created
sp_rename 'dbo.emp','Employee'

--rename a column after it is created
sp_rename 'dbo.Employee.empid','empno'

-- add a new columns to existing table
--add a single column
alter table Employee
add dept varchar(30)

-- add multiple columns
alter table Employee
add desg varchar(30),
salary money,
doj datetime


--drop column from existing table
alter table Employee
drop column desg,dept

--alter a column dAtatype
alter table Employee 
alter column ename nvarchar(50)

ALTER table Employee
alter column doj date
-- drop the table itself

drop table Employee

--constraints in sql server
--null
--not null 
 --primary key
  --identity
 --default
 --unique
 --check
--foreign key






