-- Master sample with duplicate data
create table tab1(id int, a string, b string, dt int);
insert into tab1(1, 'a', 'b', 1),(1, 'a', 'b', 2),(1, 'a', 'b', 3);
insert into tab1(2, 'a', 'b', 1),(2, 'a', 'b', 2);
insert into tab1(3, 'a', 'b', 1);
insert into tab1(4, 'a', 'b', 1);
insert into tab1(5, 'a', 'b', 1);

-- Query 1 to resolve and remove duplicates (non formant)
create table tab1_master as 
select t1.*  from  (select * from tab1) t1 join (select id, max(dt) mxdt from tab1 group by id) t2 on t1.id = t2.id and t1.dt = t2.mxdt;

-- Alternative Query 2 to resolve and remove duplicates (performant)
create table tab1_master as
select t1.id, t1.a, t1.b, t1.dt from (select *, rank() over (partition by id order by dt desc) as rnk from tab1) t1 where t1.rnk=1;

-- create replica for next append
drop table tab1;
create table tab1 as select * from tab1_master;

-- Insert daily partition
insert into tab1 values (select * from tab1daily where partid='1')

-- Reference article
-- https://hortonworks.com/blog/four-step-strategy-incremental-updates-hive/
