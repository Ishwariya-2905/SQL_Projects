create database case_study2;
use case_study2;

create table Location(
Location_ID int NOT NULL PRIMARY KEY,
City varchar(30)
);

insert into Location(Location_ID, City)
values(122, 'New York'),(123, 'Dallas'),(124, 'Chicago'),(167, 'Boston')

select * from Location;

create table Department(
Department_Id int NOT NULL PRIMARY KEY,
DeptName varchar(20),
DepLocation_ID INT FOREIGN KEY REFERENCES Location(Location_ID)
);

insert into Department(Department_Id,DeptName,DepLocation_ID)
values(10, 'Accounting', 122),
(20, 'Sales', 124),
(30, 'Research', 123),
(40, 'Operations', 167)

select * from Department

create table Job(
Job_ID int NOT NULL PRIMARY KEY,
Designation varchar(30),
);

insert into Job(Job_ID,Designation)
values(667, 'Clerk'),
(668, 'Staff'),
(669, 'Analyst'),
(670, 'Sales Person'),
(671, 'Manager'),
(672, 'President')

select * from Job

create table Employee(
Employee_Id int,
Last_Name varchar(20),
First_Name varchar(20),
Middle_Name varchar(20),
Job_ID INT FOREIGN KEY REFERENCES Job(Job_ID),
MANAGER_ID INT,
Hire_Date Date,
Salary int,
Comm int,
Department_Id INT FOREIGN KEY REFERENCES Department(Department_Id)
);

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)


select * from Employee;

--Simple Queries:
--1. List all the employee details.
select * from Employee;

--2. List all the department details.
select * from Department;

--3. List all job details.
select * from Job;

--4. List all the locations.
select * from Location;

--5. List out the First Name, Last Name, Salary, Commission for all Employees.
select First_Name, Last_Name, Salary, Comm from Employee;

--6.List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID as 
--"ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".
select Employee_Id  as ID_of_the_Employee,
Last_Name as Name_of_the_Employee,
Department_Id as Dep_id
from Employee

--7.List out the annual salary of the employees with their names only.
select First_Name, Last_Name,
salary*12 as Annual_salary
from Employee

--WHERE Condition:
--1. List the details about "Smith".
select * from Employee where Last_Name = 'Smith'

--2. List out the employees who are working in department 20.
select * from Employee where Department_Id = 20

--3. List out the employees who are earning salary between 2000 and 3000.
select * from Employee where Salary between 2000 and 3000;

--4.List out the employees who are working in department 10 or 20. 
select * from Employee where Department_Id in (10, 20)--1st method
select * from Employee where Department_Id = 10 or Department_Id = 20--2nd method

--5.Find out the employees who are not working in department 10 or 30.
select * from Employee where Department_Id not in (10, 30)

--6. List out the employees whose name starts with 'L'. 
select * from Employee 
where First_Name like 'L%'

--7. List out the employees whose name starts with 'L' and ends with 'E'.
select * from Employee
where First_Name like 'L%E'

--8. List out the employees whose name length is 4 and start with 'J'. 
select * from Employee       -- 1st method
where First_Name like 'J%' and len(First_Name) = 4

select * from Employee        -- 2nd method
where First_Name like 'J___' --using one character operator here

--9.List out the employees who are working in department 30 and draw the salaries more than 2500. 
select * from employee
where Department_Id = 30 and Salary > 2500

--10. List out the employees who are not receiving commission.
select * from Employee
where comm IS NULL

--ORDER BY CLAUSE
--1.List out the Employee ID and Last Name in ascending order based on the Employee ID. 
select Employee_Id , Last_Name
from Employee
order by Employee_Id;

--2.List out the Employee ID and Name in descending order based on salary. 
select Employee_Id , Salary
from Employee
order by Salary desc;

--3.List out the employee details according to their Last Name in ascending-order. 
select * 
from employee
order by Last_Name;

--4. List out the employee details according to their Last Name in ascending 
--order and then Department ID in descending order.
select * from employee
order by Last_Name, Department_Id desc;

--GROUP BY and HAVING Clause:
--1. List out the department wise maximum salary, minimum salary and average salary of the employees. 
select Department_Id ,max(salary) as Max_Salary, min(salary) as Max_Salary, avg(salary) as Avg_Salary
from Employee
group by Department_Id

--2.List out the job wise maximum salary, minimum salary and average salary of the employees. 
select Job_ID, max(Salary) as Maximum, min(Salary) as Minimum, avg(Salary) as Average
from Employee
group by Job_ID

--3.List out the number of employees who joined each month in ascending order.
select count(Employee_Id) as Num_of_Emps,
month(Hire_Date) as JoinMonth
from Employee
group by month(Hire_Date)
order by month(Hire_Date)

--4.List out the number of employees for each month and year 
--in ascending order based on the year and month.
select count(Employee_Id) as Num_of_Emps,
month(Hire_Date) as JoinMonth,
Year(Hire_Date) as JoinYear
from Employee
group by month(Hire_Date), Year(Hire_Date)
order by month(Hire_Date), Year(Hire_Date)

--5.List out the Department ID having at least four employees. 
select department_Id,count(Department_Id)  as No_of_Employees
from Employee
group by Department_Id
having count(Department_Id) = 4 

--6.How many employees joined in February month.
select count(Hire_Date) as Employee_count
from employee
group by month(Hire_Date)
having month(Hire_date) = 04

--7.How many employees joined in May or June month. 
select count(Hire_date) as Employee_count 
from employee
group by month(hire_date)
having month(hire_date) = 05 or month(hire_date) = 06

--8. How many employees joined in 1985? 
select count(hire_date) as No_of_employees
from employee
group by year(hire_date)
having year(hire_date) = 1985

