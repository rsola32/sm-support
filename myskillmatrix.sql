--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: course_category_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.course_category_type AS ENUM (
    'UC',
    'FC',
    'PC',
    'PE',
    'OE'
);


ALTER TYPE public.course_category_type OWNER TO postgres;

--
-- Name: designation_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.designation_type AS ENUM (
    'Assistant Professor',
    'Associate Professor',
    'Professor',
    'Professor+HOD',
    'Professor of Practice',
    'Technology Expert'
);


ALTER TYPE public.designation_type OWNER TO postgres;

--
-- Name: familiarity_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.familiarity_type AS ENUM (
    'Yes',
    'No',
    'NA',
    'false',
    'true'
);


ALTER TYPE public.familiarity_type OWNER TO postgres;

--
-- Name: purpose_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.purpose_type AS ENUM (
    'Teaching Now',
    'Future Teaching',
    'Self Upskill'
);


ALTER TYPE public.purpose_type OWNER TO postgres;

--
-- Name: role_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.role_type AS ENUM (
    'Admin',
    'Faculty',
    'CAIA'
);


ALTER TYPE public.role_type OWNER TO postgres;

--
-- Name: skill_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.skill_type AS ENUM (
    'Preskill',
    'Tech/Core',
    'Tool',
    'Applied',
    'Project'
);


ALTER TYPE public.skill_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: campus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campus (
    campus_id text NOT NULL,
    campus_name text
);


ALTER TABLE public.campus OWNER TO postgres;

--
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    course_id text NOT NULL,
    course_name text,
    course_category public.course_category_type,
    offered_department_id text,
    course_coordinator_id text,
    course_champion_id text,
    caia_coordinator_id text
);


ALTER TABLE public.course OWNER TO postgres;

--
-- Name: course_faculty_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_faculty_mapping (
    course_id text,
    employee_id text,
    purpose public.purpose_type,
    mapping_id integer NOT NULL
);


ALTER TABLE public.course_faculty_mapping OWNER TO postgres;

--
-- Name: course_faculty_mapping_mapping_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.course_faculty_mapping ALTER COLUMN mapping_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.course_faculty_mapping_mapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: course_skill_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_skill_mapping (
    skill_id text,
    course_id text,
    skill_type public.skill_type,
    mapping_id integer NOT NULL
);


ALTER TABLE public.course_skill_mapping OWNER TO postgres;

--
-- Name: course_skill_mapping_mapping_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.course_skill_mapping ALTER COLUMN mapping_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.course_skill_mapping_mapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    department_id text NOT NULL,
    department_short_name text,
    department_full_name text,
    parent_school_id text
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    employee_id text NOT NULL,
    employee_mail text,
    employee_name text,
    designation public.designation_type,
    doj date,
    department_id text,
    password text,
    role public.role_type
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: familiarity_marking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.familiarity_marking (
    subskill_id text,
    employee_id text,
    mtime timestamp without time zone,
    erased boolean,
    marking_id integer NOT NULL,
    familiarity public.familiarity_type
);


ALTER TABLE public.familiarity_marking OWNER TO postgres;

--
-- Name: familiarity_marking_marking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.familiarity_marking ALTER COLUMN marking_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.familiarity_marking_marking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: school; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.school (
    school_id text NOT NULL,
    school_short_name text,
    school_full_name text,
    parent_campus_id text
);


ALTER TABLE public.school OWNER TO postgres;

--
-- Name: skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skill (
    skill_id text NOT NULL,
    skill_name text,
    skill_description text
);


ALTER TABLE public.skill OWNER TO postgres;

--
-- Name: subskill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subskill (
    subskill_id text NOT NULL,
    subskill_name text,
    subskill_description text,
    skill_id text,
    required boolean
);


ALTER TABLE public.subskill OWNER TO postgres;

--
-- Data for Name: campus; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.campus VALUES ('101', 'Bengaluru');
INSERT INTO public.campus VALUES ('102', 'Hyderabad');
INSERT INTO public.campus VALUES ('103', 'Visakhapatnam');
INSERT INTO public.campus VALUES ('104', 'GIMSR');


