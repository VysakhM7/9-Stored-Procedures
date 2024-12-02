-- Step 1: Create Database
CREATE DATABASE WorkerDB;

USE WorkerDB;

-- Step 2: Create Worker Table
CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT(15),
    JoiningDate DATETIME,
    Department CHAR(25)
);

-- Step 3: Insert Initial Records
INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
VALUES 
(1, 'John', 'Doe', 50000, '2020-01-15', 'IT'),
(2, 'Jane', 'Smith', 60000, '2021-06-20', 'HR'),
(3, 'Alice', 'Johnson', 55000, '2022-07-10', 'IT'),
(4, 'Bob', 'Brown', 45000, '2023-08-01', 'Finance'),
(5, 'Charlie', 'Davis', 70000, '2021-02-25', 'Finance');

-- Step 4: Create Stored Procedures

DELIMITER $$

-- 4.1 Add Worker Procedure
CREATE PROCEDURE AddWorker (
    IN p_Worker_Id INT,
    IN p_FirstName CHAR(25),
    IN p_LastName CHAR(25),
    IN p_Salary INT,
    IN p_JoiningDate DATETIME,
    IN p_Department CHAR(25)
)
BEGIN
    INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
    VALUES (p_Worker_Id, p_FirstName, p_LastName, p_Salary, p_JoiningDate, p_Department);
END $$

-- 4.2 Get Salary by Worker ID Procedure
CREATE PROCEDURE GetSalaryByWorkerId (
    IN p_Worker_Id INT,
    OUT p_Salary INT
)
BEGIN
    SELECT Salary INTO p_Salary FROM Worker WHERE Worker_Id = p_Worker_Id;
END $$

-- 4.3 Update Department Procedure
CREATE PROCEDURE UpdateDepartment (
    IN p_Worker_Id INT,
    IN p_Department CHAR(25)
)
BEGIN
    UPDATE Worker 
    SET Department = p_Department 
    WHERE Worker_Id = p_Worker_Id;
END $$

-- 4.4 Get Worker Count by Department Procedure
CREATE PROCEDURE GetWorkerCountByDepartment (
    IN p_Department CHAR(25),
    OUT p_WorkerCount INT
)
BEGIN
    SELECT COUNT(*) INTO p_WorkerCount 
    FROM Worker 
    WHERE Department = p_Department;
END $$

-- 4.5 Get Average Salary by Department Procedure
CREATE PROCEDURE GetAvgSalaryByDepartment (
    IN p_Department CHAR(25),
    OUT p_AvgSalary DECIMAL(15, 2)
)
BEGIN
    SELECT AVG(Salary) INTO p_AvgSalary 
    FROM Worker 
    WHERE Department = p_Department;
END $$

DELIMITER ;

-- Step 5: Procedure Call Examples

-- Add a new Worker
CALL AddWorker(6, 'David', 'Williams', 65000, '2024-05-10', 'IT');

-- Get Salary of Worker with ID 2
CALL GetSalaryByWorkerId(2, @salary);
SELECT @salary;

-- Update Department of Worker with ID 3
CALL UpdateDepartment(3, 'Marketing');

-- Get Worker Count in IT Department
CALL GetWorkerCountByDepartment('IT', @workerCount);
SELECT @workerCount;

-- Get Average Salary in IT Department
CALL GetAvgSalaryByDepartment('IT', @avgSalary);
SELECT @avgSalary;