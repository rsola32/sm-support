// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

Enum "course_category_type" {
  "UC"
  "FC"
  "PC"
  "PE"
  "OE"
}

Enum "role_type" {
  "Admin"
  "Faculty"
  "CAIA"
}

Enum "purpose_type" {
  "Teaching Now"
  "Future Teaching"
  "Self Upskill"
}

Enum "designation_type" {
  "Assistant Professor"
  "Associate Professor"
  "Professor"
}

Enum "skill_type" {
  "Preskill"
  "Tech/Core"
  "Tool"
  "Applied"
  "Project"
}

Enum "familiarity_type" {
  "Yes"
  "No"
  "NA"
}

Table "campus" {
  "campus_id" text [pk]
  "campus_name" text
}

Table "school" {
  "school_id" text [pk]
  "school_short_name" text
  "school_full_name" text
  "parent_campus_id" text
}

Table "department" {
  "department_id" text [pk]
  "department_short_name" text
  "department_full_name" text
  "parent_school_id" text
}

Table "employee" {
  "employee_id" text [pk]
  "employee_mail" text [unique]
  "employee_name" text
  "designation" designation_type
  "joining_date" text
  "department_id" text
  "password" text
  "role" role_type
}

Table "course" {
  "course_id" text [pk]
  "course_name" text
  "course_category" course_category_type
  "offered_department_id" text
  "course_coordinator_id" text
  "course_champion_id" text
  "caia_coordinator_id" text
}

Table "course_faculty_mapping" {
  "mapping_id" text [pk]
  "course_id" text
  "employee_id" text
  "purpose" purpose_type
}

Table "skill" {
  "skill_id" text [pk]
  "skill_name" text
  "skill_description" text
}

Table "subskill" {
  "subskill_id" text [pk]
  "subskill_name" text
  "subskill_description" text
  "skill_id" text
  "required" BOOLEAN
}

Table "course_skill_mapping" {
  "mapping_id" INTEGER [pk, increment]
  "skill_id" text
  "course_id" text
  "type" skill_type
}

Table "familiarity_mapping" {
  "marking_id" INTEGER [pk, increment]
  "subskill_id" text
  "employee_id" text
  "familiarity" BOOLEAN
  "date_time" timestamp
  "erased" BOOLEAN
}

Ref "school_parent_campus_id_fkey":"campus"."campus_id" < "school"."parent_campus_id"

Ref "department_parent_school_id_fkey":"school"."school_id" < "department"."parent_school_id"

Ref "employee_department_mapping_id_fkey":"department"."department_id" < "employee"."department_id"

Ref "course_parent_department_id_fkey":"department"."department_id" < "course"."offered_department_id"

Ref "course_coordinator_fkey":"employee"."employee_id" < "course"."course_coordinator_id"

Ref "course_champion_fkey":"employee"."employee_id" < "course"."course_champion_id"

Ref "course_caia_coordinator_fkey":"employee"."employee_id" < "course"."caia_coordinator_id"

Ref "course_faculty_mapping_course_id_fkey":"course"."course_id" < "course_faculty_mapping"."course_id"

Ref "course_faculty_mapping_employee_id_fkey":"employee"."employee_id" < "course_faculty_mapping"."employee_id"

Ref "subskill_skill_id_fkey":"skill"."skill_id" < "subskill"."skill_id"

Ref "course_skill_mapping_skill_id_fkey":"skill"."skill_id" < "course_skill_mapping"."skill_id"

Ref "course_skill_mapping_course_id_fkey":"course"."course_id" < "course_skill_mapping"."course_id"

Ref "rating_subskill_id_fkey":"subskill"."subskill_id" < "familiarity_mapping"."subskill_id"

Ref "rating_mapping_employee_id_fkey":"employee"."employee_id" < "familiarity_mapping"."employee_id"

