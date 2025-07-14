CREATE TABLE campus (
  campus_id text CONSTRAINT campus_pkey PRIMARY KEY, 
  campus_name text
);

INSERT INTO public.campus (campus_id, campus_name) VALUES ('101', 'Bengaluru');
INSERT INTO public.campus (campus_id, campus_name) VALUES ('102', 'Hyderabad');
INSERT INTO public.campus (campus_id, campus_name) VALUES ('103', 'Visakhapatnam');
INSERT INTO public.campus (campus_id, campus_name) VALUES ('104', 'GIMSR');

CREATE TABLE school (
  school_id text CONSTRAINT school_pkey PRIMARY KEY, 
  school_short_name text,
  school_full_name text,
  parent_campus_id text,
  CONSTRAINT school_parent_campus_id_fkey FOREIGN KEY (parent_campus_id) REFERENCES campus(campus_id)  
);

INSERT INTO public.school (school_id, school_short_name, school_full_name, parent_campus_id) 
       VALUES ('201', 'GST', 'GITAM School of Technology', '101');
INSERT INTO public.school (school_id, school_short_name, school_full_name,parent_campus_id) 
       VALUES ('202', 'GSB', 'GITAM School of Business', '101');
INSERT INTO public.school (school_id, school_short_name,school_full_name,parent_campus_id) 
       VALUES ('203', 'GSS', 'GITAM School of Science', '101');
INSERT INTO public.school (school_id, school_short_name, school_full_name, parent_campus_id) 
       VALUES ('204', 'GSHS', 'GITAM School of Humanities and Social Sciences ', '101');
              
              
CREATE TABLE department (
  department_id text CONSTRAINT department_pkey PRIMARY KEY, 
  department_short_name text, 
  department_full_name text, 
  parent_school_id text, 
  CONSTRAINT department_parent_school_id_fkey FOREIGN KEY (parent_school_id) REFERENCES school(school_id)
);

INSERT INTO public.department (department_id, department_short_name, department_full_name, parent_school_id) VALUES('301', 'CSE', 'Computer Science and Engineering', '201');
INSERT INTO public.department (department_id, department_short_name, department_full_name, parent_school_id) VALUES('302', 'AI&DS', 'Artificial Intelligence & Data Science', '201');
INSERT INTO public.department (department_id, department_short_name, department_full_name, parent_school_id) VALUES('303', 'EECE', 'Electrical, Electronics  & Communication Engineering', '201');
INSERT INTO public.department (department_id, department_short_name, department_full_name, parent_school_id) VALUES('304', 'Mech', 'Mechanical Engineering', '201');
INSERT INTO public.department (department_id, department_short_name, department_full_name, parent_school_id) VALUES('305', 'Civil', 'Civil Engineering', '201');

CREATE TYPE course_category_type  AS ENUM ('UC', 'FC', 'PC', 'PE', 'OE');
CREATE TYPE role_type AS ENUM ('Admin','Faculty', 'CAIA');
CREATE TYPE purpose_type AS ENUM ('Teaching Now', 'Future Teaching', 'Self Upskill');
CREATE TYPE designation_type AS ENUM ('Assistant Professor', 'Associate Professor', 'Professor');
CREATE TYPE skill_type AS ENUM ('Preskill', 'Tech/Core', 'Tool', 'Applied', 'Project');
CREATE TYPE familiarity_type AS ENUM ('Yes', 'No', 'NA');

CREATE TABLE employee (
  employee_id text CONSTRAINT employee_pkey PRIMARY KEY, 
  employee_mail text UNIQUE, 
  employee_name text, 
  designation designation_type, 
  joining_date text, 
  department_id text, 
  password text, 
  role role_type, 
  CONSTRAINT employee_department_mapping_id_fkey FOREIGN KEY (department_id) REFERENCES department(department_id) 
);

INSERT INTO public.employee (employee_id, employee_mail, employee_name, designation, joining_date, department_id, password) VALUES 'Teaching Now'('700913', 'sedappil@gitam.edu', 'Salmon Joy', 'Assistant Professor', '2024-07-22', '301', '$2b$10$vc.WV8XNU4l0vZ7JUi.DBOxRQyBcw8JAiqnh8L/gmVFzc1suydRNK');

INSERT INTO public.employee (employee_id, employee_mail, employee_name, designation, joining_date, department_id, password) VALUES ('700912', 'sagarwal@gitam.edu', 'Shirsh Agrawal', 'Assistant Professor', '2024-07-15', '301', '$2b$10$vc.WV8XNU4l0vZ7JUi.DBOxRQyBcw8JAiqnh8L/gmVFzc1suydRNK');

INSERT INTO public.employee (employee_id, employee_mail, employee_name, designation, joining_date, department_id, password) VALUES ('700914', 'achavan@gitam.edu', 'Amit Chavan', 'Assistant Professor', '2024-078-10', '301', '$2b$10$vc.WV8XNU4l0vZ7JUi.DBOxRQyBcw8JAiqnh8L/gmVFzc1suydRNK');

