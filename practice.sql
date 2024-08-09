-- Create a new database
CREATE DATABASE company_db;

-- Use the new database
USE company_db;

-- Create tables with keys and constraints
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL,
    department_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert data into tables
INSERT INTO departments (name) VALUES ('Developer');
INSERT INTO departments (name) VALUES ('Accountant');
INSERT INTO departments (name) VALUES ('Engineering');

INSERT INTO employees (first_name, last_name, email, hire_date, department_id) VALUES ('Rahel', 'Abera', 'rabera131@gmail.com', '2015-05-07', 1);
INSERT INTO employees (first_name, last_name, email, hire_date, department_id) VALUES ('Tigest', 'Tsige', 'Tsige@gmail.com', '2015-07-14', 2);


-- Basic queries
SELECT * FROM employees;
SELECT * FROM departments;

-- More basic queries
SELECT first_name, last_name FROM employees WHERE department_id = 2;
SELECT COUNT(*) AS employee_count FROM employees;

-- Functions
SELECT UPPER(first_name) AS first_name_upper FROM employees;
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;

-- Wildcards
SELECT * FROM employees WHERE email LIKE '%@gmail.com';

-- Union
SELECT first_name, last_name FROM employees WHERE department_id = 1
UNION
SELECT first_name, last_name FROM employees WHERE department_id = 2;

-- Joins
SELECT employees.first_name, employees.last_name, departments.name AS department
FROM employees
JOIN departments ON employees.department_id = departments.id;

-- Nested queries
SELECT first_name, last_name FROM employees
WHERE department_id = (SELECT id FROM departments WHERE name = 'Engineering');

-- Update data
UPDATE employees SET email = 'Tsige@gmail.com'' WHERE id = 1;

-- Delete data
DELETE FROM employees WHERE id = 1;

-- On delete cascade
ALTER TABLE employees ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES departments(id)
ON DELETE CASCADE;

-- Triggers
DELIMITER //
CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid email format';
    END IF;
END;
//
DELIMITER ;

-- Insert data to test trigger
INSERT INTO employees (first_name, last_name, email, hire_date, department_id) VALUES ('Hewan', 'Abebe', 'Hewan.Abebe@gmail.com', '2015-09-30', 3);
