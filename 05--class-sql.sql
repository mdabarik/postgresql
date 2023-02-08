
CREATE DATABASE university;
--DROP DATABASE university; -- dropping schema

CREATE SCHEMA bsmrstu;
--DROP SCHEMA bsmrstu; -- dropping  schema

--drop table if exists bsmrstu.students
--create table in schema bsmrstu
CREATE TABLE bsmrstu.students (
	id SERIAL NOT NULL
	,name VARCHAR NOT NULL
	,email VARCHAR NULL
	,phone VARCHAR NULL
	,gender VARCHAR NULL
	,religion VARCHAR NULL
	,bg_group VARCHAR NULL
	,bio TEXT NULL
	,dob DATE NULL
	,dept VARCHAR NOT NULL
-- 	,PRIMARY KEY(id)
	,constraint pk_id primary key(id)
);

--DROP TABLE bsmrstu.students

INSERT INTO "bsmrstu"."students" ("name", "email", "phone", "gender", "religion", "bg_group", "bio", "dob", "dept") VALUES ('Md. Ataur', 'ataur@gmail.com', '01700000000', 'male', 'islam', 'b+', 'bsc student', '1997-02-04', 'Statistics');

INSERT INTO "bsmrstu"."students" ("name", "email", "phone", "gender", "religion", "bg_group", "bio", "dob", "dept") VALUES ('Md. Monir', 'monir@gmail.com', '01705982823', 'male', 'islam', 'a+', 'statistics student', '1998-02-05', 'Statistics');
--for formated string, we must use double quote ("") && use single quote for string ('')

insert into bsmrstu.students (name, email, phone, gender, religion, bg_group, bio, dob, dept) values ('Md. Setu', 'setu@gmail.com', '01792830393', 'male', 'islam', 'b+', 'statistics student', '1997-02-01', 'Statistics');
--for all lowercase naming use just the name, not formatted string


---------------------------create new table profile---------------------
DROP TABLE IF EXISTS bsmrstu.profile;

CREATE TABLE bsmrstu.profile (
	id SERIAL PRIMARY KEY,
	url VARCHAR NOT NULL,
	name VARCHAR NOT NULL,
	description VARCHAR,
    last_update DATE,
    nid varchar,
    father_nid varchar,
    constraint pk_f_nid primary key (father_nid)
);

alter table bsmrstu.profile
	add constraint pk_nid
	primary key (nid);

--1. add a new column to profile table named 'email' & 'phone'
--2. drop column 'email' & 'phone' & 'description'
--3. create 'email' & 'phone' & 'description'
--4. rename 'phone' to 'phone_number' & 'email' to 'email_address'
--5. change data type of 'phone' to bigint
--6. set 'phone' not null

--1. add new col, 'email' & 'phone'
ALTER TABLE bsmrstu.profile
	ADD email varchar;
ALTER TABLE bsmrstu.profile
	ADD phone varchar;

--2. drop col 'email' & 'phone'
alter table bsmrstu.profile 
	drop column email;
alter table bsmrstu.profile
	drop column phone;
alter table bsmrstu.profile
	drop column description;

--3. create column 'email' & 'phone' & 'description'
alter table bsmrstu.profile
	add phone bigint;
alter table bsmrstu.profile
	add email varchar;
alter table bsmrstu.profile
	add description text;

--4. rename 'phone' to 'phone_number' & 'email' to 'email_address'
alter table bsmrstu.profile 
	rename column email to email_address;
alter table bsmrstu.profile
	rename column phone to phone_number;

--5. change data type of 'phone' to bigint & revert it
alter table bsmrstu.profile
	alter column phone_number type varchar,
	ALTER COLUMN description TYPE VARCHAR;

--6. set phone_number to 'not null'
alter table bsmrstu.profile 
	alter column phone_number set not null;


select * from bsmrstu.profile;
---------------------------------- end of profile table operation------------



---------------- du -- students & departments -- pk & fk ------------------
drop schema if exists du;
create schema du;

drop table if exists du.students;

create table du.students (
	id serial primary key,
	name varchar,
	email varchar,
	phone varchar,
	dept_id bigint
	--constraint fk_std_id foreign key (dept_id) references du.departments(id)
);

alter table du.students
	add foreign key (dept_id) references du.departments(id);

alter table du.students
	add constraint fk_dept_id
	foreign key (dept_id) references du.departments(id);

drop table if exists du.departments;

create table du.departments (
	id serial,
	dept_id bigint,
	dept_name varchar,
	details text,
	primary key(id)
)

select * from du.students;
--------------------- end of du students & departments pk & fk------------------





----------------------UNIQUE key----------------------
-- only 1 primary key is allowed per table,,
-- we can add multiple unique key which is similar to pk
-- unique key can be referenced using foreign key
-- unique key can be null but primary key can't be null

create schema ru;

drop table if exists ru.students;

create table ru.students (
	id serial primary key,
	name varchar,
	email varchar unique,
	phone varchar,
	father_nid varchar,
	mother_nid varchar,
	unique(phone),
	constraint uq_fnid unique (father_nid)
)

alter table ru.students
	add constraint uq_mnid
	unique (mother_nid);
	
alter table ru.students
	add unique(mother_nid);

alter table ru.students
	drop constraint uq_mnid;


----------------------Composite key----------------------
create schema my_university;

CREATE TABLE my_university.students (
    std_id int NOT NULL,
    course_id varchar NOT NULL,
    quarter_id varchar,
    grade varchar,
    CONSTRAINT pk_std PRIMARY KEY (std_id, course_id, quarter_id) -- composite key
);