CREATE TABLE course (
  course_id text CONSTRAINT course_pkey PRIMARY KEY, 
  course_name text, 
  course_category  course_category_type, 
  offered_department_id text, 
  course_coordinator_id text, 
  course_champion_id text, 
  caia_coordinator_id text, 
  CONSTRAINT course_parent_department_id_fkey FOREIGN KEY (offered_department_id) REFERENCES department(department_id), 
  CONSTRAINT course_coordinator_fkey FOREIGN KEY (course_coordinator_id) REFERENCES employee(employee_id), 
  CONSTRAINT course_champion_fkey FOREIGN KEY (course_champion_id) REFERENCES employee(employee_id), 
  CONSTRAINT course_caia_coordinator_fkey FOREIGN KEY (caia_coordinator_id) REFERENCES employee(employee_id)
);

INSERT INTO public.course(course_id, course_name, course_category, offered_department_id, course_coordinator_id, course_champion_id, caia_coordinator_id) VALUES('CSEN1011', 'Problem Solving', 'FC', '301', '700913', '700913', '700913'); 
INSERT INTO public.course(course_id, course_name, course_category, offered_department_id, course_coordinator_id, course_champion_id, caia_coordinator_id) VALUES('CSEN1012', 'OOPS with Java', 'PC', '301', '700912', '700912', '700912'); 

CREATE TABLE course_faculty_mapping (
  mapping_id text CONSTRAINT course_faculty_mapping_pkey PRIMARY KEY, 
  course_id text, 
  employee_id text, 
  purpose  purpose_type, 
  CONSTRAINT course_faculty_mapping_course_id_fkey FOREIGN KEY (course_id) REFERENCES course(course_id), 
  CONSTRAINT course_faculty_mapping_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

INSERT INTO public.course_faculty_mapping(id,course_id, employee_id, purpose ) VALUES('101','CSEN1011', '700913', 'Teaching Now'); 
INSERT INTO public.course_faculty_mapping(id,course_id, employee_id, purpose ) VALUES('102','CSEN1012', '700913', 'Future Teaching'); 

CREATE TABLE skill (
  skill_id text CONSTRAINT skill_pkey PRIMARY KEY, 
  skill_name text, skill_description text
);

CREATE TABLE subskill (
  subskill_id text CONSTRAINT subskill_pkey PRIMARY KEY, 
  subskill_name text, 
  subskill_description text, 
  skill_id text, 
  required BOOLEAN, 
  CONSTRAINT subskill_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES skill(skill_id)
);

CREATE TABLE course_skill_mapping (
  mapping_id INTEGER GENERATED ALWAYS AS IDENTITY CONSTRAINT course_skill_mapping_pkey PRIMARY KEY, 
  skill_id text, 
  course_id text, 
  type skill_type, 
  CONSTRAINT course_skill_mapping_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES skill(skill_id), 
  CONSTRAINT course_skill_mapping_course_id_fkey FOREIGN KEY (course_id) REFERENCES course(course_id), 
 
);

CREATE TABLE familiarity_mapping (
  marking_id INTEGER GENERATED ALWAYS AS IDENTITY CONSTRAINT familiarity_pkey PRIMARY KEY, 
  subskill_id text, 
  employee_id text, 
  familiarity BOOLEAN, 
  date_time timestamp without time zone, 
  erased BOOLEAN, 
  CONSTRAINT rating_subskill_id_fkey FOREIGN KEY (subskill_id) REFERENCES subskill(subskill_id), 
  CONSTRAINT rating_mapping_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE VIEW course_subskills AS SELECT c.course_id, csm.skill_type,s.skill_id, ss.subskill_id FROM course_faculty_mapping cfm
   INNER JOIN course c ON cfm.course_id = c.course_id
   INNER JOIN course_skill_mapping csm ON csm.course_id = c.course_id
   INNER JOIN skill s ON s.skill_id = csm.skill_id 
   INNER JOIN subskill ss ON ss.skill_id = s.skill_id;
   
CREATE VIEW faculty_course_skill_familiarity AS SELECT e.employee_id, c.course_id, csm.skill_type,s.skill_id, ss.subskill_id, f.familiarity  FROM course_faculty_mapping cfm
   INNER JOIN employee e ON cfm.employee_id = e.employee_id
   INNER JOIN course c ON cfm.course_id = c.course_id
   INNER JOIN course_skill_mapping csm ON csm.course_id = c.course_id
   INNER JOIN skill s ON s.skill_id = csm.skill_id 
   INNER JOIN subskill ss ON ss.skill_id = s.skill_id        
   LEFT JOIN familiarity_marking f ON f.subskill_id = ss.subskill_id;
   
select pg_get_viewdef('course_subskills', true);
select pg_get_viewdef('faculty_course_skill_familiarity', true);

   
# Analytics
SELECT count(subskill_id) FROM faculty_course_skill_familiarity WHERE employee_id='700499' AND course_id='CSEN1111' AND skill_type='Project';

SELECT count(subskill_id) FROM faculty_course_skill_familiarity WHERE employee_id='700499' AND course_id='CSEN1111' AND skill_type='Project' AND familiarity='Yes';





  




