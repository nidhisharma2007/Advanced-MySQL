#1. Hello World Function
create function hello_worldd()
returns varchar(50)
deterministic
return 'Hello World';

select hello_worldd();


#2. Reverse String Function
create function reverse_string(str varchar(50))
returns varchar(50)
deterministic
return reverse(str);

select reverse_string('hello');


#3. Add Two Numbers Function
create function add_numbers(a int,b int)
returns int
deterministic
return a+b;

select add_numbers(10,20);


#4. Area of Rectangle Function
create function rectangle_area(l int,b int)
returns int
deterministic
return l*b;

select rectangle_area(10,5);


#5. Average of Three Numbers Function
create function average_num(a int,b int,c int)
returns decimal(10,2)
deterministic
return (a+b+c)/3;

select average_num(10,20,30);


#6. Maximum of Two Numbers Function
create function max_num(a int,b int)
returns int
deterministic
return greatest(a,b);

select max_num(10,20);


#7. Count Vowels in a String Function
create function count_vowels(str varchar(100))
returns int
deterministic
return 
(length(lower(str)) - length(replace(lower(str),'a','')))
+
(length(lower(str)) - length(replace(lower(str),'e','')))
+
(length(lower(str)) - length(replace(lower(str),'i','')))
+
(length(lower(str)) - length(replace(lower(str),'o','')))
+
(length(lower(str)) - length(replace(lower(str),'u','')));

select count_vowels('Artificial Intelligence');


#8. Factorial of a Number Function
delimiter //

create function factorial(n int)
returns int
deterministic

begin

declare i int default 1;
declare fact int default 1;

while i<=n do
set fact=fact*i;
set i=i+1;
end while;

return fact;

end //

delimiter ;

select factorial(6);


#9. Simple Interest Function
create function simple_interest(p int,r int,t int)
returns int
deterministic
return (p*r*t)/100;

select simple_interest(200,3,2);


#10. Palindrome Function
create function palindrome(str varchar(50))
returns varchar(20)
deterministic
return if(str = reverse(str),'Palindrome','Not Palindrome');

select palindrome('madam');