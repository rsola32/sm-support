CREATE TABLE campus (
  campus_id text CONSTRAINT campus_pkey PRIMARY KEY, 
  campus_name text
);

CREATE TABLE school (
  school_id text CONSTRAINT school_pkey PRIMARY KEY, 
  school_short_name text,
  school_full_name text,
  parent_campus_id text,
  CONSTRAINT school_parent_campus_id_fkey FOREIGN KEY (parent_campus_id) REFERENCES campus(campus_id)  
);
       
CREATE TABLE department (
  department_id text CONSTRAINT department_pkey PRIMARY KEY, 
  department_short_name text, 
  department_full_name text, 
  parent_school_id text, 
  CONSTRAINT department_parent_school_id_fkey FOREIGN KEY (parent_school_id) REFERENCES school(school_id)
);

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

CREATE TABLE course_faculty_mapping (
  mapping_id text CONSTRAINT course_faculty_mapping_pkey PRIMARY KEY, 
  course_id text, 
  employee_id text, 
  purpose  purpose_type, 
  CONSTRAINT course_faculty_mapping_course_id_fkey FOREIGN KEY (course_id) REFERENCES course(course_id), 
  CONSTRAINT course_faculty_mapping_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

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
  CONSTRAINT course_skill_mapping_course_id_fkey FOREIGN KEY (course_id) REFERENCES course(course_id) 
 
);

CREATE TABLE familiarity_mapping (
  marking_id INTEGER GENERATED ALWAYS AS IDENTITY CONSTRAINT familiarity_pkey PRIMARY KEY, 
  subskill_id text, 
  employee_id text, 
  familiarity familiarity_type, 
  mtime timestamp without time zone, 
  erased BOOLEAN, 
  CONSTRAINT rating_subskill_id_fkey FOREIGN KEY (subskill_id) REFERENCES subskill(subskill_id), 
  CONSTRAINT rating_mapping_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);



  