--9. How many employees joined each month in 1985? 
select hire_date,count(hire_date) as No_of_employees
from employee
group by hire_date,month(hire_date), year(hire_date)
having year(hire_date) = 1985

--10. How many employees were joined in April 1985? 
select hire_date, count(hire_date) as No_of_employees
from employee
group by hire_date , month(hire_date), year(hire_date)
having month(hire_date) = 04 and year(hire_date) = 1985

--11. Which is the Department ID having greater than or equal to 3 employees 
--joining in April 1985?
select department_id
from employee
group by department_id, month(hire_date), year(hire_date)
having count(employee_id) >= 3 or month(hire_date) = 04 and year(hire_date) = 1985

--Joins: 
--1. List out employees with their department names. 
select E.* , DeptName 
from Employee as E
inner join 
Department as D
on E.Department_Id = D.Department_Id

--2. Display employees with their designations. 
select E.*, Designation
from Employee as E
inner join
Job as J
on E.Job_ID = J.Job_ID

--3. Display the employees with their department names and city. 
select E.* , DeptName, City
from Employee as E
inner join 
Department as D
on E.Department_Id = D.Department_Id
inner join
Location as L
on D.DepLocation_ID = L.Location_ID


--4. How many employees are working in different departments? Display with 
--department names. 
select count(Employee_Id),DeptName
from Employee as E
inner join
Department as D
on E.Department_Id = D.Department_Id 
group by D.DeptName

--5. How many employees are working in the sales department? 
select DeptName, count(Employee_Id) as No_Of_Employees
from Employee as E
inner join
Department as D
on E.Department_Id = D.Department_Id
group by DeptName
having DeptName = 'Sales'

--6. Which is the department having greater than or equal to 3 employees and display the department names in 
--ascending order. 
select DeptName, count(Employee_Id) as No_Of_Employees
from Employee as E
inner join
Department as D
on E.Department_Id = D.Department_Id
group by DeptName 
having count(Employee_Id) >= 3
order by DeptName

--7. How many employees are working in 'Dallas'? 
select city, count(employee_id) as No_of_employees
from Employee as E
inner join
department as D
on E.department_id = D.Department_id
inner join
location as L
on L.location_id = D.DepLocation_ID
where city = 'Dallas'
group by city

--8. Display all employees in sales or operation departments. 
select *
from Employee as E
inner join
department as D
on E.department_id = D.Department_id
where deptName = 'sales' or deptName = 'Operations'

--Conditional statements
--1. Display the employee details with salary grades. Use conditional statement to 
--create a grade column. 
select * ,
case
when salary < 1000 then 'A'
when salary between 1000 and 1500 then 'B'
when salary between 1500 and 2000 then 'C'
when salary between 2000 and 2500 then 'D'
when salary between 2500 and 3000 then 'E'
end as Grade
from employee

--2. List out the number of employees grade wise. Use conditional statement to 
--create a grade column. 
select
case
when salary < 1000 then 'A'
when salary between 1000 and 1500 then 'B'
when salary between 1500 and 2000 then 'C'
when salary between 2000 and 2500 then 'D'
when salary between 2500 and 3000 then 'E'
end as Grade,
count(employee_Id) as Number_of_employees
from employee 
group by 
case
when salary < 1000 then 'A'
when salary between 1000 and 1500 then 'B'
when salary between 1500 and 2000 then 'C'
when salary between 2000 and 2500 then 'D'
when salary between 2500 and 3000 then 'E'
end

--3. Display the employee salary grades and the number of employees between 
--2000 to 5000 range of salary.
select 
case
when salary < 1000 then 'A'
when salary between 1000 and 1500 then 'B'
when salary between 1500 and 2000 then 'C'
when salary between 2000 and 2500 then 'D'
when salary between 2500 and 3000 then 'E'
end as Grade,
count(*) as Number_of_employees
from employee
where salary between 2000 and 5000
group by 
case
when salary < 1000 then 'A'
when salary between 1000 and 1500 then 'B'
when salary between 1500 and 2000 then 'C'
when salary between 2000 and 2500 then 'D'
when salary between 2500 and 3000 then 'E'
end 


--Sub-queries
--1. Display the employees list who got the maximum salary. 
select * from Employee where salary =
(select max(salary) from employee)

--2. Display the employees who are working in the sales department.
select * from employee where department_id =
(select Department_Id from Department where DeptName = 'sales')

--3.Display the employees who are working as 'Clerk'.
select * from employee where Job_id =
(select Job_id from job where designation = 'Clerk')

--4. Display the list of employees who are living in 'Boston'.
select * from employee where department_id = 
(select department_id from department where deplocation_id = 
(select location_id from location where city = 'Boston'))

--5.Find out the number of employees working in the sales department. 
select count(Employee_id) as num_of_employees from employee where department_id =
(select department_id from department where deptname = 'Sales')

--6.Update the salaries of employees who are working as clerks on the basis of 10%.
update employee set salary = salary * 1.1 where job_id =
(select job_id from job where designation = 'Clerk')
-- 10/100 * salary + salary => 0.1*salary + salary => salary(0.1+1) = salary * 1.1

--7.Display the second highest salary drawing employee details.
select max(salary) from employee where salary =
(select salary from employee)

--8.List out the employees who earn more than every employee in department 30. 
select * from employee where salary =
(select max(salary) from employee where department_id = 30)

--9.Find out which department has no employees. 
Select * from department
where Department_Id not in 
(select distinct Department_Id
from employee)

--10.Find out the employees who earn greater than the average salary for their department.
select * from employee where salary=
(select max(salary) from employee having max(salary) =
(select avg(salary) from employee group by department_id having max(salary) > avg(salary)))




















