show databases;

use Studentinfo;

select * from student;

alter table student rename to student_info;

select * from student_info;

alter table student_info drop column gender;

alter table student_info rename column stdlib to stdid;

select * from student_info;
