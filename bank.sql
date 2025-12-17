create database bank;
use bank;

create table branch (
branch_name varchar(30) primary key,
branch_city varchar(10),
assets int);

create table bankacc(
accno int primary key,
branch_name varchar(30),
balance int,
foreign key (branch_name) references branch(branch_name));

create table bankcust(
customer_name varchar(20) primary key,
customer_street varchar(20),
city varchar(10));

create table depositer(
customer_name varchar(20),
accno int,
primary key(customer_name,accno),
foreign key(accno)references bankacc(accno),
foreign key(customer_name)references bankcust(customer_name));
show tables;

create table loan(
loan_no int primary key,
branch_name varchar(30),
amount int,
foreign key(branch_name)references branch(branch_name));

create table borrower(
loan_no int primary key,
customer_name varchar(20),
foreign key(loan_no) references loan(loan_no),
foreign key(customer_name) references bankcust(customer_name));



insert into branch values('sbi_chamraj','bangalore',50000),('sbi_residency','bangalore',20000),('sbi_shivaji','bombay',20000),('sbi_parliment','delhi',10000),('sbi_jantarmantar','delhi',20000);

insert into bankacc values
(1,'sbi_chamraj',2000),
(2,'sbi_residency',5000),
(3,'sbi_shivaji',6000),
(4,'sbi_parliment',9000),
(5,'sbi_jantarmantar',8000),
(6,'sbi_shivaji',4000),
(7,'sbi_residency',4000),
(8,'sbi_parliment',3000),
(9,'sbi_residency',5000),
(10,'sbi_jantarmantar',2000);

insert into bankcust values
('avinash','bull_temple_road','bangalore'),
('dinesh','bannergatta_road','bangalore'),
('mohan','nationalcollege_road','bangalore'),
('nikil','akbar_road','delhi'),
('ravi','parithviraj_road','delhi');

insert into depositer values
('avinash',1),
('dinesh',2),
('nikil',4),
('ravi',5),
('avinash',7),
('nikil',8),
('dinesh',9),
('nikil',10);

insert into borrower values
(1,'avinash'),
(2,'dinesh'),
(3,'avinash'),
(4,'nikil'),
(5,'ravi');

insert into loan values
(1,'sbi_chamraj',1000),
(2,'sbi_residency',2000),
(3,'sbi_shivaji',3000),
(4,'sbi_parliment',4000),
(5,'sbi_jantarmantar',5000);

select d.customer_name,b.branch_name,count(*) as no_of_depo
from depositer d
join bankacc b on d.accno=b.accno
group by customer_name,branch_name
having count(*)>=2;

select * from branch;

select branch_name,assets/10000 as assets_in_lakhs from branch;

alter table branch
rename column assets to assets_in_lakhs;

create view sumofassets
as select sum(amount), branch_name from loan group by branch_name;

select * from sumofassets;

select distinct(d.customer_name),b.branch_name,a.branch_city 
from depositer d
join bankacc b on d.accno=b.accno
join branch a on b.branch_name=a.branch_name
where a.branch_city = 'delhi';

SELECT customer_name
FROM borrower  
WHERE customer_name NOT IN (
    SELECT customer_name
    FROM bankcust
);
SELECT DISTINCT b.customer_name
FROM bankcust b
WHERE b.customer_name NOT IN (
    SELECT customer_name
    FROM borrower
);
