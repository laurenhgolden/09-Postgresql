-- Drop table if exists Departments
-- Drop table if exists Dept_Emp
-- Drop table if exists Dept_Manager
-- Drop table if exists Employees
-- Drop table if exists Salaries
-- Drop table if exits Titles 

CREATE TABLE Departments (
    dept_no VARCHAR(30)   NOT NULL,
    dept_name VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE Dept_Emp (
    emp_no INTEGER   NOT NULL,
    dept_no VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_Dept_Emp PRIMARY KEY (
        emp_no,dept_no
     )
);

CREATE TABLE Dept_Manager (
    dept_no VARCHAR(30)   NOT NULL,
    emp_no INTEGER   NOT NULL,
    CONSTRAINT pk_Dept_Manager PRIMARY KEY (
        dept_no,emp_no
     )
);

CREATE TABLE Employees (
    emp_no INTEGER   NOT NULL,
    emp_title_id VARCHAR(30)   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR(30)   NOT NULL,
    last_name VARCHAR(30)   NOT NULL,
    sex VARCHAR(30)   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Salaries (
    emp_no INTEGER   NOT NULL,
    salary INTEGER   NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Titles (
    title_id VARCHAR(30)   NOT NULL,
    title VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (
        title_id
     )
);

ALTER TABLE Dept_Emp ADD CONSTRAINT fk_Dept_Emp_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Dept_Emp ADD CONSTRAINT fk_Dept_Emp_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_Manager ADD CONSTRAINT fk_Dept_Manager_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_Manager ADD CONSTRAINT fk_Dept_Manager_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Employees ADD CONSTRAINT fk_Employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES Titles (title_id);

--Import csv files from starter code
--Data Analysis
--Employee information
Select e.emp_no, e.first_name, e.last_name, e.sex, s.salary
from Employees e
Join Salaries s
ON (e.emp_no = s.emp_no);

--Query for employees hired in 1986
Select first_name, last_name, hire_date
From Employees
Where hire_date BETWEEN '1986-01-01' AND '1986-12-31'
Order by "hire_date";

--Manager Information
Select e.emp_no, e.first_name, e.last_name, m.dept_no, d.dept_name
From Employees e
Inner join Dept_Manager m on e.emp_no = m.emp_no
Inner join Departments d on m.dept_no = d.dept_no;

--Department Information
Select e.emp_no, e.first_name, e.last_name, x.dept_no, d.dept_name
From Employees e
Inner join Dept_Emp x on e.emp_no = x.emp_no
Inner join Departments d on x.dept_no = d.dept_no;

--Query for Hercules
Select first_name, last_name, sex
From Employees
Where first_name = 'Hercules' AND last_name LIKE 'B%';

--Sales Employee Dept. Information
Select emp_no, first_name, Last_name
From Employees
Where emp_no IN
(
	Select emp_no
	From Dept_Emp
	Where dept_no IN
	(
		Select dept_no
		From Departments
		Where dept_name = 'Sales'
	)
);

--Sales and Development Department information
Select e.emp_no, e.first_name, e.last_name, d.dept_name
From Employees e
Inner join Dept_Emp x on e.emp_no = x.emp_no
Inner join Departments d on x.dept_no = d.dept_no
Where dept_name = 'Sales' OR dept_name = 'Development'

--Frequency Counts of all employees last names
Select last_name, COUNT(*) as "Last_Name_Frequency"
From Employees
Group by last_name
Order by "Last_Name_Frequency" DESC;