DROP TABLE project_consultant;
DROP TABLE project;
DROP TABLE consultant;

CREATE TABLE consultant ( 
c_id INT PRIMARY KEY AUTO_INCREMENT,		--Column level primary key declration
c_last VARCHAR(20) NOT NULL,
c_first VARCHAR(20) NOT NULL,
c_dob date NOT NULL,
c_email VARCHAR(30) UNIQUE
) ENGINE = InnoDB;

CREATE TABLE project (
p_id INT PRIMARY KEY AUTO_INCREMENT,		--Column level primary key declration
p_desc VARCHAR(30) NOT NULL UNIQUE,
parent_p_id INT,
mgr_id INT,
FOREIGN KEY (mgr_id) REFERENCES consultant(c_id)
) ENGINE = InnoDB;

CREATE TABLE project_consultant (
p_id INT,
c_id INT,
roll_on_date DATE,
roll_off_date DATE,
PRIMARY KEY (p_id, c_id)		--Table level primary key declaration
FOREIGN KEY (p_id) REFERENCES project(p_id)
FOREIGN KEY (c_id) REFERENCES consultant(c_id)
) ENGINE = InnoDB;