--
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.course VALUES ('24CSEN1031', 'Programming for Problem Solving - 1', 'FC', '301', '700614', '700614', '700912');
INSERT INTO public.course VALUES ('MATH2561 	
', 'Probability and Statistics for Engineers', 'FC', '301', '700594', '700594', '700912');
INSERT INTO public.course VALUES ('24CSEN2001', 'Data Structures', 'PC', '301', '700710', '700710', '700912');
INSERT INTO public.course VALUES ('24CSEN2021	
', 'Computer Organization and Architecture', 'PC', '301', '700515', '700515', '700912');
INSERT INTO public.course VALUES ('24CSEN1011
', 'Object-oriented Programming', 'PC', '301', '700071', '700071', '700912');
INSERT INTO public.course VALUES ('CSEN3001', 'Design and Analysis of Algorithms', 'PC', '301', '700062', '700062', '700912');
INSERT INTO public.course VALUES ('CSEN2021', 'Computer Organization and Architecture', 'PC', '301', '700267', '700267', '700912');
INSERT INTO public.course VALUES ('24CSEN1051', 'Intermediate coding', 'OE', '301', '700516', '700516', '700912');
INSERT INTO public.course VALUES ('MECH1001', 'Design Thinking', 'OE', '301', '700681', '700681', '700912');
INSERT INTO public.course VALUES ('CSEN1031', 'Artificial Intelligence and Applications', 'PC', '301', '700592', '700592', '700912');
INSERT INTO public.course VALUES ('CSEN2041', 'Formal Languages and Automata Theory', 'PC', '301', '700651', '700651', '700912');
INSERT INTO public.course VALUES ('CSEN2061', 'Database Management Systems', 'PC', '301', '700581', '700581', '700912');
INSERT INTO public.course VALUES ('CSEN3061', 'Automata Theory and Compiler Design', 'PC', '301', '700627', '700627', '700912');
INSERT INTO public.course VALUES ('FINA1031', 'Principles and Practice of Banking', 'PC', '301', '700590', '700590', '700912');
INSERT INTO public.course VALUES ('HRMG1021', 'Human Resource Management', 'PC', '301', '700444', '700444', '700912');
INSERT INTO public.course VALUES ('MKTG3011', 'Sales and Distribution Management', 'PE', '301', '700389', '700389', '700912');
INSERT INTO public.course VALUES ('24CSEN2381', 'Advanced Coding-II', 'PE', '301', '700350', '700350', '700912');
INSERT INTO public.course VALUES ('CSEN3051', 'Wireless Sensor Networks', 'PE', '301', '501255', '501255', '700912');
INSERT INTO public.course VALUES ('CSEN3301', 'Software Requirements Management', 'PE', '301', '700646', '700646', '700912');
INSERT INTO public.course VALUES ('CSEN3321', 'Threat Intelligence', 'PE', '301', '30021', '30021', '700912');
INSERT INTO public.course VALUES ('CSEN4041', 'Cloud Security', 'PE', '301', '700054', '700054', '700912');
INSERT INTO public.course VALUES ('CSEN4141', 'Natural Language Processing', 'PE', '301', '30026', '30026', '700912');
INSERT INTO public.course VALUES ('CSEN2091', 'OOSE based Application Development', 'PE', '301', '30020', '30020', '700912');
INSERT INTO public.course VALUES ('CSEN4011', 'Cloud Based IoT', 'PE', '301', '700567', '700567', '700912');
INSERT INTO public.course VALUES ('24MECH3311', 'Industry 4.0', 'OE', '301', '93361', '93361', '700912');
INSERT INTO public.course VALUES ('CSEN2121', 'Cloud Computing ', 'OE', '301', '700563', '700563', '700912');
INSERT INTO public.course VALUES ('CSEN2171', 'IoT Hardware', 'OE', '301', '700578', '700578', '700912');
INSERT INTO public.course VALUES ('CSEN3341', 'Programming Languages', 'PE', '301', '700901', '700901', '700912');
INSERT INTO public.course VALUES ('CSEN1131', 'Software Engineering', 'PC', '301', '700638', '700638', '700912');
INSERT INTO public.course VALUES ('CSEN1151', 'Fundamentals of E-Commerce', 'OE', '301', '700499', '700499', '700912');
INSERT INTO public.course VALUES ('CSEN3121', 'Adhoc and Sensor Networks', 'PC', '301', '700061', '700061', '700912');
INSERT INTO public.course VALUES ('CSEN3141', 'Advanced Computer Networks', 'PC', '301', '700266', '700266', '700912');
INSERT INTO public.course VALUES ('CSEN3151', 'Advanced Data Structures', 'PC', '301', '700792', '700792', '700912');
INSERT INTO public.course VALUES ('CSEN3161', 'Advanced Operating Systems', 'PC', '301', '700881', '700881', '700912');
INSERT INTO public.course VALUES ('CSEN3231', 'Image Processing', 'PC', '301', '700056', '700056', '700912');
INSERT INTO public.course VALUES ('24CSEN3231', 'Environmental Data Science', 'OE', '301', '700701', '700701', '700912');
INSERT INTO public.course VALUES ('CSEN3071', 'Web Application Development and Software Framework', 'PC', '301', '700777', '700777', '700912');


--
-- Data for Name: course_faculty_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.course_faculty_mapping OVERRIDING SYSTEM VALUE VALUES ('CSEN2171', '700614', 'Teaching Now', 2);
INSERT INTO public.course_faculty_mapping OVERRIDING SYSTEM VALUE VALUES ('CSEN1031', '700701', 'Teaching Now', 3);
INSERT INTO public.course_faculty_mapping OVERRIDING SYSTEM VALUE VALUES ('CSEN1031', '700614', 'Teaching Now', 4);
INSERT INTO public.course_faculty_mapping OVERRIDING SYSTEM VALUE VALUES ('CSEN2171', '700499', 'Teaching Now', 5);


--
-- Data for Name: course_skill_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.course_skill_mapping OVERRIDING SYSTEM VALUE VALUES ('S101', 'CSEN2171', 'Tech/Core', 1);
INSERT INTO public.course_skill_mapping OVERRIDING SYSTEM VALUE VALUES ('P101', 'CSEN2171', 'Preskill', 2);
INSERT INTO public.course_skill_mapping OVERRIDING SYSTEM VALUE VALUES ('P102', 'CSEN1031', 'Preskill', 3);
INSERT INTO public.course_skill_mapping OVERRIDING SYSTEM VALUE VALUES ('S102', 'CSEN1031', 'Tech/Core', 4);


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.department VALUES ('301', 'CSE', 'Computer Science and Engineering', '201');
INSERT INTO public.department VALUES ('302', 'AI&DS', 'Artificial Intelligence & Data Science', '201');
INSERT INTO public.department VALUES ('303', 'EECE', 'Electrical, Electronics  & Communication Engineering', '201');
INSERT INTO public.department VALUES ('304', 'Mech', 'Mechanical Engineering', '201');
INSERT INTO public.department VALUES ('305', 'Civil', 'Civil Engineering', '201');
INSERT INTO public.department VALUES ('341', 'CAIA', 'CAIA', '205');


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employee VALUES ('700614', 'mpoobala@gitam.edu', 'Dr Mangalraj', 'Associate Professor', '2025-01-01', '301', '$2b$10$bC1.agWlyYZsimKVnXgdT.RNvz0.FoE3/wmyu9MbzzXRh.QSl1Vk6', NULL);
INSERT INTO public.employee VALUES ('700701', 'mgopal@gitam.edu', 'Dr. Gopal Murugan ', 'Associate Professor', '2025-01-01', '301', '$2b$10$qEuibj0Hftd2oJF95lnEiOWhmb7TnXGNOoGqaOCqiiWUhA.mP8K7e', NULL);
INSERT INTO public.employee VALUES ('93361', 'dnarayan@gitam.edu', 'Dr. Dayanand Lal N', 'Assistant Professor', '2025-01-01', '301', '$2b$10$Ul.Go4nyynDboXYO6.iYw.4n8Cp4gj9IIFfSY3uLGmXaRXcIT0E3y', NULL);
INSERT INTO public.employee VALUES ('700499', 'kvelayut@gitam.edu', 'Dr. Kathiresan', 'Assistant Professor', '2025-01-01', '301', '$2b$10$wkZogGkMBzJUxFxPwWh6J.gDrQvWS.RDszEvlVnKKNnocMN3poCoq', NULL);
INSERT INTO public.employee VALUES ('700563', 'tchetty@gitam.edu', 'Dr. Thirumalai Selvan C', 'Assistant Professor', '2025-01-01', '301', '$2b$10$Q1KllytGwbrlY3IiiinLQu0RL3Ok32RKDmczLtki5sf.61nBgNbqS', NULL);
INSERT INTO public.employee VALUES ('700578', 'gnataraj@gitam.edu', 'Dr.Ganesh Kumar Natarajan', 'Assistant Professor', '2025-01-01', '301', '$2b$10$/LpQbgW6MvhKUigZff0W4e/HDz1YJguuqw.UTDnD2KhWJouhtsL6e', NULL);
INSERT INTO public.employee VALUES ('700594', 'sthangav@gitam.edu', 'Dr T Saravanan', 'Assistant Professor', '2025-01-01', '301', '$2b$10$3G0Ve26MfUkI5g8QopK/Aed1fe2lFmTcEwtWHR5myYVqV/FZLmGUa', NULL);
INSERT INTO public.employee VALUES ('700710', 'sretnaba@gitam.edu ', 'Dr. Sylaja Vallee Narayan S R', 'Assistant Professor', '2025-01-01', '301', '$2b$10$RyiObDjqPNtKj5Po.hxYke.9xEJTEATSbRuvEB458cp9iLj7xIOS6', NULL);
INSERT INTO public.employee VALUES ('700515', 'apaduvil@gitam.edu', 'Dr. Arjun K P', 'Assistant Professor', '2025-01-01', '301', '$2b$10$HIQDMGVQw2qGUdVjAFW6ceoROryFvBXBtZq4B7vmfBd3RjGF..MOa', NULL);
INSERT INTO public.employee VALUES ('700071', 'rkrishna2@gitam.edu', 'Mrs.Rashmi K', 'Assistant Professor', '2025-01-01', '301', '$2b$10$8msZjJydCsm7vQAGray8v.HQVNJfUPygqUjxjkZmS5HhAoJieDCQG', NULL);
INSERT INTO public.employee VALUES ('700062', 'klakshmi@gitam.edu', 'Mrs.Kamala L', 'Assistant Professor', '2025-01-01', '301', '$2b$10$HILlIsedxd1Buor19B1MFuco5Wh7pt/BaNYR7E86W3m4js9xxbivO', NULL);
INSERT INTO public.employee VALUES ('700267', 'ajaveed@gitam.edu', 'Mr.Abdul Saleem Javeed', 'Assistant Professor', '2025-01-01', '301', '$2b$10$.cCQn6he0jN77cI8nzCVTekV1TV0i6qejUD9bbsqiy4GMkm7vQNae', NULL);
INSERT INTO public.employee VALUES ('700516', 'jvarghes@gitam.edu', 'Dr. Justin Varghese', 'Professor', '2025-01-01', '301', '$2b$10$pijgX5Zk1AT0sArHl9x7ouVjQu/IcUbE/sUUOOgwvBR5me1ijw1ua', NULL);
INSERT INTO public.employee VALUES ('700681', 'nealai@gitam.edu', 'Prof. E R Naganathan', 'Professor', '2025-01-01', '301', '$2b$10$BWm94gmiqLhPr41vOEwkiOnW5Jhg/Fl5mK39WbaqydWoW/yx0zeRe', NULL);
INSERT INTO public.employee VALUES ('700592', 'vadhinar@gitam.edu', 'Dr.Venkatasubramanian .A', 'Associate Professor', '2025-01-01', '301', '$2b$10$wMbIjNaRl3ZvxfWN10LFpujH2pcUQGiuveI9/s3HFV59KXqYmQczC', NULL);
INSERT INTO public.employee VALUES ('700651', 'ddevaraj@gitam.edu', 'Dr.  Devikanniga D', 'Associate Professor', '2025-01-01', '301', '$2b$10$xAzrm.3YyPlxizgbKiLnh.N213RuOUZh6SRx95IGnPv610vMH/Sp.', NULL);
INSERT INTO public.employee VALUES ('700581', 'pediga@gitam.edu', 'Dr.Phalguna Krishna Sathyanarayana Ediga', 'Assistant Professor', '2025-01-01', '301', '$2b$10$zeVWwQAIjBl.xSVN36ktP.5MLwQJMmniW8/kAY8.fWHXypERqmdxC', NULL);
INSERT INTO public.employee VALUES ('700638', 'lramalin@gitam.edu', 'Dr.R Lakshmi Priya', 'Assistant Professor', '2025-01-01', '301', '$2b$10$mJprTFpSXaB8VpSiglSIJeftXCT1LTrPTOta.TijDWjb365FopJ.u', NULL);
INSERT INTO public.employee VALUES ('700627', 'akanagan@gitam.edu', 'Dr.K Arun Kumar', 'Assistant Professor', '2025-01-01', '301', '$2b$10$lEWBk6mtugq7nTJCSXgdDuP9TZkb.b1k4kqFuVeBd.uPEEuSzGJJS', NULL);
INSERT INTO public.employee VALUES ('700777', 'pbuvanes@gitam.edu', 'Dr. B Praveen Kumar ', 'Assistant Professor', '2025-01-01', '301', '$2b$10$.9ZjAcnaRtGPZcWyfdyLlenlUK6MR3161BafHugDKF0.sYkG1Xk5y', NULL);
INSERT INTO public.employee VALUES ('700792', 'ddevendr@gitam.edu', 'Dr. Deepak M D ', 'Assistant Professor', '2025-01-01', '301', '$2b$10$FVulqzuHFRZ/2WWGjW2IxOPcX9wYfInPc.tMw14tysyJJR9On56Ju', NULL);
INSERT INTO public.employee VALUES ('700881', 'agovinda@gitam.edu', 'Dr. Arun Prasath G', 'Assistant Professor', '2025-01-01', '301', '$2b$10$PAAx5KRY8j/pHPj3cgChluRhiFQy2NK7qxy1aPZ.ErFG82Z/T5at6', NULL);
INSERT INTO public.employee VALUES ('700061', 'hkrishna@gitam.edu', 'Mrs.Hema K', 'Assistant Professor', '2025-01-01', '301', '$2b$10$vH4TazhvKcDsBSeNC8n9UuPo3JimaMlw.XA2RGV62zMqVDAQoYXLO', NULL);
INSERT INTO public.employee VALUES ('700056', 'sranida@gitam.edu', 'Mrs.Shobharani DA', 'Assistant Professor', '2025-01-01', '301', '$2b$10$0P5g8QPJXz04cSNfBJxJsOFrUB.QKKhGpEtgZkk.8S.oI9l/CHTjC', NULL);
INSERT INTO public.employee VALUES ('700266', 'mambuja@gitam.edu', 'Mrs.Madhurya J A', 'Assistant Professor', '2025-01-01', '301', '$2b$10$0g1TN.nljVmd8OVAKgif7eg4OpMlmAQodDpSU7Nakm4O4Qi/cNhha', NULL);
INSERT INTO public.employee VALUES ('700590', 'snambath@gitam.edu', 'Mr Sreenarayana N M', 'Assistant Professor', '2025-01-01', '301', '$2b$10$YIOdsjnvuw5ZiXyC7rUfOucbXnKDauOaX8F6mmrwFQlvJTfQXapV.', NULL);
INSERT INTO public.employee VALUES ('700444', 'mgurupar@gitam.edu', 'Prof. K. Meena', 'Professor', '2025-01-01', '301', '$2b$10$h3qPf6lRczFaN6e.lC5bSeeFXMANrL53i6WtQA1pzYU18BsWtxGJa', NULL);
INSERT INTO public.employee VALUES ('1336', 'rbhukya@gitam.edu', 'Dr. B. Ramesh Naik', 'Associate Professor', '2025-01-01', '301', '$2b$10$wijyRuYc397yLfjhbimmWeifvSE6CPrZDHtARSjhSVynNSieR4YVO', NULL);
INSERT INTO public.employee VALUES ('700389', 'smani2@gitam.edu', 'Dr.M.Sathishkumar', 'Associate Professor', '2025-01-01', '301', '$2b$10$6nxCe4tDAChYnuxtJ7c9Qul3Ii8cRaFwLZhZp3cXwmYU16qFn1RkW', NULL);
INSERT INTO public.employee VALUES ('700350', 'mjha2@gitam.edu', 'Dr. Monica Jha', 'Assistant Professor', '2025-01-01', '301', '$2b$10$1ZWjaLecMJ3CeZsflECxNu3RPbMqI0oIEUfLUQVdfRsa9RpoazrQ2', NULL);
INSERT INTO public.employee VALUES ('501255', 'abose@gitam.edu', 'Dr. Ankita Bose', 'Assistant Professor', '2025-01-01', '301', '$2b$10$EIs.P6dn0IaRLozkAPHa0.Q7zv9EGYnomPtCj56xrNEarrWCjrcdm', NULL);
INSERT INTO public.employee VALUES ('700536', 'akumar10@gitam.edu', 'Dr.Abhay Kumar', 'Assistant Professor', '2025-01-01', '301', '$2b$10$Ki3eIm8eStzqjbMM.HHzJ.ZINkZjWJ57VPPV8ajAbzbZbaKMB6kpe', NULL);
INSERT INTO public.employee VALUES ('700646', 'mravisha@gitam.edu', 'Dr Monica Ravishankar', 'Assistant Professor', '2025-01-01', '301', '$2b$10$4rRdOPSuNX2n5kSvoPusQuDuIlc3ilvnAPv0h7bGzSnvpWuGZvJA2', NULL);
INSERT INTO public.employee VALUES ('30021', 'mgowda@gitam.edu', 'Dr. Mohan Gowda V', 'Assistant Professor', '2025-01-01', '301', '$2b$10$mi1/ipp6n8UrxJJWTHfzkOaoS.RXEcBajB/cCgPwfAcKtOmLAx8KO', NULL);
INSERT INTO public.employee VALUES ('700901', 'ashanmug@gitam.edu', 'Dr. Anantha Babu', 'Assistant Professor', '2025-01-01', '301', '$2b$10$fZ321zXiN0Bu02FWJgzquuS4wikMfPdicepd4iOUF//2pQM54Buz6', NULL);
INSERT INTO public.employee VALUES ('700054', 'sjain@gitam.edu', 'Dr. Swasthika Jain', 'Assistant Professor', '2025-01-01', '301', '$2b$10$F4.Rxmj6jenyFo2RLgFtA.aSTWYnk4LBpnBVcXqOgDaInd88mjc3e', NULL);
INSERT INTO public.employee VALUES ('30026', 'sadhinki@gitam.edu', 'Mr.Sanjeev Kumar AN', 'Assistant Professor', '2025-01-01', '301', '$2b$10$2L3u1WxDkynW3Mnl6E1ma.zhq.su6XV7O0bd2i1RsEC7g9DRoMxBy', NULL);
INSERT INTO public.employee VALUES ('30020', 'sbiradar@gitam.edu', 'Mr.Sangameshwar', 'Assistant Professor', '2025-01-01', '301', '$2b$10$nlC9LIZbdsRK8B4JMNxOge4Qs1BMRWvVRanmeVzJQ6cVroXFhOf46', NULL);
INSERT INTO public.employee VALUES ('700567', 'vchalapa@gitam.edu', 'Mrs.Veena R C', 'Assistant Professor', '2025-01-01', '301', '$2b$10$0zA7QaDSY.0xnhm3CLmgFuJbAEIpR.PwlyuPq2NB3/Rwpe39uiVme', NULL);
INSERT INTO public.employee VALUES ('700580', 'vdevaray@gitam.edu', 'Dr. D Venkatesh', 'Associate Professor', '2025-01-01', '301', '$2b$10$w8.gfMBNqhX7.84uyODEXevholxf1HX4QGFGQrzn5aX5SrQmiUgte', NULL);
INSERT INTO public.employee VALUES ('700325', 'sdaranda@gitam.edu', 'Dr. Smita Darandale', 'Associate Professor', '2025-01-01', '301', '$2b$10$5xYX0RrnAGb/IfVzj9hbSOscm7MwXjJL8HjmZKA.27cSKvfnjy6CW', NULL);
INSERT INTO public.employee VALUES ('700254', 'rherakal@gitam.edu', 'Dr. Renuka R. Patil', 'Assistant Professor', '2025-01-01', '301', '$2b$10$yU86GmRHUDZdOY/.Ga3VuOm6qB2rPM4rbba5NMrXqtlWV9CDuxdSK', NULL);
INSERT INTO public.employee VALUES ('700560', 'gmuppago@gitam.edu', 'Dr.Ganesh Karthik Muppagowni', 'Assistant Professor', '2025-01-01', '301', '$2b$10$EwrKYSFR0m/O2pMlk0OYS.XNe2gcQL78SmqvrORSwEwRsNg/ulVAW', NULL);
INSERT INTO public.employee VALUES ('700746', 'ssudhan@gitam.edu', 'Dr. Sowmya S ', 'Assistant Professor', '2025-01-01', '301', '$2b$10$0ze/PAlGwyMU5XnDFBLz1.bCXGELqSJAMl04sGjiqePVsxwST8MlW', NULL);
INSERT INTO public.employee VALUES ('700787', 'bkrishna2@gitam.edu', 'Dr. Bhavya K.R.', 'Assistant Professor', '2025-01-01', '301', '$2b$10$M/n6lPYOTVkIZNRdx5eHDO0n6W1SF0.wI7YC2QYEd16PhofMKtFB2', NULL);
INSERT INTO public.employee VALUES ('700549', 'akarunan@gitam.edu', 'Dr. Anandhan Karunanithi', 'Assistant Professor', '2025-01-01', '301', '$2b$10$6moWbzFYPlHrgCUOwgjSreKk8PqH22/LMgDSZBq0c.kp/FSiZGi8m', NULL);
INSERT INTO public.employee VALUES ('30114', 'rshivaga@gitam.edu', 'Mr.Rajesh S M', 'Assistant Professor', '2025-01-01', '301', '$2b$10$Ymax6OY4ajqoBroRshL5yebkhEXJywQQjbX4ZgH7zEjRh1t4LG9rG', NULL);
INSERT INTO public.employee VALUES ('700048', 'cnagaraj@gitam.edu', 'Mrs.Chaithanya B N', 'Assistant Professor', '2025-01-01', '301', '$2b$10$AzMbLgjM7R9mx2YsjtrNJOCy18UjkDYHR0I6dlsrD24Ocn8KTEXDC', NULL);
INSERT INTO public.employee VALUES ('700263', 'ssanthos@gitam.edu', 'Mrs.Sahana D S', 'Assistant Professor', '2025-01-01', '301', '$2b$10$lL.hSjx.WPv6m9JDUMdJG.OS5SHS5O.E7a5Qu7.Ae1u9QbBDxfV3u', NULL);
INSERT INTO public.employee VALUES ('700261', 'rvenkate@gitam.edu', 'Mrs.Ranjitha V', 'Assistant Professor', '2025-01-01', '301', '$2b$10$.Lr6Bs83OMq73Q/o04VLE.5G6X3zQOg8K914PQB1SE/3wUZQR7u7S', NULL);
INSERT INTO public.employee VALUES ('700658', 'hputta@gitam.edu', 'Mrs Putta Hemalatha', 'Assistant Professor', '2025-01-01', '301', '$2b$10$Zp5LbsQ1QTphW4tSdGhuoOn.feIcQ9uGu4yNSl0Hs7rRkfePHPkhW', NULL);
INSERT INTO public.employee VALUES ('700975', 'mmalakar@gitam.edu', 'Mrs. Madhuri Malakar', 'Assistant Professor', '2025-01-01', '301', '$2b$10$MVEK2aMYMrgFTvosV9LvguSC3CitKAL8Va/3d2PwQz/J.9NYzWLt2', NULL);
INSERT INTO public.employee VALUES ('700334', 'mkabadi@gitam.edu', 'Prof. Mohan Govindasa Kabadi', 'Professor', '2025-01-01', '301', '$2b$10$.jwJISgs8sk5R7PMxwS9KOokAi97cPoXE3OzAyJUR.xVYXiO82DNC', NULL);
INSERT INTO public.employee VALUES ('700970', 'rkasarap@gitam.edu', 'Dr. Kasarapu Ramani', 'Professor', '2025-01-01', '301', '$2b$10$GYDQR8RLYm.cRTCRAn5jMed0.96XJsZirhmzQ3CXF6k9L1eCyw1bK', NULL);
INSERT INTO public.employee VALUES ('700156', 'gchandra@gitam.edu', 'Dr. C Gopala Krishnan', 'Associate Professor', '2025-01-01', '301', '$2b$10$OsTFhfHj.fdxc7omR0PebuStc5QIahKHdZzx4B2BDBIpJK1I47qH.', NULL);
INSERT INTO public.employee VALUES ('700772', 'kkamalap@gitam.edu ', 'Dr. Kamalapuram Khaja Baseer', 'Associate Professor', '2025-01-01', '301', '$2b$10$A2jf2DJePjH6uxMAMrok2Ou1cj1jNK2x75ecUhsRbtOVyyaYEN2Pa', NULL);
INSERT INTO public.employee VALUES ('700607', 'gnagasub@gitam.edu', 'Dr N Gayathri', 'Assistant Professor', '2025-01-01', '301', '$2b$10$dO5i7yqXi4XJ2V1.jB0kLutt4fB4T4wM4dJjlW2y0nXmFEsdG5UUq', NULL);
INSERT INTO public.employee VALUES ('700606', 'rsakthiv@gitam.edu', 'Dr S Rakesh Kumar', 'Assistant Professor', '2025-01-01', '301', '$2b$10$WMM0X0A8ISwkudJtFb95ReNDfcoiT5pSTISeTA/Q..oJTbIlZQSYm', NULL);
INSERT INTO public.employee VALUES ('700615', 'dmarimut@gitam.edu', 'Dr Divya Pushpalakshmi M', 'Assistant Professor', '2025-01-01', '301', '$2b$10$Cgf6hR7obHQXnooIwQIdZu6TAxRIyXKw9We5LzfGz8eM8tFFfCPZS', NULL);
INSERT INTO public.employee VALUES ('700616', 'rveerasa@gitam.edu', 'Dr V Ramachandran', 'Assistant Professor', '2025-01-01', '301', '$2b$10$/7lbG2mR02RfZz7Bm0uMLO0V3QxxIH3h2GhgiXVpjJZ1EX27AqrIq', NULL);
INSERT INTO public.employee VALUES ('10092', 'svinayak@gitam.edu', 'Dr V. Sandhya', 'Assistant Professor', '2025-01-01', '301', '$2b$10$ij18KGkqUVG8BbOTBSZ0dOIdsm7lr7.mSEWdYK0LwOFG/1xUpa9Y6', NULL);
INSERT INTO public.employee VALUES ('700058', 'sgunti@gitam.edu', 'Mr.Gunti Spandan', 'Assistant Professor', '2025-01-01', '301', '$2b$10$m0yCeNZ4SFkQ4mzCSRTE0e1OWbCYHG2/SAqG2CyZ4GoO6e4xBrmNK', NULL);
INSERT INTO public.employee VALUES ('700057', 'ssureddy@gitam.edu', 'Mrs.Sneha Sureddy', 'Assistant Professor', '2025-01-01', '301', '$2b$10$pCbgtQP7ZjOXiaioSLbD6OldxlL99PRlg8lfmxgadClxac103R6g6', NULL);
INSERT INTO public.employee VALUES ('700273', 'vjyothip@gitam.edu', 'Mrs.Vidya J', 'Assistant Professor', '2025-01-01', '301', '$2b$10$dx2rHphFKw2pFkKWto2Zh.Rwdym.fK05UcYQsd3v7bNbBjFZ2igqu', NULL);
INSERT INTO public.employee VALUES ('700269', 'npariksh@gitam.edu', 'Mr.Parikshith Nayaka S K', 'Assistant Professor', '2025-01-01', '301', '$2b$10$g7dsJgWiNL9.77Zb3/E5g.5OVF86BDlPcHlSU1Y8oK1lPu78Wl0I6', NULL);
INSERT INTO public.employee VALUES ('700265', 'dmanjuna@gitam.edu', 'Mr.Deepak D M', 'Assistant Professor', '2025-01-01', '301', '$2b$10$vn8MqAW7AfrWkjEGyu/rHOcpxy9WoY70VNhXDxBJKbsd9UPDp1cYS', NULL);
INSERT INTO public.employee VALUES ('700514', 'nmysore2@gitam.edu', 'Dr. Naga Raju M', 'Associate Professor', '2025-01-01', '301', '$2b$10$5R3Td0t7rK3k0RJvzt1LU.X99nIZaiUoVF3yBPueEXqcN7J9He0Eu', NULL);
INSERT INTO public.employee VALUES ('30099', 'ctukkoji@gitam.edu', 'Dr. Chetana Tukkoji', 'Assistant Professor', '2025-01-01', '301', '$2b$10$DKKxcmFLD0zapD6g.Snue.1EOJgzDFNfX5FHsIp3VMeqERsUFYgTm', NULL);
INSERT INTO public.employee VALUES ('700386', 'vmallika@gitam.edu', 'Dr. A M Viswa Bharathy', 'Assistant Professor', '2025-01-01', '301', '$2b$10$RuE57ktuyd//ein0/Y88au7slXpWU2vDvzf.oiZ.Sfarsh9m287w.', NULL);
INSERT INTO public.employee VALUES ('700133', 'vprasann@gitam.edu', 'Dr.Prasanna venkatesan T', 'Assistant Professor', '2025-01-01', '301', '$2b$10$Pe1v57cN8V1L/s8A66/RUebsqF4R.gzOXgKUWrn279IciLCa/2Icq', NULL);
INSERT INTO public.employee VALUES ('700628', 'srajendr@gitam.edu', 'Dr. R Sathiyaraj', 'Assistant Professor', '2025-01-01', '301', '$2b$10$dqXCXSYMtoGzLCzVZKG8WeTJlxtvCw7DoVv4xNSRi2Plwel1RCuxa', NULL);
INSERT INTO public.employee VALUES ('700636', 'sjayaram@gitam.edu', 'Dr Shyam Mohan J S', 'Assistant Professor', '2025-01-01', '301', '$2b$10$.TD5/g.BZ5NkeUwDkmxB7uc.6qR2hCqpnYCTLaSZxB7WJTlwwLytC', NULL);
INSERT INTO public.employee VALUES ('700629', 'sdar@gitam.edu', 'Dr Showkath  Ahamad  Dar ', 'Assistant Professor', '2025-01-01', '301', '$2b$10$qvrbqGRes3qc4q7iJp/zrOylsv7p1DGR1MH5GfmYygit04JH5YvP6', NULL);
INSERT INTO public.employee VALUES ('30095', 'gkallesh@gitam.edu', 'Dr. Geetha K', 'Assistant Professor', '2025-01-01', '301', '$2b$10$b5rYzLSqKoQNI0FFW.YD..86D227lF4AQSdKOnPkku6A/WOE9ITBm', NULL);
INSERT INTO public.employee VALUES ('30007', 'asnathan@gitam.edu', 'Mrs.Archana S Nadhan', 'Assistant Professor', '2025-01-01', '301', '$2b$10$yix6WosTnCne9bxmFeC5jeE.Dp5JC39tAnXllJI4jb6AXmMFh2ovq', NULL);
INSERT INTO public.employee VALUES ('700049', 'sboosi@gitam.edu', 'Mrs.Shyamala Boosi', 'Assistant Professor', '2025-01-01', '301', '$2b$10$Uxw3QNDau0Ylx5t5W3SRwO8brwIoXBI6b/Ag.7MiyJE3vq47kpp1a', NULL);
INSERT INTO public.employee VALUES ('30143', 'bpillai@gitam.edu', 'Mrs.Beena G Pillai', 'Assistant Professor', '2025-01-01', '301', '$2b$10$HHl2KG.Msu.JOtbMRwE/xe6aTgsnA7HFO3kMKNvPwt/RxjfLdHE2G', NULL);
INSERT INTO public.employee VALUES ('700274', 'pnarayan@gitam.edu', 'Mrs.Priyanka N', 'Assistant Professor', '2025-01-01', '301', '$2b$10$7zqu7rDZW3BCIRNiUpcnMua/oKs4e6hwFvTCABh9GKG2PB9J3SyiC', NULL);
INSERT INTO public.employee VALUES ('700472', 'vayyasam@gitam.edu	', 'Prof. A. Vadivel', 'Professor', '2025-01-01', '301', '$2b$10$M7kNTqGEW81Rb30lKr53bOK3UK0MKpjC0D2.s7et/H9YM5a9c//Xy', NULL);
INSERT INTO public.employee VALUES ('700912', 'sjoy@gitam.edu', 'Salmon Joy', 'Technology Expert', '2024-07-31', '341', '$2b$10$001xokBaa99P7BVZGe2iZuMAbwE.nuSSyfFEYqk21WFoIRAlqZH1K', NULL);
INSERT INTO public.employee VALUES ('700844', 'snarayan3@gitam.edu', 'Dr. N. Shobha Rani ', 'Associate Professor', '2025-01-01', '301', '$2b$10$pKoQGaiG4c0SAg95EYEBTOXbgnAjafhRR3Dhj.dwTi/SWq7G/p2cW', NULL);
INSERT INTO public.employee VALUES ('700655', 'schoudha2@gitam.edu', 'Dr Saket Kumar Choudhary', 'Assistant Professor', '2025-01-01', '301', '$2b$10$00QwfcfBGdk/Cnl8N6rF2euYf2npP1cvijDGef7ob1/Zoh8C9YWDW', NULL);
INSERT INTO public.employee VALUES ('700626', 'tpalaniv@gitam.edu', 'Dr P Theepalakshmi ', 'Assistant Professor', '2025-01-01', '301', '$2b$10$SyeWxoQlRTJf4/mgeiNiEOkRZTJX.aYe9WZbrI75kX2W6WqE2/l3G', NULL);
INSERT INTO public.employee VALUES ('700689', 'tsubrama@gitam.edu', 'Dr.S Thiruselvan', 'Assistant Professor', '2025-01-01', '301', '$2b$10$8O8lZsCliadRBRPJ7bnd7uZPFmNH1kX8bsNXGISdvr3Sob3MDKu3q', NULL);
INSERT INTO public.employee VALUES ('700641', 'ckumar@gitam.edu', '
Dr Chintoo Kumar', 'Assistant Professor', '2025-01-01', '301', '$2b$10$QkQH1JRwLrJ68nuFS.9hNudjvtLVKqMaNOLcvIheNMGO4IUlwzCa6', NULL);
INSERT INTO public.employee VALUES ('700502', 'bvenkate@gitam.edu', 'Dr. Balaji V', 'Assistant Professor', '2025-01-01', '301', '$2b$10$Qw9uZs0ykpS3G7.ZqU0SqOxEhI1j9IwVh28FaKrwwqXo8r72rwlJO', NULL);
INSERT INTO public.employee VALUES ('700757', 'amondal@gitam.edu', 'Dr.  Md Arifuzzaman Mondal', 'Assistant Professor', '2025-01-01', '301', '$2b$10$iCjRWZiGE9IrZ9eZvtLMxOueMRRJIgPRUw1RNxh2HEz0flp/NGmKm', NULL);
INSERT INTO public.employee VALUES ('700258', 'knida@gitam.edu', 'Mrs.Nida Kousar G', 'Assistant Professor', '2025-01-01', '301', '$2b$10$5ID/eLueWSp98Lof7nB00O99VkPNtTrAK5EHHj2QJTKJKmJxWYije', NULL);
INSERT INTO public.employee VALUES ('700260', 'sthimmar@gitam.edu', 'Mrs.Spoorthi T', 'Assistant Professor', '2025-01-01', '301', '$2b$10$VSlWlLkng7kTBbPMP1GHJeSPJIBSvEbz.uaFoTVf7XdzMH/NVW1SG', NULL);
INSERT INTO public.employee VALUES ('700541', 'zadhoni@gitam.edu', 'Mr.Zameer Ahmed Adhoni', 'Assistant Professor', '2025-01-01', '301', '$2b$10$v.gEFRoy7hm8nn1NUpTUYu1A3wPr5qSqt0ShS7O8JECJkrUyHuPam', NULL);
INSERT INTO public.employee VALUES ('700542', 'skerenal@gitam.edu', 'Mr.Sudarshana Kerenalli', 'Assistant Professor', '2025-01-01', '301', '$2b$10$qoPNQWFFMwKzLlIzNkOVXuWbjzt91U111/HE0Z9tWfvVH0oA.Gt0K', NULL);
INSERT INTO public.employee VALUES ('700620', 'rraja@gitam.edu', 'Mr Rajesh R', 'Assistant Professor', '2025-01-01', '301', '$2b$10$rZhSi09tr8c0pfnizzWT6.A9IJ3SzqrT9RfdmrD3atqtITBwrrw0q', NULL);
INSERT INTO public.employee VALUES ('700677', 'skothuru@gitam.edu', 'Mr Srinivasulu Kothuru', 'Assistant Professor', '2025-01-01', '301', '$2b$10$RS5tHP42MOymyRqF7Gebl.46.2W8fYDMQwAlfqJBXvsTegaq0HUuK', NULL);
INSERT INTO public.employee VALUES ('10379', 'anitturu2@gitam.edu', 'Mrs. Nitturu Asha Jyothi', 'Assistant Professor', '2025-01-01', '301', '$2b$10$XeQe7wkoSCA6sQC4BDwB8e6ZarUtLj9QmD9zFN7eS.M4qyJnxID1u', NULL);
INSERT INTO public.employee VALUES ('700853', 'schalich@gitam.edu', 'Mrs. Silpa C', 'Assistant Professor', '2025-01-01', '301', '$2b$10$vAP19.jMXUw2zucdcauCXOAf2xxWcI3b.3jOI5JzBSEx/HBJA.j5u', NULL);
INSERT INTO public.employee VALUES ('700866', 'cmuthukr@gitam.edu', 'Mrs. M. Chandraprabha', 'Assistant Professor', '2025-01-01', '301', '$2b$10$pEToK.Iw8qQUBYyGdjovQe3RP/ya2WTg7B1cR07dQoGcPB4wq92.m', NULL);
INSERT INTO public.employee VALUES ('700136', 'vyendapa@gitam.edu', 'Prof.Vamsidhar Yendapalli', 'Professor', '2025-01-01', '301', '$2b$10$c1Kyi/hvLlk15WPLcV0/iu80sy4MKqLDgnicDGO/VXPqtqtxBXcHy', NULL);


--
-- Data for Name: familiarity_marking; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x2', '700614', '2025-07-01 03:10:23.376', true, 32, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x2', '700614', '2025-07-01 09:29:33.186', true, 45, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x2', '700614', '2025-07-01 09:29:51.637', true, 48, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x2', '700614', '2025-07-01 11:51:12.665', false, 53, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P101x2', '700614', '2025-06-30 18:05:21.001', true, 22, 'NA');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P101x2', '700614', '2025-07-01 21:31:01.596', false, 54, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x1', '700614', '2025-07-01 03:10:14.956', true, 31, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x1', '700614', '2025-07-01 09:29:33.186', true, 44, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x1', '700614', '2025-07-01 11:51:12.665', true, 52, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P101x1', '700614', '2025-06-30 18:05:16.226', true, 21, 'NA');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P101x1', '700614', '2025-07-01 21:31:01.596', true, 55, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S101x1', '700614', '2025-06-30 18:02:56.973', true, 18, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S101x2', '700614', '2025-06-30 18:03:04.172', false, 19, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S101x3', '700614', '2025-06-30 18:03:11.226', false, 20, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x4', '700701', '2025-07-01 02:45:38.711', false, 30, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x4', '700614', '2025-07-01 03:10:47.315', false, 38, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x1', '700614', '2025-07-01 03:10:36.591', true, 35, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x1', '700614', '2025-07-01 09:30:35.587', true, 49, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x1', '700614', '2025-07-01 22:02:07.344', false, 56, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x1', '700614', '2025-07-01 22:02:07.344', false, 57, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P101x1', '700614', '2025-07-01 22:02:07.344', false, 58, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S101x1', '700614', '2025-07-01 22:02:07.344', false, 59, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x3', '700701', '2025-07-01 02:45:34.071', true, 29, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x3', '700701', '2025-07-01 22:46:06.848', false, 61, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x2', '700701', '2025-07-01 02:43:17.84', true, 24, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x3', '700701', '2025-07-01 02:44:56.534', true, 25, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x4', '700701', '2025-07-01 02:45:00.191', true, 26, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x1', '700701', '2025-07-01 02:43:13.292', true, 23, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x1', '700701', '2025-07-01 22:46:06.848', true, 60, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x1', '700701', '2025-07-01 23:12:28.072', false, 62, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x2', '700701', '2025-07-01 23:12:28.072', false, 63, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x3', '700701', '2025-07-01 23:12:28.072', false, 64, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x4', '700701', '2025-07-01 23:12:28.072', false, 65, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x4', '700614', '2025-07-01 03:10:30.54', true, 34, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x3', '700614', '2025-07-01 03:10:26.54', true, 33, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x3', '700614', '2025-07-01 09:29:33.186', false, 46, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x3', '700614', '2025-07-01 03:10:43.42', true, 37, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x3', '700614', '2025-07-01 09:30:35.587', false, 50, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x4', '700614', '2025-07-01 09:29:51.637', true, 47, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x4', '700614', '2025-07-03 22:35:06.567', false, 66, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x2', '700614', '2025-07-01 03:10:39.793', true, 36, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x2', '700614', '2025-07-01 09:30:35.587', true, 51, 'NA');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('P102x2', '700614', '2025-07-03 22:35:16.846', false, 67, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x1', '700701', '2025-07-01 02:45:21.104', true, 27, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x2', '700701', '2025-07-01 02:45:25.439', true, 28, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x1', '700701', '2025-07-03 22:35:54.103', false, 68, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S102x2', '700701', '2025-07-03 22:35:54.103', false, 69, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S101x3', '700499', '2025-07-03 23:20:09.561', false, 74, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S101x1', '700499', '2025-07-03 23:00:14.606', true, 71, 'NA');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S101x1', '700499', '2025-07-03 23:20:09.561', true, 72, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S101x2', '700499', '2025-07-03 23:20:09.561', true, 73, 'No');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S101x2', '700499', '2025-07-03 23:20:53.976', false, 75, 'Yes');
INSERT INTO public.familiarity_marking OVERRIDING SYSTEM VALUE VALUES ('S101x1', '700499', '2025-07-03 23:20:53.976', false, 76, 'No');


--
-- Data for Name: school; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.school VALUES ('201', 'GST', 'GITAM School of Technology', '101');
INSERT INTO public.school VALUES ('202', 'GSB', 'GITAM School of Business', '101');
INSERT INTO public.school VALUES ('203', 'GSS', 'GITAM School of Science', '101');
INSERT INTO public.school VALUES ('204', 'GSHS', 'GITAM School of Humanities and Social Sciences ', '101');
INSERT INTO public.school VALUES ('205', 'BAO', 'BAO Functions', '101');


--
-- Data for Name: skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.skill VALUES ('P101', 'TCP/IP Basics', 'NA');
INSERT INTO public.skill VALUES ('P102', 'Data Structures', 'NA');
INSERT INTO public.skill VALUES ('S102', 'ML Methods', 'NA');
INSERT INTO public.skill VALUES ('S101', 'IOT Protocols', 'NA');


--
-- Data for Name: subskill; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subskill VALUES ('S101x1', 'MQTT Protocol', 'NA', 'S101', true);
INSERT INTO public.subskill VALUES ('S101x2', 'CoAP Protocol', 'NA', 'S101', true);
INSERT INTO public.subskill VALUES ('S101x3', 'HTTP Protocol', 'NA', 'S101', true);
INSERT INTO public.subskill VALUES ('P101x1', 'TCP Protocol', 'NA', 'P101', true);
INSERT INTO public.subskill VALUES ('P101x2', 'UDP Protocol', 'NA', 'P101', true);
INSERT INTO public.subskill VALUES ('P102x1', 'Stacks', 'NA', 'P102', true);
INSERT INTO public.subskill VALUES ('P102x2', 'LinkedLists', 'NA', 'P102', true);
INSERT INTO public.subskill VALUES ('P102x3', 'Trees', 'NA', 'P102', true);
INSERT INTO public.subskill VALUES ('P102x4', 'Hashing', 'NA', 'P102', true);
INSERT INTO public.subskill VALUES ('S102x1', 'Supervised Learning', 'NA', 'S102', true);
INSERT INTO public.subskill VALUES ('S102x2', 'Unsupervised Learning', 'NA', 'S102', true);
INSERT INTO public.subskill VALUES ('S102x3', 'Regression Models', 'NA', 'S102', true);
INSERT INTO public.subskill VALUES ('S102x4', 'Clustering', 'NA', 'S102', true);


--
-- Name: course_faculty_mapping_mapping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_faculty_mapping_mapping_id_seq', 5, true);


--
-- Name: course_skill_mapping_mapping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_skill_mapping_mapping_id_seq', 4, true);


--
-- Name: familiarity_marking_marking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.familiarity_marking_marking_id_seq', 76, true);


--
-- Name: campus campus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campus
    ADD CONSTRAINT campus_pkey PRIMARY KEY (campus_id);


--
-- Name: course_faculty_mapping course_faculty_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_faculty_mapping
    ADD CONSTRAINT course_faculty_mapping_pkey PRIMARY KEY (mapping_id);


--
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_id);


