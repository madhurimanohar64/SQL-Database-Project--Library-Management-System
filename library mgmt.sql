/* 
Project: Library management system
Steps involved in case study are as follows:
i will be stepping down case subject into below procedures;
1. create database - done
2. create tables with constraints -done
3. give references if any with tables -done
4. insert values into table- done
5. check all values are propely mentioned- done
6. verify all tables, any changes modify in values (DDL) or update in columns names (DML)- done
7. perfom - min 1- view- done
8. perfom- min 1- stored procedure- done
9. perfom- min 1- function- done
10. perfom- min 1- trigger- done
*/
create database library;

use library;

show databases; -- it will show all databases created in software

show tables; -- it will show all table available in database

-- creating "books" table
create table books(
bookid int primary key,
title varchar(100) not null,
author varchar(100),
publisher varchar(100),
isbn int not null unique,
qty int not null
);

desc books; -- it will information about column decription, data type & its constaints

-- adding value in "books" table
insert into books values (1, "wirless communication", "theodore rappaport", "pearson education",1234,6);
insert into books values (2, "microwave and radar engineering", "samuel", "pearson education",2345,7);
insert into books values (3, "optical communication", "gerd keiser", "wiley",3456,10);
insert into books values (4, "vlsi design", "david harris", "pearson education",4567,4);
insert into books values (5, "embedded systems", "raj kamal", "mcgraw hill education",5678,5);
insert into books values (6, "micro processors and controllers", "raj kamal", "mcgraw hill education",6789,4);
insert into books values (7, "digital electronics", "raj kamal", "mcgraw hill education",7890,10);
insert into books values (8, "microelectronic circuits", "adel sedra", "oxford university press",8901,5);
insert into books values (9, "electronic devices and circuits", "david bell", "oxford university press",9012,7);
insert into books values (10, "digital circuits", "david bell", "oxford university press",1023,0);

select * from books;

-- creating "students" table
create table students(
studid int primary key,
firstname varchar(80) not null,
lastname varchar(80) not null,
email varchar(100),
contactnum int not null,
doa date
);

drop table students;

select * from students;

-- adding values in "students" table
insert into students values(100,"madhuri","manohar","manohar.madhuri@gmail.com",353975,"2008-06-01");
insert into students values(101,"pradnya","minmine","pradnyaminmine@gmail.com",321667,"2008-06-01");
insert into students values(102,"vinita","singh","vinnusingh@gmail.com",345678,"2008-06-02");
insert into students values(103,"varsha","pokharkar","varshupokharkar@gmail.com",323333,"2008-06-10");
insert into students values(104,"namrata","pawar","namupawar@gmail.com",333333,"2008-06-03");
insert into students values(105,"nikita","patil","nikupatil@gmail.com",344444,"2008-06-08");
insert into students values(106,"anita","parab","anduparab@gmail.com",356789,"2008-06-07");

-- creating "borrowing" table
create table borrowing(
borrowid int primary key,
studid int,
bookid int,
foreign key (studid) references students(studid),
foreign key (bookid) references books(bookid),
borrowdate date not null,
returndate date,
librarian_person varchar(100),
qty int not null
);

drop table borrowing;

-- inserting value in "borrowing table"
insert into borrowing values (500,100,1,"2008-08-08","2008-09-01","linashree",1);-- for madhuri
insert into borrowing values (501,101,1,"2008-08-07","2008-09-28","jayshree",1); -- for pradnya
insert into borrowing values (502,102,2,"2008-08-08","2008-09-01","linashree",1); -- for vinita
insert into borrowing values (503,103,3,"2008-08-08","2008-10-15","jayshree",1); -- for varsha
insert into borrowing values (504,104,4,"2008-08-01","2008-10-15","linashree",1); -- for namrata
insert into borrowing values (505,100,5,"2008-08-05","2008-10-15","jayshree",1);-- for madhuri
insert into borrowing values (506,101,6,"2008-08-02","2008-09-02","linashree",1);-- for pradnya
insert into borrowing values (507,105,7,"2008-08-08",null,"jayshree",1);-- for nikita
insert into borrowing values (508,106,7,"2008-08-08",null,"linashree",1);-- for anita
insert into borrowing values (509,106,9,"2008-08-08","2008-09-01","jayshree",1);-- for anita
insert into borrowing values (510,105,3,"2008-08-08","2008-09-15","linashree",1);-- for nikita

