-- Create the Examination_System database
USE Examination_System
GO

-- Table to log user answers
CREATE TABLE Qans_log (
    _user NVARCHAR(MAX) NULL,          -- User who answered the question
    _date DATETIME NULL,               -- Date of the answer
    question_id INT NULL,              -- ID of the question answered
    msg NVARCHAR(MAX) NULL             -- Additional message or note
)
GO

-- Table to store course information
CREATE TABLE Course (
    crs_id INT IDENTITY(100, 100) NOT NULL PRIMARY KEY,  -- Course ID, auto-incremented
    crs_title VARCHAR(100) NOT NULL,                     -- Course title
    crs_description NVARCHAR(100) NULL,                  -- Course description
    crs_duration INT NULL,                               -- Course duration in hours
    topic_id INT NOT NULL,                               -- Topic ID (foreign key)
    FOREIGN KEY (topic_id) REFERENCES Topic (topic_id)
)
GO

-- Table to store department information
CREATE TABLE Department (
    dept_id INT IDENTITY(100, 200) NOT NULL PRIMARY KEY, -- Department ID, auto-incremented
    dept_name VARCHAR(50) NOT NULL UNIQUE,               -- Department name (unique)
    dept_mgr INT NOT NULL UNIQUE,                        -- Department manager (foreign key, unique)
    mgr_hiringDate DATETIME NOT NULL DEFAULT GETDATE(),  -- Manager hiring date, defaults to current date
    FOREIGN KEY (dept_mgr) REFERENCES Instructor (ins_id)
)
GO

-- Table to store exam information
CREATE TABLE Exam (
    ex_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,       -- Exam ID, auto-incremented
    crs_id INT NOT NULL,                                 -- Course ID (foreign key)
    ins_id INT NOT NULL,                                 -- Instructor ID (foreign key)
    exDuration INT NULL,                                 -- Exam duration in minutes
    totalMark INT NULL,                                  -- Total marks for the exam
    FOREIGN KEY (crs_id) REFERENCES Course (crs_id),
    FOREIGN KEY (ins_id) REFERENCES Instructor (ins_id)
)
GO

-- Table to link exams and questions
CREATE TABLE ExamQuestions (
    ex_id INT NOT NULL,                                  -- Exam ID (foreign key)
    q_id INT NOT NULL,                                   -- Question ID (foreign key)
    PRIMARY KEY (ex_id, q_id),                           -- Composite primary key
    FOREIGN KEY (ex_id) REFERENCES Exam (ex_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (q_id) REFERENCES Question (qId) ON UPDATE CASCADE ON DELETE CASCADE
)
GO

-- Table to link instructors and courses
CREATE TABLE Ins_Crs (
    ins_id INT NOT NULL,                                 -- Instructor ID (foreign key)
    course_id INT NOT NULL,                              -- Course ID (foreign key)
    start_date DATE NOT NULL,                            -- Course start date
    end_date DATE NOT NULL,                              -- Course end date
    PRIMARY KEY (ins_id, course_id),                     -- Composite primary key
    FOREIGN KEY (ins_id) REFERENCES Instructor (ins_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course (crs_id) ON DELETE CASCADE
)
GO

-- Table to store instructor information
CREATE TABLE Instructor (
    ins_id INT IDENTITY(10, 10) NOT NULL PRIMARY KEY,    -- Instructor ID, auto-incremented
    ins_fname VARCHAR(50) NOT NULL,                      -- Instructor first name
    ins_lname VARCHAR(50) NOT NULL,                      -- Instructor last name
    ins_salary INT NOT NULL CHECK (ins_salary > 5000),   -- Instructor salary (must be greater than 5000)
    ins_address VARCHAR(50) NULL,                        -- Instructor address
    dept_id INT NOT NULL,                                -- Department ID (foreign key)
    FOREIGN KEY (dept_id) REFERENCES Department (dept_id)
)
GO

-- Table to store questions
CREATE TABLE Question (
    qId INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,         -- Question ID, auto-incremented
    qbody NVARCHAR(MAX) NOT NULL,                        -- Question body
    qType NVARCHAR(MAX) NOT NULL CHECK (qType IN ('mul', 'tf')), -- Question type (multiple choice or true/false)
    qMark INT NOT NULL,                                  -- Marks for the question
    course_id INT NOT NULL,                              -- Course ID (foreign key)
    FOREIGN KEY (course_id) REFERENCES Course (crs_id)
)
GO

-- Table to store question answers
CREATE TABLE QuestionAnswers (
    answerId INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,    -- Answer ID, auto-incremented
    Question_id INT NOT NULL,                            -- Question ID (foreign key)
    answer VARCHAR(100) NOT NULL,                        -- Answer text
    is_Correct BIT NOT NULL,                             -- Whether the answer is correct
    FOREIGN KEY (Question_id) REFERENCES Question (qId)
)
GO

-- Table to store student answers
CREATE TABLE Std_Ans (
    ex_id INT NOT NULL,                                  -- Exam ID (foreign key)
    q_id INT NOT NULL,                                   -- Question ID (foreign key)
    std_id INT NOT NULL,                                 -- Student ID (foreign key)
    std_answer INT NULL,                                 -- Student's answer (foreign key)
    std_score INT NULL,                                  -- Score for the answer
    PRIMARY KEY (ex_id, q_id, std_id),                   -- Composite primary key
    FOREIGN KEY (ex_id) REFERENCES Exam (ex_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (q_id) REFERENCES Question (qId),
    FOREIGN KEY (std_answer) REFERENCES QuestionAnswers (answerId),
    FOREIGN KEY (std_id) REFERENCES Student (stu_id)
)
GO

-- Table to link students and courses
CREATE TABLE Stu_Crs (
    stu_id INT NOT NULL,                                 -- Student ID (foreign key)
    crs_id INT NOT NULL,                                 -- Course ID (foreign key)
    grade INT NULL DEFAULT 0 CHECK (grade >= 0),         -- Grade for the course (default 0, must be >= 0)
    PRIMARY KEY (stu_id, crs_id),                        -- Composite primary key
    FOREIGN KEY (stu_id) REFERENCES Student (stu_id) ON DELETE CASCADE,
    FOREIGN KEY (crs_id) REFERENCES Course (crs_id) ON DELETE CASCADE
)
GO

-- Table to store student information
CREATE TABLE Student (
    stu_id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,      -- Student ID, auto-incremented
    stu_fname VARCHAR(50) NULL,                          -- Student first name
    stu_lname VARCHAR(50) NULL,                          -- Student last name
    stu_age INT NULL CHECK (stu_age BETWEEN 18 AND 60),  -- Student age (must be between 18 and 60)
    stu_address VARCHAR(100) NULL,                       -- Student address
    dept_id INT NOT NULL,                                -- Department ID (foreign key)
    FOREIGN KEY (dept_id) REFERENCES Department (dept_id) ON DELETE CASCADE
)
GO

-- Table to store topic information
CREATE TABLE Topic (
    topic_id INT IDENTITY(1, 5) NOT NULL PRIMARY KEY,    -- Topic ID, auto-incremented
    topic_name VARCHAR(100) NULL                         -- Topic name
)
GO
