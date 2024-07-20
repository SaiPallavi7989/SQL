CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    Age INT,
    DepartmentID INT,
    Salary int
);
INSERT INTO Employees (EmployeeID, Name, Age, DepartmentID, Salary)
VALUES
    (1, 'Alice', 28, 101, 50000),
    (2, 'Bob', 35, 102, 60000),
    (3, 'Charlie', 30, 101, 55000),
    (4, 'David', 32, 103, 62000),
    (5, 'Eve', 25, 102, 48000);
select * from Employees;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255)
);
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
    (101, 'HR'),
    (102, 'Finance'),
    (103, 'Marketing');
    select * from Departments;
    use fixity;
    delimiter $$
    create procedure AddEmployee()
sleepday    Begin
    insert into Employees values(6,'Pallavi',20,103,50000);
end$$
delimiter ;
call AddEmployee();
select * from Employees;



create view EmployeeDetails as
select Name,Age,DepartmentName from Employees join Departments on Employees.DepartmentId=Departments.DepartmentId;

select * from EmployeeDetails;