-- creating table of staff
create table librarian(
staffid int primary key,
firstname varchar(100) not null,
lastname varchar(100),
email varchar(200) not null
);

select * from librarian;

-- inserting values in "librarian" table
insert into librarian values(50,"linashree","sawant","linasawant@gmail.com");
insert into librarian values(51,"jayshree","gahane","jayugahane@gmail.com");

-- to see all tables at one place instead scrolling over multiple times whenever needed
select * from books;
select * from students;
select * from borrowing;
select * from librarian;

/* View
two type of view:
1. simple view
2. complex view

*/ 

-- 1. simple view
-- creating simple view:
-- View 1 - where we want to see books details from books table.
create view bookinfoview as select title, author, publisher, isbn from books;

select * from bookinfoview; -- to see view

-- View 2 - 
create view studentcontactview as select studid, email,contactnum from students; 


select * from studentcontactview;

-- View 3- Complex view- this type of view used with 2 more tables
create view studbookissueview as select s.studid, s.firstname, b.borrowid, b.bookid, bo.title
from students s
inner join borrowing b on s.studid = b.studid 
inner join books bo on b.bookid = bo.bookid;

select * from studbookissueview;

select * from studbookissueview where studid=100;




-- adding new values in borrowing table
-- forgot to add issuer person from librarian people
alter table borrowing add librarian_person varchar(100); -- adding col & data type

-- adding new value as librarian_person name in borrowing table
update borrowing set librarian_person="jayshree" where borrowid=500;
update borrowing set librarian_person="linashree" where borrowid=501;
update borrowing set librarian_person="linashree" where borrowid=502;
update borrowing set librarian_person="jayshree" where borrowid=503;
update borrowing set librarian_person="linashree" where borrowid=504;
update borrowing set librarian_person="jayshree" where borrowid=505;
update borrowing set librarian_person="linashree" where borrowid=506;
update borrowing set librarian_person="jayshree" where borrowid=507;
update borrowing set librarian_person="linashree" where borrowid=508;
update borrowing set librarian_person="jayshree" where borrowid=509;
update borrowing set librarian_person="linashree" where borrowid=510;

select * from borrowing;

-- display which from which borrowid have not receieved book
select borrowid from borrowing where returndate is null; -- 507,508

-- display which studid have not returned book
select borrowid, studid, bookid, borrowdate from borrowing where returndate is null; -- 507, 508

/*
STORED PROCEDURE - to use query again & again
delimiter concept comes in the case of stored procedure
*/

-- stored procedure 1
delimiter //
create procedure proc1()
begin
select * from students;
end //

call proc1(); -- it will show students table instead of writting select * from students.

-- stored procedure 2
select * from books where publisher like 'p%'; -- testing if its working w/o procedure -- working

delimiter //
create procedure pub_pearson()
begin
select title from books where publisher like 'p%'; 
end //

call pub_pearson(); -- it will books published by publisher pearson

-- stored procedure 3 

delimiter //
create procedure pending_return(in br_studid int)
begin
select * from borrowing where br_studid=studid;
end //

call pending_return(105); -- shows results of 105 studid borrowed books

call pending_return(106); -- shows results of 106 studid borrowed books

call pending_return(101); -- shows results of 101 studid borrowed books

-- stored procedure 4
select * from books where qty>=1;

delimiter //
create procedure total_book_count()
begin
    select * from books where qty>=1;
end //

call total_book_count();

-- stored procedure 5
delimiter //
create procedure stock_out_count()
begin
    select * from books where qty=0;
end //

drop procedure stock_out_count;

call stock_out_count();

