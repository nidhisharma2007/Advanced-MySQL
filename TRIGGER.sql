create database trigger_practise;
use trigger_practise;

create table employees (
  emp_id int primary key,
  name varchar(50),
  salary decimal(10,2)
);

create table employee_log (
  log_id int auto_increment primary key,
  emp_id int,
  action varchar(50),
  log_time timestamp default current_timestamp
); 

insert into employees (emp_id, name, salary)
values
(1, 'Amit', 50000.00),
(2, 'Neha', 62000.00),
(3, 'Ravi', 45000.00),
(4, 'Priya', 70000.00);


-- 1. Trigger to Log Insert Activity
Delimiter //
create trigger trg_after_insert_employee
after insert on employees
for each row
begin
insert into employee_log(emp_id, action)
values (NEW.emp_id, 'Employee Inserted');
end //
Delimiter ;

insert into employees values (5, 'Rahul', 50000);


-- 2. Trigger to Log Employee Delete
Delimiter //
create trigger trg_after_delete_employee
after delete on employees
for each row
begin
insert into employee_log(emp_id, action)
values (OLD.emp_id, 'Employee Deleted');
end //
Delimiter ;

delete from employees where emp_id = 1;


-- 3. Trigger to Log Salary Update
Delimiter //
create trigger trg_after_salary_update
after update on employees
for each row
begin
if OLD.salary <> NEW.salary then
   insert into employee_log(emp_id, action)
   values (NEW.emp_id, 'Salary Updated');
end if;
end //
Delimiter ;

set sql_safe_updates=0;

update employees
set salary = 60000
where emp_id = 2;


-- 4. Trigger to Prevent Negative Salary
Delimiter //
create trigger trg_before_insert_salary
before insert on employees
for each row
begin
if NEW.salary < 0 then
   signal sqlstate '45000'
   set message_text = 'Salary cannot be negative';
end if;
end //
Delimiter ;

insert into employees values (6, 'Neha', -5000);


-- 5. Trigger to Automatically Increase Salary by 10%
Delimiter //
create trigger trg_before_insert_bonus
before insert on employees
for each row
begin
set NEW.salary = NEW.salary * 1.10;
end //
Delimiter ;

insert into employees values (7, 'Karan', 40000);


-- 6. Trigger to Store Old and New Salary Change
Delimiter //
create trigger trg_salary_change
after update on employees
for each row
begin
if OLD.salary <> NEW.salary then
   insert into employee_log(emp_id, action)
   values (
      NEW.emp_id,
      concat('Salary changed from ',
             OLD.salary,
             ' to ',
             NEW.salary));
end if;
end //
Delimiter ;

update employees
set salary = 70000
where emp_id = 3;


-- 7. Trigger to Convert Employee Name to Uppercase
Delimiter //
create trigger trg_uppercase_name
before insert on employees
for each row
begin
set NEW.name = upper(NEW.name);
end //
Delimiter ;

insert into employees values (8, 'rahul', 30000);


-- 8. Trigger to Restrict Salary Reduction
Delimiter //
create trigger trg_prevent_salary_reduce
before update on employees
for each row
begin
if NEW.salary < OLD.salary then
   signal sqlstate '45000'
   set message_text = 'Salary reduction not allowed';
end if;
end //
Delimiter ;

update employees
set salary = 30000
where emp_id = 2;


-- 9. Trigger to Log Name Changes
Delimiter //
create trigger trg_name_change
after update on employees
for each row
begin
if OLD.name <> NEW.name then
   insert into employee_log(emp_id, action)
   values (NEW.emp_id, 'Employee Name Changed');
end if;
end //
Delimiter ;

update employees
set name = 'Kaju'
where emp_id = 4;


-- 10. Trigger to Prevent Empty Employee Name
Delimiter //
create trigger trg_no_empty_name
before insert on employees
for each row
begin
if NEW.name = '' then
   signal sqlstate '45000'
   set message_text = 'Employee name cannot be empty';
end if;
end //
Delimiter ;

insert into employees values (9, '', 40000);


-- 11. Trigger to Log High Salary Employee
Delimiter //
create trigger trg_high_salary
after insert on employees
for each row
begin
if NEW.salary > 80000 then
   insert into employee_log(emp_id, action)
   values (NEW.emp_id, 'High Salary Employee Added');
end if;
end //
Delimiter ;

insert into employees values (10, 'Karan', 90000);


-- 12. Trigger to Set Default Salary
Delimiter //
create trigger trg_default_salary
before insert on employees
for each row
begin
if NEW.salary is null then
   set NEW.salary = 25000;
end if;
end //
Delimiter ;

insert into employees(emp_id, name)
values (11, 'Simran');


-- 13. Trigger to Prevent Duplicate Employee Name
Delimiter //
create trigger trg_duplicate_name
before insert on employees
for each row
begin
if exists (
   select * from employees
   where name = NEW.name
) then
   signal sqlstate '45000'
   set message_text = 'Employee name already exists';
end if;
end //
Delimiter ;

insert into employees values (12, 'Amit', 50000);


-- 14. Trigger to Add Joining Message
Delimiter //
create trigger trg_join_message
after insert on employees
for each row
begin
insert into employee_log(emp_id, action)
values (NEW.emp_id, 'Welcome New Employee');
end //
Delimiter ;

insert into employees values (13, 'Rohan', 45000);


-- 15. Trigger to Add Bonus Salary on Update
Delimiter //
create trigger trg_bonus_salary
before update on employees
for each row
begin
if OLD.salary <> NEW.salary then
   set NEW.salary = NEW.salary + 1000;
end if;
end //
Delimiter ;

update employees
set salary = 70000
where emp_id = 2;
