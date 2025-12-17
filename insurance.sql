create database insurance;
use insurance;

create table person(
driver_id varchar(10),
driver_name varchar(20),
address varchar(30),
primary key(driver_id));

create table car(
reg_num varchar(10),
model varchar(20),
year int,
primary key(reg_num)
);

create table owns(
driver_id varchar(10),
reg_num varchar(10),
primary key(driver_id,reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num)
);

create table accident(
report_num int,
accident_date date,
loaction varchar(30),
primary key(report_num)
);

create table participated(
driver_id varchar(10),
reg_num varchar(10),
report_num int,
damage_amount int(6),
primary key(driver_id,reg_num,report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num)
);

desc person;
insert into person value('A01','Richard','Srinivas nagar'),('A02','Pradeep','Rajaji nagar'),('A03','Smith','Ashok nagar'),('A04','Venu','N R Colony'),('A05','Jhon','Hanumanth nagar');
select * from person;

desc car;
insert into car values('KA052250','Indica',1990),('KA031181','Lancer',1957),('KA095477','Toyota',1998),('KA053408','Honda',2008),('KA041702','Audi',2005);
select * from car;

desc owns;
insert into owns values('A01','KA052250'),('A02','KA053408'),('A03','KA031181'),('A04','KA095477'),('A05','KA041702');
select * from owns;

insert into accident values(11,'2003-01-01','Mysore Road'),(12,'2004-02-02','South end Cirle'),(13,'2003-01-21','Bull temple Road'),(14,'2008-02-14','Mysore Road'),(15,'2005-03-04','Kanakpura Road');
select * from accident;

desc participated;
insert into participated values('A01','KA052250',11,10000),('A02','KA053408',12,50000),('A03','KA095477',13,25000),('A04','KA031181',14,3000),('A05','KA041702',15,5000);
select * from participated;

update participated 
set damage_amount = 25000
where reg_num='KA053408' and report_num = 12;

insert into accident values(16,'2008-03-15','majestic');
select * from accident;

select accident_date, location from accident;

select driver_id from participated 
where damage_amount >= 25000;




select * from car order by year asc;

select count(*) 
from participated p
join car c on p.reg_num= c.reg_num
where c.model = 'lancer';

select count(p.reg_num) as count from participated p ,car c
where p.reg_num = c.reg_num and c.model = 'lancer';

select count(distinct p.driver_id) as accident_in_2003
from person p 
join participated pa on p.driver_id = pa.driver_id
join accident a on pa.report_num = a.report_num
where year(a.accident_date) = 2003;

select * from participated order by damage_amount desc;

select avg(damage_amount) as avg_amount from participated;


delete from participated
where damage_amount <(select avg_amt from (select avg(damage_amount) as avg_amt from participated) as temp);

insert into participated values('A01','KA052250',11,10000),('A04','KA031181',14,3000),('A05','KA041702',15,5000);
select * from participated;

select max(damage_amount) from participated;

select p.driver_name, pa.damage_amount
from person p
join participated pa  on pa.driver_id = p.driver_id
where damage_amount > ( select avg(damage_amount) from participated);