create database supplier;

use supplier;

create table supplier(
sid int primary key,
sname varchar(30),
city varchar(30));

create table parts(
pid int primary key,
pname varchar(30),
color varchar(10));

create table catlog(
sid int,
pid int,
cost int,
foreign key(sid) references supplier(sid),
foreign key(pid) references parts(pid));

insert into supplier values
(10001,'Acme Widget','banglore'),
(10002,'Johns','kolkata'),
(10003,'Vimal','mumbai'),
(10004,'Reliance','delhi');

insert into parts values
(20001,'Book','red'),
(20002,'Pen','red'),
(20003,'Pencil','green'),
(20004,'Mobile','green'),
(20005,'Charger','black');

insert into catlog values
(10001,20001,10),
(10001,20002,10),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10002,20001,10),
(10002,20002,10),
(10003,20003,30),
(10004,20003,40);

update catlog 
set cost = 40
where sid=10004;

select  distinct p.pname from parts p
left join catlog c on p.pid = c.pid
where c.sid is not null;

select s.sname from supplier s
join catlog c on s.sid=c.sid
group by s.sid
having count( distinct c.pid) = (select count(*) from parts);

select distinct s.sname from supplier s
join catlog c on s.sid = c.sid
join parts p on c.pid= p.pid
where p.color = 'red';

select p.pname from parts p
join catlog c on p.pid = c.pid
join supplier s on c.sid = s.sid
group by p.pid,p.pname
having count(distinct s.sid) =1 and 
max( s.sname )= 'Acme Widget' ;

select distinct c.sid from catlog c
where c.cost > (select avg(c1.cost ) from catlog c1
where c.pid = c1.pid);

select s.sname,c.pid from supplier s
join catlog c on s.sid=c.sid
where cost = (select max(cost) from catlog where pid = c.pid);
