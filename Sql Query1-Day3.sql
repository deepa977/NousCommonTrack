use TrainingDB

--retreive all the data from the tables
--* is a wild card character - all columns from the table
select * from emp

--for display purpose how to change the column names
-- select only few columns from the table
select empno "Employee No",Ename "Employee Name",sal "Salary" from emp

select empno,ename,sal,job from emp

--how to get data based on condition
--where is used to specify the condition
select *  from emp where job='clerk'

--multiple conditions
--both condition -and , any one condition - or and none of the condition - not
select * from emp where job='clerk' and job='salesman'
--it is expecting a single row to have job as clerk as well as salesman
select * from emp where job='clerk' or job='salesman' or job='Manager'
--instead of specifying multiple condition with or operator we can use in operator
select * from emp where job in('clerk','salesman','manager')
--in operator can be negated using not in
select * from emp where (job <> 'clerk' and job <> 'salesman' and job <> 'Manager')
--instead of specifying multiple condition with or operator we can use in operator
select * from emp where job not in('clerk','salesman','manager')
-- multiple condition based on 2 different columns also
select * from emp where job='clerk' and deptno=20  
select * from emp where job='clerk' and deptno=20  and sal > 1000

--select data based on range of values
--relational operator or between clause is used
select * from emp where sal >= 1500 and sal <= 3000

select * from emp where sal between 1500 and 3000
-- negation of between is not between
select * from emp where sal not between 1500 and 3000

--get null values
--null cannot be used with = operator. we can use null as is null or is not null

select * from emp where comm is null
--negation of is null will be is not null
select * from emp where comm is not null
select * from emp where mgr is null

--pattern matching operator
--like and not like
--a% -> any name starting with a
--%s -> any name ending with s
--a%s->starting with a, can have any characters in between and end with s
-- _a% ->it can start with any character, 2nd character should be a 
--and followed by any characters
-- _ _ _ _ one underscore is for 1 space. 4 underscore means any 4 letter word
select ename from emp where ename like 'a%'
select ename from emp where ename like '%s'
select ename from emp where ename like 'a%s'
select ename from emp where ename like '_a%'
select ename from emp where ename like '____'

--order by (sort data in ascending or descending order)
select * from emp order by ename 

select * from emp order by ename desc
--when 2 cols are used for sorting data
insert into emp(empno, ename,sal) values(1200,'KING',4500)

select * from emp order by ename, empno desc


--aggr functions
--count, min, max, sum, avg
--count, min and max can take column of any datatype as parameter
--sum and avg will work on numerical datatype

--count(*) - it will count null and not null
--count(colname) -it will count only not null values
select count(*) "ALL DATA",count(mgr) "Mgr Count", count(comm) "Comm Count" from emp

select min(ename) "min ename", max(ename) "max ename", min(hiredate) "min date",
max(hiredate) "max dATE" , min(sal) "min sal", max(sal) "max sal" from emp

select sum(sal) "TotSal", avg(sal) "avgsal" from emp

select sum(ename), avg(ename) from emp
--this will not work. error will be Operand data type varchar is invalid for sum operator.
--remove duplicate data
select  distinct(deptno) from emp

select  distinct(JOB) from emp

--group by , having
--count of emp working in dept no 10
--count of emp working as 'clerk'
select count(*) 'EmpCount', deptno from emp where deptno=10

-- group by is used for giving summary of data as output
--if we are selecting aggr function and colname 
--then we need to define the column in the group by clause
select count(*) "emp count", empno from emp group by EMPNO
--groupby  is used for collection of data 
--many emp in dept, emp in job

select count(*) "emp count", deptno from emp group by deptno

select count(*) "count emp", sum(sal) "totsal" , job from emp group by job

--where -- having
--before group by if we want to give a condition use where
--after group by if we want to give a condition use having

select count(*) "totemp" , job from emp
where job != 'president'
group by job
having count(*) >= 3
order by job desc


