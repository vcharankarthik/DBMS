create database bank;

use bank;

create  table branch(
branch_name varchar(30) primary key,
branch_city varchar(30),
assets int);

create table bankacc(
acc_no int primary key,
branch_name varchar(30),
balance int,
foreign key(branch_name) references branch(branch_name));


create table bankcust(
customer_name varchar(20) primary key,
customer_street varchar(20),
city varchar(10));

create table depositer(
customer_name varchar(20) ,
acc_no int ,
primary key(customer_name,acc_no),
foreign key(customer_name) references bankcust(customer_name),
foreign key(acc_no) references bankacc(acc_no));

create table loan(
loan_no int,
branch_name varchar(30),
amount int,
primary key(loan_no),
foreign key(branch_name) references branch(branch_name));


insert into branch values('sbi_chamraj','bangalore',50000),('sbi_residency','bangalore',10000),('sbi_shivaji','bombay',20000),('sbi_parliment','delhi',10000),('sbi_jantarmantur','delhi',20000);
select * from branch;


insert into bankacc values(1,'sbi_chamraj',2000),
(2,'sbi_residency',5000),
(3,'sbi_shivaji',6000),
(4,'sbi_parliment',9000),
(5,'sbi_jantarmantar',8000),
(6,'sbi_shivaji',4000),
(7,'sbi_residency',4000),
(8,'sbi_parliment',3000),
(9,'sbi_residency',5000),
(10,'sbi_jantarmantar',2000);
select * from bankacc;

insert into bankcust values
('avinash','Bull_temple_road','bangalore'),
('Dinesh','Bannergatta_road','bangalore'),
('mohan','nationacollege_road','bangalore'),
('nikil','akbar_road','delhi'),
('ravi','prithviraj_road','delhi');

insert into depositer values
('avinash',1),
('Dinesh',2),
('nikil',4),
('ravi',5),
('avinash',7),
('nikil',8),
('Dinesh',9),
('nikil',10);

select * from depositer;

insert into loan values
(1,'sbi_chamraj',1000),
(2,'sbi_residency',2000),
(3,'sbi_shivaji',3000),
(4,'sbi_parliment',4000),
(5,'sbi_jantarmantar',5000);
insert into loan values(6,'sbi_shivaji',3000),(7,'sbi_parliment',4000);
 select * from loan;


select d.customer_name , b.branch_name , count(*) as numofdepo
from depositer d
join bankacc b on d.acc_no = b.acc_no
group by b.branch_name,d.customer_name
having count(*) >=2;


alter table branch 
rename column assets to assets_in_lakhs ;

select  branch_name,assets/100000 as assets_in_lakhs from branch;

create view sum_of_loan
as select sum(amount) as sum_of_loan,branch_name from loan
group by branch_name ;
select * from sum_of_loan;