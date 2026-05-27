create database sto;
use sto;
CREATE TABLE store (
    id INT,
    name varchar(30),
    department varchar(10),
    salary int
);
INSERT INTO store (id,name,department,salary) VALUES
(1, 'Alice','HR',50000),
(2, 'Bob', 'IT',700000),
(3, 'Charlie','IT',60000),
(4, 'David','HR',550000),
(5, 'Eve','Finance',65000);

#create a procedure to show all employees details
delimiter //
create procedure showallemployees() begin select * from store;
end //
delimiter ;
call showallemployees();

#create a stored procedure to fetch all employees from a specific department.
delimiter //
create procedure getemployeesdept(in dept_name varchar(50)) begin select * from store where department= dept_name;
end //
delimiter ;
call getemployeesdept('IT');

#create a stored procedure to increase salary by a given percentage for a department
delimiter //
create procedure increasesalary(
    in dept_name varchar(50),
    in percent_increase decimal(5,2)
)
begin
    update store
    set salary = salary + (salary * percent_increase / 100)
    where department = dept_name;
end //
delimiter ;
set sql_safe_updates=0;
call increasesalary('IT',10);

#create a procedure to return the total salary of all employees
delimiter //
create procedure totalsalary() 
begin select sum(salary) from store;
end //
delimiter ;
call totalsalary() ;

#create a procedure to insert a new employee
delimiter //
create procedure addemployee( in emp_name varchar(50),in emp_dept varchar(50), in emp_salary int) 
begin insert into store(name,department,salary) values (emp_name,emp_dept,emp_salary) ;
end //
delimiter ;
call addemployee('Frank','Finance',62000);
select * from store;

#create a procedure to delete an existing employee from the table
delimiter //
create procedure deleteemployee(in emp_id int)
begin
    delete from store
    where id = emp_id;
end //
delimiter ;
call deleteemployee(3);

#create a procedure to return average salary
delimiter //
create procedure avgsalary() 
begin select avg(salary) from store;
end //
delimiter ;
call avgsalary();

# create a procedure to get employees above a salary
delimiter //
create procedure getemploy(in salary_emp int) begin select * from store where salary_emp<salary;
end //
delimiter ;
call getemploy(56000);

#create  a procedure to get highest salary
delimiter //
create procedure maxsalary() begin select max(salary) from store ;
end //
delimiter ;
call maxsalary();

#create a procedure to update employee name
delimiter //
create procedure upadateemploy(
    in emp_name varchar(50),
    in id_emp int
)
begin
    update store
    set name = emp_name
    where id = id_emp;
end //
delimiter ;
call upadateemploy('Jupyter',1);
select * from store;






