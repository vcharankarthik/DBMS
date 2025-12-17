create database employee;
use employee;

create table employee(
empno int primary key,
ename char(20),
mgr_no int,
hiredate date,
sal int,
deptno int,
foreign key(deptno) references dept(deptno));

create table dept(
deptno int primary key,
dname varchar(10),
dloc varchar(20));

create table project (
pno int primary key,
ploc varchar(20),
pname varchar(20));

create table incentives(
empno int,
incentive_date date,
intcentive_amount int,
foreign key(empno) references employee(empno));

create table asg_to(
empno int,
pno int,
job_role varchar(30),
foreign key(empno) references employee(empno),
foreign key(pno) references project(pno));

INSERT INTO dept VALUES
(10, 'Accounts', 'Bangalore'),
(20, 'Sales', 'Mumbai'),
(30, 'HR', 'Delhi'),
(40, 'IT', 'Hyderabad'),
(50, 'Admin', 'Chennai'),
(60, 'Research', 'Mysore');

INSERT INTO employee VALUES
(101, 'Arjun',   0, '2022-05-10', 45000, 10),
(102, 'Bhavna', 101, '2021-07-22', 52000, 20),
(103, 'Charan', 102, '2023-01-15', 48000, 30),
(104, 'Deepa',  101, '2020-03-18', 60000, 40),
(105, 'Esha',   104, '2022-11-05', 55000, 50),
(106, 'Farhan', 102, '2024-04-09', 50000, 60);

update employee
set deptno = 10
where empno = 104;

INSERT INTO project VALUES
(1, 'Bangalore', 'BankApp'),
(2, 'Mumbai', 'ECommerce'),
(3, 'Chennai', 'HRPortal'),
(4, 'Delhi', 'CRMSystem'),
(5, 'Hyderabad', 'Inventory'),
(6, 'Mysore', 'AIResearch');


INSERT INTO incentives VALUES
(101, '2024-01-15', 5000),
(102, '2024-03-10', 3000),
(103, '2024-05-20', 2500),
(104, '2024-07-05', 6000),
(106, '2024-09-30', 3500);


INSERT INTO asg_to VALUES
(101, 1, 'Team Lead'),
(102, 2, 'Developer'),
(103, 3, 'HR Coordinator'),
(104, 4, 'Tester'),
(105, 5, 'Network Engineer'),
(106, 6, 'Data Analyst');


select e.empno from employee e
join asg_to a on e.empno = a.empno
join project p on a.pno= p.pno
where p.ploc in ("Mysore","Bangalore","Hyderabad");

SELECT e.empno, e.ename
FROM employee e
LEFT JOIN incentives i ON e.empno = i.empno
WHERE i.empno IS NULL;

select e.ename,e.empno,e.deptno,a.job_role,d.dloc,p.ploc
from employee e
join dept d on e.deptno=d.deptno
join asg_to a on e.empno = a.empno
join project p on a.pno=p.pno
where d.dloc = p.ploc;

SELECT e.ename AS manager_name
FROM employee e
WHERE e.empno IN (
    SELECT mgr_no
    FROM employee
    WHERE mgr_no IS NOT NULL
    GROUP BY mgr_no
    HAVING COUNT(*) = (
        SELECT MAX(emp_count)
        FROM (
            SELECT COUNT(*) AS emp_count
            FROM employee
            WHERE mgr_no IS NOT NULL
            GROUP BY mgr_no
        ) temp
    )
);

SELECT m.ename AS manager_name
FROM employee e
JOIN employee m ON e.mgr_no = m.empno   
GROUP BY m.empno, m.ename, m.sal
HAVING m.sal > AVG(e.sal);


select e.ename from employee e 
join employee t on e.mgr_no = t.empno
where t.mgr_no = 0; 

select e.ename from employee e
join incentives i on e.empno=i.empno
where i.intcentive_amount = ( select max(intcentive_amount) from incentives
where intcentive_amount <(select max(intcentive_amount) from incentives) );

select e.ename from employee e
join employee m on e.mgr_no = m.empno
where e.deptno = m.deptno;
