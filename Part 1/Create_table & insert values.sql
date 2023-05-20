#DROP TABLE prefet,house,registered_course, student, study, years;
#use projetbdd;
#Creation des tables Normalisé;
SHOW tables;
-- Creation des tables suivant le modéle de normalisation proposé 


CREATE TABLE house(
   ID_house INT,
   name_house VARCHAR(50),
   prefet VARCHAR(50),
   PRIMARY KEY(ID_house) #Clés primaire 
);
CREATE TABLE prefet (
  ID_house INT,
  prefet_name VARCHAR(50),
  FOREIGN KEY (ID_house) REFERENCES house(ID_house)
);

CREATE TABLE registered_course(
   ID_course INT,
   name_course VARCHAR(50),
   PRIMARY KEY(ID_course) #Clés primaire 
);

CREATE TABLE years(
   ID_year INT,
   student_year INT,
   PRIMARY KEY(ID_year) #Clés primaire 
);

CREATE TABLE student(
   ID_student INT,
   student_name VARCHAR(255),
   email VARCHAR(255),
   ID_house INT NOT NULL,
   ID_year INT NOT NULL,
   PRIMARY KEY(ID_student), #Clés primaire 
   UNIQUE(student_name),
   UNIQUE(email),
   FOREIGN KEY(ID_house) REFERENCES house(ID_house), #Clés étrangére
   FOREIGN KEY(ID_year) REFERENCES years(ID_year) #Clés étrangére
);

CREATE TABLE study(
   ID_student INT,
   ID_course INT,
   PRIMARY KEY(ID_student, ID_course), #Clés primaire 
   FOREIGN KEY(ID_student) REFERENCES student(ID_student), #Clés étrangére
   FOREIGN KEY(ID_course) REFERENCES registered_course(ID_course) #Clés étrangére
);


ALTER TABLE study DROP FOREIGN KEY study_ibfk_1;
ALTER TABLE student MODIFY ID_student INT AUTO_INCREMENT;
ALTER TABLE study ADD CONSTRAINT study_ibfk_1 FOREIGN KEY (ID_student) REFERENCES student(ID_student);

ALTER TABLE student DROP FOREIGN KEY student_ibfk_1;
ALTER TABLE house MODIFY ID_house INT AUTO_INCREMENT;
ALTER TABLE student ADD CONSTRAINT student_ibfk_1 FOREIGN KEY (ID_house) REFERENCES house(ID_house);


ALTER TABLE study DROP FOREIGN KEY study_ibfk_2;
ALTER TABLE registered_course MODIFY ID_course INT AUTO_INCREMENT;
ALTER TABLE study ADD CONSTRAINT study_ibfk_2 FOREIGN KEY (ID_course) REFERENCES registered_course(ID_course);


ALTER TABLE student DROP FOREIGN KEY student_ibfk_2;
ALTER TABLE years MODIFY ID_year INT AUTO_INCREMENT;
ALTER TABLE student ADD CONSTRAINT student_ibfk_2 FOREIGN KEY (ID_year) REFERENCES years(ID_year);

#Remplir les tables:
INSERT INTO house (ID_house, name_house)
SELECT DISTINCT NULL, house
FROM project;

INSERT INTO registered_course (ID_course, name_course)
SELECT DISTINCT NULL, registered_course
FROM project;

INSERT INTO years (ID_year, student_year)
SELECT DISTINCT NULL, year
FROM project;


INSERT INTO student (ID_student, student_name, email, ID_house, ID_year)
SELECT DISTINCT NULL, student_name, email, house.ID_house, years.ID_year
FROM project
INNER JOIN house ON project.house = house.name_house
INNER JOIN years ON project.year = years.student_year;


INSERT INTO study (ID_student, ID_course)
SELECT DISTINCT student.ID_student, registered_course.ID_course
FROM project
INNER JOIN student ON project.email = student.email
INNER JOIN registered_course ON project.registered_course = registered_course.name_course;



select distinct * from student