select count(*) "deptcount", deptno
from emp
group by deptno

--dont consider null deptno and show only dept having employees >= 5
select count(*) "deptcount", deptno
from emp
where deptno is not null
group by deptno
having  count(*) >=5

--joins 
--if we want data from multiple tables we use joins
--if the join condition is not specified correctly query 
--will give the o/p as cartesian product
select * from emp,dept

--joins are of 2 types
-- equi join or inner join
--matching data from table A and TableB will be retreived
select * from dept
insert into dept values(50,'Covid19','China')

insert into emp(empno,ename) values(1,'RAM'),(2,'SAM')
--we have some dept without emp and we have some emp without a dept
--equi join will not consider those type of data
--common condition for the join will be the PK column and FK Column

select e.ename, d.dname, d.deptno
from emp e
join dept d
on e.DEPTNO=d.deptno
--join project p
--on e.projid=p.projid
--join tablename alias
--on matching column give as condition
where e.deptno >=20
-- outer join
    
--left outer join
select e.ename, d.dname, d.deptno
from emp e
left join dept d
on e.DEPTNO=d.deptno

--right outer join
select e.ename, d.dname, d.deptno
from emp e
right join dept d
on e.DEPTNO=d.deptno

	--full outer join
select e.ename, d.dname, d.deptno
from emp e
full join dept d
on e.DEPTNO=d.deptno

create table salesman(
salesman_id int primary key,
  name  nvarchar(30),
         city nvarchar(30),
		         commission money)

insert into salesman values
(5001         ,'James Hoog',  'New York',    0.15),
(5002         ,'Nail Knite',  'Paris'  ,     0.13),
(5005         ,'Pit Alex',    'London',      0.11),
(5006        ,'Mc Lyon' ,    'Paris',       0.14),
(5003         ,'Lauson Hen',  NULL,            0.12),
(5007         ,'Paul Adam',   'Rome',        0.13)


create table Customer(
customer_id int primary key,
 cust_name nvarchar(30) ,
      city  nvarchar(30),       grade int,
	         salesman_id int references salesman(salesman_id))


insert into Customer values
(3002         ,'Nick Rimando',  'New York',    100 ,        5001),
(3005         ,'Graham Zusi',   'California',  200 ,        5002),
(3001         ,'Brad Guzan',    'London', NULL,                  5005),
(3004         ,'Fabian Johns',  'Paris',       300 ,        5006),
(3007         ,'Brad Davis',    'New York',    200,         5001),
(3009         ,'Geoff Camero',  'Berlin',      100,         5003),
(3008         ,'Julian Green',  'London',      300,         5002),
(3003         ,'Jozy Altidor',  'Moscow',      200,         5007)


insert into Customer values(3010,'William Shakespeare','London',NULL,NULL)
create table Orders
(
ord_no int primary key,
     purch_amt  money,
	  ord_date   date,
	   customer_id int references customer(customer_id),
	     salesman_id int references salesman(salesman_id))
insert into Orders values
(70001     ,  150.5    ,   '2012-10-05',  3005 ,        5002),
(70009      , 270.65      ,'2012-09-10'  ,3001       ,  5005),
(70002      , 65.26,       '2012-10-05',  3002 ,        5001),
(70004      , 110.5       ,'2012-08-17',  3009 ,        5003),
(70007      , 948.5  ,     '2012-09-10',  3005  ,       5002),
(70005       ,2400.6      ,'2012-07-27'  ,3007        , 5001),
(70008       ,5760,        '2012-09-10',  3002,         5001),
(70010      , 1983.43     ,'2012-10-10'  ,3004     ,    5006),
(70003     ,  2480.4 ,     '2012-10-10',  3009  ,       5003),
(70012      , 250.45      ,'2012-06-27',  3008       ,  5002),
(70011     ,  75.29,       '2012-08-17' , 3003  ,       5007),
(70013     ,  3045.6      ,'2012-04-25' , 3002        , 5001)
--6. Write a SQL statement to find the details of a order i.e. order number, order date, amount of order,
--which customer gives the order and which salesman works for that customer and how much commission he gets for an order.        

     
select o.ord_no,o.ord_date,o.purch_amt,c.cust_name,s.name,s.commission
from Orders o
join Customer c
on o.customer_id=c.customer_id
join salesman s
on o.salesman_id=s.salesman_id


