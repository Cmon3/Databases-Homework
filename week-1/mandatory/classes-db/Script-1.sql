drop table if EXISTS classes_attendance;
DROP TABLE IF EXISTS mentors;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS classes;


create table mentors (
	id 						SERIAL primary key,
	name 					VARCHAR(30) NOT null,
	years_in_glasgow 		INT,
	address 				VARCHAR(120) NOT NULL,
	programming_language 	VARCHAR(30)
); 

create table students (
	id 						SERIAL primary key,
	name 					VARCHAR(30) NOT null,
	address 				VARCHAR(120) NOT NULL,
	gratuated 				BOOLEAN
); 

create table classes (
	id 					SERIAL primary key,
	leading_mentor 		VARCHAR(30) NOT null,
	topic 				VARCHAR(30) NOT null,
	class_date 			DATE,
	class_location 		VARCHAR(120)
);

create table classes_attendance (
	id 					SERIAL primary key,
	class_id 			INT references classes(id),
	students_id 		INT REFERENCES students(id)
);

insert into mentors (name, years_in_glasgow, address, programming_language) values ('John Doe',4,'11 New Road','C++');
insert into mentors (name, years_in_glasgow, address, programming_language) values ('Mimi Lazo',1,'9 Pempbroke street','Python');
insert into mentors (name, years_in_glasgow, address, programming_language) values ('El Negro',10,'1 Other Road','SQL');
insert into mentors (name, years_in_glasgow, address, programming_language) values ('Pepe',12,'8 Rathfarmham street','Java');
insert into mentors (name, years_in_glasgow, address, programming_language) values ('Hello',3,'2 set floor road','Javascript');

insert into students (name, address, gratuated) values ('John Doe','11 New Road',true);
insert into students (name, address, gratuated) values ('Mimi Lazo','9 Pempbroke street',false);
insert into students (name, address, gratuated) values ('El Negro','1 Other Road',false);
insert into students (name, address, gratuated) values ('Pepe','8 Rathfarmham street',true);
insert into students (name, address, gratuated) values ('Hello','2 set floor road',false);
insert into students (name, address, gratuated) values ('John The Second','11 New Road',true);
insert into students (name, address, gratuated) values ('Perolito','9 Pempbroke street',true);
insert into students (name, address, gratuated) values ('Gandalf','1 Other Road',false);
insert into students (name, address, gratuated) values ('Jaramillo','8 Rathfarmham street',false);
insert into students (name, address, gratuated) values ('Julio P','2 set floor road',false);
insert into students (name, address, gratuated) values ('Mathew Van der Poel','8 Rathfarmham street',true);
insert into students (name, address, gratuated) values ('Peter Sagan','2 set floor road',true);

insert into classes (leading_mentor, topic, class_date, class_location) values ('Mr Bean','Maths','2019-10-01','Russia');
insert into classes (leading_mentor, topic, class_date, class_location) values ('Mr John','Java','2019-10-01','Spain');
insert into classes (leading_mentor, topic, class_date, class_location) values ('Mr Mina','MongolDB','2019-10-01','England');


select * from mentors;
select * from students;

select * from mentors where years_in_glasgow > 5;
select * from mentors where programming_language = 'Javascript';
select * from students where gratuated = True;
select * from classes where class_date < '2021/06/01';
select students_id from classes_attendance where class_id = 1;







