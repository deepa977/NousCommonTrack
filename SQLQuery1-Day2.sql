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