--7.Write a SQL statement to make a join on the tables salesman, customer and orders
-- in such a form that the same column of each table will appear once and only the relational rows will come.      
select   c.customer_id,c.cust_name,c.city "Cust City",c.grade,s.salesman_id, s.name,s.city "Salesman City",
s.commission,o.ord_no,
o.purch_amt,o.ord_date
from Customer c
join salesman s
on  c.salesman_id=s.salesman_id
join Orders o
on o.customer_id=c.customer_id
and o.salesman_id=s.salesman_id
order by c.customer_id

--8.Write a SQL statement to make a list in ascending order for the customer who works either through a salesman or by own.        
SELECT a.cust_name,a.city,a.grade, 
b.name AS "Salesman",b.city 
FROM customer a 
LEFT JOIN salesman b 
ON a.salesman_id=b.salesman_id 
order by a.customer_id;

--9. Write a SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman or by own.       
SELECT a.cust_name,a.city,a.grade, 
b.name AS "Salesman",b.city 
FROM customer a 
LEFT JOIN salesman b 
ON a.salesman_id=b.salesman_id 
where a.grade < 300
order by a.customer_id;

--10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to find that either any of the existing customers have placed no order or placed one or more orders.       
select c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt from
Orders o
right join Customer c
on c.customer_id = o.customer_id
group by c.customer_id,c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt
order by o.ord_no

--11.Write a SQL statement to make a report with customer name, city, order number, order date, order amount 
--salesman name and commission to find that either any of the existing customers have placed
-- no order or placed one or more orders by their salesman or by own. 
select c.cust_name,c.city,o.ord_no,o.ord_date,o.purch_amt,s.name,s.commission from
Orders o
right join Customer c
on c.customer_id = o.customer_id
full join salesman s
on s.salesman_id= c.salesman_id
And s.salesman_id=o.salesman_id
order by o.ord_no
  
  
  --t -sql

  --transact sql
  select * from emp
    --t sql helps in saving the DML, DQL complex queries in the DB which can be retreived 
	--when ever  required
	--t sql queries allows to create and assign variables, intialize values, print values
	-- loops (while), conditions can be checked using if else, set case,
	--queries can be saved as stored procedure, functions or triggers
	--stored proc-> write set of statements and it will not return a values -> void method
	-- functions-> return a values -> method with a return type
	--scalar function - return 1 values
	--table valued function -> return more than one values, return multiple rows of data,
	--multiple column value

	--variables in Sql Server begins with @
	--in sql server a block is given inside begin - end

	create proc sp_add
	as
	begin
	declare @a int, @b int
	declare @res int
	set @a=10
	set @b=20
	set @res=@a+@b
	print 'The Added value is='+convert(varchar(5),@res)
	end

-- exec the stored procedure
exec sp_add

declare @a int=10
print @a


--select proc with parameter
--@eno is an input parameter. it will contain the input value
create proc sp_selectemp(@eno int)
as
begin
select * from emp where EMPNO=@eno
end

exec sp_selectemp 7844

--create a stored procedure which take @dno int as parameter
--which ever deptno is passed it should display emps of that dept

create proc sp_updateemp(@eno int)
as
begin
declare @job varchar(30)
declare @sal money
select @job=job , @sal=sal from emp where empno=@eno
print 'This employee is working as '+@job + 'his existing sal is:'+convert(varchar(15),@sal)
if @job='CLERK' 
  update emp set sal=sal + (sal * .10) where empno=@eno
else if @job='SALESMAN'
   update emp set sal=sal + (sal * .15) where empno=@eno
