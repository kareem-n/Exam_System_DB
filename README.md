# Examination System Database

## Overview

The **Examination System Database** is designed to manage various aspects of an examination system, including courses, exams, students, instructors, and departments. It supports logging user answers, managing course details, tracking exam performance, and linking students to courses.



---


## Key Tables

The **Examination System Database** includes the following essential tables:

### 1. Qans_log

Logs user answers, capturing:
- **_user**: User who answered the question.
- **_date**: Date of the answer.
- **question_id**: ID of the question answered.
- **msg**: Additional message or note.

### 2. Course

Stores information about courses:
- **crs_id**: Course ID.
- **crs_title**: Course title.
- **crs_description**: Course description.
- **crs_duration**: Duration of the course.
- **topic_id**: Link to the associated topic.

### 3. Department

Stores details about departments:
- **dept_id**: Department ID.
- **dept_name**: Department name.
- **dept_mgr**: Department manager.
- **mgr_hiringDate**: Hiring date of the department manager.

### 4. Exam

Stores information about exams:
- **ex_id**: Exam ID.
- **crs_id**: Course ID (linked to a course).
- **ins_id**: Instructor ID (linked to an instructor).
- **exDuration**: Exam duration.
- **totalMark**: Total marks.

### 5. ExamQuestions

Links exams with questions:
- **ex_id**: Exam ID.
- **q_id**: Question ID.

### 6. Instructor

Stores instructor details:
- **ins_id**: Instructor ID.
- **ins_fname**: Instructor's first name.
- **ins_lname**: Instructor's last name.
- **ins_salary**: Instructor's salary (greater than 5000).
- **ins_address**: Instructor's address.
- **dept_id**: Department ID (foreign key).

### 7. Question

Stores exam questions:
- **qId**: Question ID.
- **qbody**: Question body.
- **qType**: Type of question (multiple choice or true/false).
- **qMark**: Marks assigned to the question.
- **course_id**: Link to the course.

### 8. QuestionAnswers

Stores possible answers for each question:
- **answerId**: Answer ID.
- **Question_id**: Linked to a question.
- **answer**: Answer text.
- **is_Correct**: Whether the answer is correct.

### 9. Std_Ans

Logs student answers:
- **ex_id**: Exam ID.
- **q_id**: Question ID.
- **std_id**: Student ID.
- **std_answer**: Student's selected answer.
- **std_score**: Score assigned to the student's answer.

### 10. Stu_Crs

Links students to their courses:
- **stu_id**: Student ID.
- **crs_id**: Course ID.
- **grade**: Student's grade (default: 0).

### 11. Student

Stores student details:
- **stu_id**: Student ID.
- **stu_fname**: Student's first name.
- **stu_lname**: Student's last name.
- **stu_age**: Age (between 18 and 60).
- **stu_address**: Student's address.
- **dept_id**: Department ID (foreign key).

### 12. Topic

Stores topics covered in courses:
- **topic_id**: Topic ID.
- **topic_name**: Topic name.

---

## Relationships

- **Foreign Keys**: The database utilizes foreign keys to link tables together, such as linking students to their departments, courses to instructors, and exams to questions.
  
- **Composite Keys**: Many-to-many relationships are represented by composite keys, such as linking students to courses and instructors to courses.

---


## Stored Procedures

Each table is associated with four stored procedures to manage data:

- **Insert**: Inserts new records into the table.
- **Update**: Modifies existing records.
- **Delete**: Removes records.
- **Select**: Retrieves records based on specific conditions.

### Examples of Stored Procedures

#### Insert Stored Procedure
Each table has an `Insert` stored procedure that adds new data to the table. For example:
- **Course Insert**: Inserts course details such as title, description, and duration.
- **Instructor Insert**: Inserts instructor details like name, salary, and department.

#### Update Stored Procedure
The `Update` stored procedures allow you to modify existing records. For instance:
- **Course Update**: Updates course details such as title and description.
- **Instructor Update**: Modifies instructor information such as salary and department.

#### Delete Stored Procedure
The `Delete` stored procedures are used to remove data from the tables. For example:
- **Course Delete**: Deletes a specific course by ID.
- **Instructor Delete**: Deletes a specific instructor by ID.

#### Select Stored Procedure
The `Select` stored procedures retrieve data based on certain conditions. For example:
- **Course Select**: Retrieves course details by course ID.
- **Instructor Select**: Retrieves instructor details by instructor ID.

## Usage

This system is designed for managing academic exams and courses. It provides functionality for:
- Managing courses, instructors, and departments.
- Storing and organizing exam data, including questions and answers.
- Tracking student enrollment, answers, and grades in exams.
- Generating reports based on user responses and exam results.

---

## Setup Instructions

### Step 1: Create Database

First, create the `Examination_System` database:

```sql
CREATE DATABASE Examination_System;
GO
```
### Step 2: Run SQL Script
Execute the provided SQL script to create all the necessary tables and relationships in your database.

### Step 3: Insert Data
Populate the tables with data as required. You can start by adding sample courses, departments, instructors, and students.