--
-- Name: course_skill_mapping course_skill_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_skill_mapping
    ADD CONSTRAINT course_skill_mapping_pkey PRIMARY KEY (mapping_id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- Name: employee employee_employee_mail_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_employee_mail_key UNIQUE (employee_mail);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- Name: familiarity_marking familiarity_marking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.familiarity_marking
    ADD CONSTRAINT familiarity_marking_pkey PRIMARY KEY (marking_id);


--
-- Name: school school_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school
    ADD CONSTRAINT school_pkey PRIMARY KEY (school_id);


--
-- Name: skill skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill
    ADD CONSTRAINT skill_pkey PRIMARY KEY (skill_id);


--
-- Name: subskill subskill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subskill
    ADD CONSTRAINT subskill_pkey PRIMARY KEY (subskill_id);


--
-- Name: course course_caia_coordinator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_caia_coordinator_fkey FOREIGN KEY (caia_coordinator_id) REFERENCES public.employee(employee_id);


--
-- Name: course course_champion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_champion_fkey FOREIGN KEY (course_champion_id) REFERENCES public.employee(employee_id);


--
-- Name: course course_coordinator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_coordinator_fkey FOREIGN KEY (course_coordinator_id) REFERENCES public.employee(employee_id);


--
-- Name: course_faculty_mapping course_faculty_mapping_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_faculty_mapping
    ADD CONSTRAINT course_faculty_mapping_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- Name: course_faculty_mapping course_faculty_mapping_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_faculty_mapping
    ADD CONSTRAINT course_faculty_mapping_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);