else if @job='MANAGER'
   update emp set sal=sal + (sal * .20) where empno=@eno
else if @job='ANALYST'
   update emp set sal=sal + (sal * .25) where empno=@eno
else
  update emp set sal=sal + (sal * .50) where empno=@eno
select job,sal from emp where empno=@eno
end

--if(job=='CLERK') in programming languages


exec sp_updateemp 7369

--switch case in programming langauge , set case in sql server
create proc sp_updateemp_deptno(@eno int)
as
begin
select * from emp where empno=@eno
update emp set sal=
case deptno
when 10 then sal+(sal*.10)
when 20 then sal+(sal*.15)
when 30 then sal+(sal*.20)
when 40 then sal+(sal *.50)
else
1000
end
where empno=@eno
select * from emp where empno=@eno
end

exec sp_updateemp_deptno 7566

--delete stored procedure which takes input of dept no as parameter on empba

select * into empbak from emp

create proc sp_deleteemp(@dno int)
as
begin
delete from empbak where deptno=@dno
end

exec sp_deleteemp 20

--parameters are input parameter(input value) and out parameter(it will store an output value, which can be displayed 
--when executing the procedure)
create table test
(id int primary key identity,
name varchar(30),
mobno bigint)

create proc sp_inserttest(@name varchar(30),@mno bigint,@id int out)
as
begin
insert into test values(@name,@mno)
--get the id generated after successful insert
--scope_identity() will retreive the automatically generated ID value after successful insert
select @id=SCOPE_IDENTITY()
end

--sql server is auto commit for any DML queries
declare @id int
exec sp_inserttest 'SHYAM',3424322340,@id out
print @id


--return a single value, we call it as scalar function
create function fn_selectemp(@eno int) returns varchar(30)
as
begin  
declare @name varchar(30)
select @name=ename from emp where empno=@eno
return @name
end

print dbo.fn_selectemp(7844)


print dbo.fn_selectemp(7844)

print dbo.fn_selectemp(1)

print dbo.fn_selectemp(2)


--return multiple value, table valued functions
--no need for begin, end and in the return itself give the select statement

create function sp_selectallemp(@eno int) returns table
as
return select * from emp where EMPNO=@eno

select * from dbo.sp_selectallemp(7900)

--triggers
--triggers are executed automatically
--dml triggers -> we can create triggersfor insert, update or delete on table level
-- we create triggers to check for a condition before executing DML queries

create table personinfo
(id int primary key,
name varchar(30))

insert into personinfo values(-190,'Deepa')
--triggers works on 2 magical tables/2 temporary tables called inserted and deleted 

--for an insert query ->  temp table called inserted is used
-- for update query -> old value or existing value -> deleted table,
-- new value that we are trying to update will be stored in inserted table
--delete -> deleted table
create trigger insert_personinfo
on personinfo
for insert
as 
begin
declare @id int
select @id=id from inserted
if @id < 0
  begin
  rollback 
  print ' id cannot be negative'
  end
else
  commit
end

insert into personinfo values(190,'Deepa')

delete from empbak

--update a salary of an emp , it should not be less than the current salary
create trigger update_emp
on emp
for update
as
begin
declare @oldsal money, @newsal money,@eid int
select @oldsal=sal from deleted 
select @newsal=sal from inserted
if @newsal < @oldsal 
  begin 
  rollback
  print 'salary cannot be undersigned'
  end
else
 commit
end
update emp set sal=2800 where empno=7782

--delete 

alter trigger delete_emp
on emp
for delete 
as 
begin
declare @empno int,@name varchar(30),@sal money,@job varchar(30),@dno int
select @empno=empno,@name=ename,@sal=sal,@job=job,@dno=DEPTNO from deleted
insert into empbak(empno,ename,job,sal,deptno) values(@empno,@name,@job,@sal,@dno)
end

delete from emp where job='Analyst'

delete from emp where deptno=10

select * from emp where deptno=10

select * from empbak

delete from emp where empno=7900