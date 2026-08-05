-- company_postgresql.sql
DROP SCHEMA IF EXISTS company CASCADE;
CREATE SCHEMA company;
SET search_path TO company;

-- ==========================
-- TABELAS
-- ==========================

CREATE TABLE employee (
    Fname       VARCHAR(15) NOT NULL,
    Minit       CHAR(1),
    Lname       VARCHAR(15) NOT NULL,
    Ssn         BIGINT PRIMARY KEY,
    Bdate       DATE,
    Address     VARCHAR(50),
    Sex         CHAR(1) CHECK (Sex IN ('M','F')),
    Salary      NUMERIC(10,2),
    Super_ssn   BIGINT,
    Dno         INTEGER
);

CREATE TABLE departament (
    Dname             VARCHAR(25) NOT NULL,
    Dnumber           INTEGER PRIMARY KEY,
    Mgr_ssn           BIGINT,
    Mgr_start_date    DATE,
    Dept_create_date  DATE
);

CREATE TABLE dept_locations (
    Dnumber     INTEGER NOT NULL,
    Dlocation   VARCHAR(25) NOT NULL,
    PRIMARY KEY (Dnumber, Dlocation)
);

CREATE TABLE project (
    Pname       VARCHAR(25) NOT NULL,
    Pnumber     INTEGER PRIMARY KEY,
    Plocation   VARCHAR(25),
    Dnum        INTEGER
);

CREATE TABLE works_on (
    Essn        BIGINT NOT NULL,
    Pno         INTEGER NOT NULL,
    Hours       NUMERIC(4,1),
    PRIMARY KEY (Essn, Pno)
);

CREATE TABLE dependent (
    Essn             BIGINT NOT NULL,
    Dependent_name   VARCHAR(15) NOT NULL,
    Sex              CHAR(1) CHECK (Sex IN ('M','F')),
    Bdate            DATE,
    Relationship     VARCHAR(15),
    PRIMARY KEY (Essn, Dependent_name)
);

-- ==========================
-- INSERTS
INSERT INTO employee ...
INSERT INTO dependent ...
INSERT INTO departament ...
INSERT INTO dept_locations ...
INSERT INTO project ...
INSERT INTO works_on ...
-- ==========================

-- ==========================
-- CHAVES ESTRANGEIRAS
-- Execute após todos os INSERTs
-- ==========================

ALTER TABLE employee
ADD CONSTRAINT fk_employee_supervisor
FOREIGN KEY (Super_ssn)
REFERENCES employee(Ssn)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE employee
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (Dno)
REFERENCES departament(Dnumber)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE departament
ADD CONSTRAINT fk_department_manager
FOREIGN KEY (Mgr_ssn)
REFERENCES employee(Ssn)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE dept_locations
ADD CONSTRAINT fk_department_location
FOREIGN KEY (Dnumber)
REFERENCES departament(Dnumber)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE project
ADD CONSTRAINT fk_project_department
FOREIGN KEY (Dnum)
REFERENCES departament(Dnumber)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE works_on
ADD CONSTRAINT fk_works_employee
FOREIGN KEY (Essn)
REFERENCES employee(Ssn)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE works_on
ADD CONSTRAINT fk_works_project
FOREIGN KEY (Pno)
REFERENCES project(Pnumber)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE dependent
ADD CONSTRAINT fk_dependent_employee
FOREIGN KEY (Essn)
REFERENCES employee(Ssn)
DEFERRABLE INITIALLY DEFERRED;