--
-- Name: course course_parent_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_parent_department_id_fkey FOREIGN KEY (offered_department_id) REFERENCES public.department(department_id);


--
-- Name: course_skill_mapping course_skill_mapping_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_skill_mapping
    ADD CONSTRAINT course_skill_mapping_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- Name: course_skill_mapping course_skill_mapping_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_skill_mapping
    ADD CONSTRAINT course_skill_mapping_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skill(skill_id);


--
-- Name: department department_parent_school_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_parent_school_id_fkey FOREIGN KEY (parent_school_id) REFERENCES public.school(school_id);


--
-- Name: employee employee_department_mapping_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_department_mapping_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(department_id);


--
-- Name: familiarity_marking rating_mapping_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.familiarity_marking
    ADD CONSTRAINT rating_mapping_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);


--
-- Name: familiarity_marking rating_subskill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.familiarity_marking
    ADD CONSTRAINT rating_subskill_id_fkey FOREIGN KEY (subskill_id) REFERENCES public.subskill(subskill_id);


--
-- Name: school school_parent_campus_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school
    ADD CONSTRAINT school_parent_campus_id_fkey FOREIGN KEY (parent_campus_id) REFERENCES public.campus(campus_id);


--
-- Name: subskill subskill_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subskill
    ADD CONSTRAINT subskill_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skill(skill_id);


--
-- PostgreSQL database dump complete
--