/*Functions:
two type of function:
1. built in function
	1. math function- pow, sqrt, mod, abs,round, ceil, floor
    2. date function- 
    3. comparision function- isnull(), greatest(), null()
    4. aggreation function
2. user defined function
*/
-- built in function- aggreation function: sum, avg,max, min, count(*), count(column) from table.
-- function 1
select sum(qty) from borrowing; -- 11 total books borrowed by student from library
select max(qty) from borrowing; -- 1 
select min(qty) from borrowing; -- 1
select sum(qty) from books; -- 55 - it shows total books in books table

-- built in function- date function- now(), current_date(), current_timestamp, datediff(date col name, now()), date format in digit in small & capital in caps

-- function 2
select datediff(returndate,borrowdate) from borrowing where borrowid=500; -- 24 days

select datediff(returndate,borrowdate) from borrowing where borrowid=507; -- null as returndate is null

select datediff(borrowdate,now()) from borrowing where borrowid=500; -- 5849 

-- built in function- comparision function
select greatest(15, 35, 800, 200); -- 800

select least(15, 35, 800, 200); -- 15

select isnull(50); -- 0
select isnull(50/0);-- 1
select isnull(null);-- 1

-- function 3-  type -user defined function 
-- creating to get the number of Books borrowed by a specific student
delimiter //
create function books_borrowed_by_student1(stud_id int)
returns int
deterministic
begin
    declare borrowed_count INT;
    select count(*) into borrowed_count from borrowing where studid = stud_id;
    return borrowed_count;
end //


select books_borrowed_by_student1(100);



/*
Triggers- trigger actually perfomerd with DML commnd- insert,update & delete.
triggers are used for validation kind of auditing /checking. 
*/
-- trigger 1 
-- creating trigger to update books table qty column after borrowing book from borrowing table.
 
 delimiter //
 create trigger trig_update_book_qty_after
 after insert on borrowing 
 for each row
 begin
 update books set qty= qty- new.qty where bookid= new.bookid;
 end //
 
 -- now lets borrow 1 book by using insert into command which we have used while creating borrowing table 
 
insert into borrowing values (511,100,9,"2008-08-05","2008-10-15","jayshree",1);-- for madhuri

select * from books;

insert into borrowing values (512,100,8,"2008-08-05","2008-10-15","jayshree",1);-- for madhuri -- 5 to 4
insert into borrowing values (513,100,7,"2008-08-05","2008-10-15","jayshree",1);-- for madhuri -- 10 to 9

select * from borrowing where librarian_person="jayshree";

select * from borrowing where librarian_person="jayshree" and returndate is null;

-- trigger 2 : creating trigger to update books table after retuning borrowed book

delimiter //
create trigger trig_update_books_on_return
after update on books
for each row
begin
update books set qty=qty + old.qty where bookid= new.bookid;
end //

-- now lets return any book borrowed by students
update borrowing set returndate="2008-10-10" where borrowid=508;


-- now check books
select * from books;
select *from borrowing;

select * from borrowing where studid=100; -- it will the list of borrowed book by particular studid

select * from books where qty=0; -- to check book stock before issuing to students

select * from books where author in ('raj kamal','samuel'); -- IN operator - Special operator in DQL 

select * from books where author='raj kamal';-- specific author wise or publisher wise as we want 

select * from books where publisher='wiley';

select * from borrowing where returndate is null; -- comparison operator

select * from borrowing where returndate is not null;

select qty from borrowing where librarian_person='linashree';
select sum(qty) from borrowing where librarian_person='linashree';


select * from borrowing where borrowdate between "2008-08-05" and "2008-08-08";

select * from borrowing where borrowdate not between "2008-08-05" and "2008-08-08"; 

select * from borrowing where borrowdate between "2008-08-05" and now();

select * from borrowing where borrowdate between "2008-08-05" and current_date;

select title from books where author like 'raj%';-- like operator is string operator

select * from books where author like 'raj%';

select * from students where lastname like 'm%'; 

-- stored procedure - for ease purpose 
delimiter //
create procedure books()
begin
select * from books;
end //

delimiter //
create procedure students()
begin
select * from students;
end //

delimiter //
create procedure borrowing()
begin
select * from borrowing;
end //

delimiter //
create procedure librarian()
begin
select * from librarian;
end //

call books;
call students;
call borrowing;
call librarian;

