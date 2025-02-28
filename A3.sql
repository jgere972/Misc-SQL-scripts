--Course 2521-001
--Assignment 3
--By Joseph G.

--Drop tables
DROP TABLE Branch_city;
DROP TABLE Branch_Manager;
DROP TABLE Branch;


--Table Creation

--Branch
CREATE TABLE Branch (
branchName varchar(30) PRIMARY KEY,
assets VARCHAR(20) UNIQUE
) ENGINE = InnoDB;

--Branch_Manager
CREATE TABLE Branch_Manager(
branchName varchar(30),
empNbr INT,
mgrStartDate DATE,
PRIMARY KEY(branchName, empNbr),
FOREIGN KEY(branchName) REFERENCES Branch(branchName)
) ENGINE = InnoDB;

--Branch_city
CREATE TABLE Branch_city(
branchName varchar(30),
branchCity varchar(10) NOT NULL UNIQUE,
nbrOfBranCityWide INT,
PRIMARY KEY(branchName, branchCity),
FOREIGN KEY(branchName) REFERENCES Branch(branchName)
) ENGINE = InnoDB;

--Insert Records
INSERT INTO Branch
VALUES('DataBranch','data_servers'),
('SystemBranch','bonds');

INSERT INTO Branch_Manager
VALUES('DataBranch', 2, NULL),
('SystemBranch', 4, '2023-01-01');

INSERT INTO Branch_city
VALUES ('DataBranch', 'Calgary', 2),
('SystemBranch', 'Edmonton', 1);

