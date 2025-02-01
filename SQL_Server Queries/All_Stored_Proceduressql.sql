use Examination_System

--Stored Procedures of DataBase Examination_system

--student SP
--select
create proc getStdById @sId int
with encryption
as
select s.stu_id , s.stu_fname,s.stu_lname,s.dept_id,s.stu_address 
from Student s
where s.stu_id = @sId;

getStdById 5

--insert
CREATE OR ALTER PROCEDURE InsertStudent
    @fName VARCHAR(50),
    @lName VARCHAR(50),
    @age INT,
    @stdAddress VARCHAR(100),
    @deptId INT
with encryption
AS
    INSERT INTO Student (stu_fname, stu_lname, stu_age, stu_address, dept_id)
    VALUES (@fName, @lName, @age, @stdAddress, @deptId);

InsertStudent 'eslam' , 'salah' , 23,'zagazig',100;
	
--update
CREATE OR ALTER PROCEDURE UpdateStudent
    @sId INT,
    @fName VARCHAR(50),
    @lName VARCHAR(50),
    @age INT,
    @stdAddress VARCHAR(100),
    @deptId INT
with encryption
AS
    UPDATE Student
    SET stu_fname = @fName,
        stu_lname = @lName,
        stu_age = @age,
        stu_address = @stdAddress,
        dept_id = @deptId
    WHERE stu_id = @sId;

UpdateStudent 8 , 'Eslam' , 'mohamed' , 23,'zagazig',100;

--delete
create or alter proc deleteStudent @sId int
with encryption
as
if not exists(select sc.stu_id from Stu_Crs sc where stu_id = @sId)
delete from Student where stu_id = @sId;
else
select 'student table has relationship'

--deleteStudent 10;
--deleteStudent 5;

--instructor SP
--select
create proc getInstructorById @instructorId int
with encryption
as
select *
from Instructor 
where ins_id = @instructorId;

getInstructorById 20

--insert
CREATE OR ALTER PROCEDURE InsertInstructor
    @fName VARCHAR(50),
    @lName VARCHAR(50),
    @salary INT,
    @instAddress VARCHAR(100),
    @deptId INT
with encryption
AS
    INSERT INTO Instructor(ins_fname, ins_lname, ins_salary, ins_address, dept_id)
    VALUES (@fName, @lName, @salary, @instAddress, @deptId);

InsertInstructor 'sara' , 'mohamed' , 7000,'alex',2900;
	
--update
CREATE OR ALTER PROCEDURE UpdateInstructor
    @instructorId INT,
    @fName VARCHAR(50),
    @lName VARCHAR(50),
    @salary INT,
    @instAddress VARCHAR(100),
    @deptId INT
with encryption
AS
    UPDATE Instructor
    SET ins_fname = @fName,
        ins_lname = @lName,
        ins_salary = @salary,
        ins_address = @instAddress,
        dept_id = @deptId
    WHERE ins_id = @instructorId;

UpdateInstructor 30 , 'eslam' , 'mohamed' , 8000,'zagazig',100;

--delete
create or alter proc deleteInstructor @instructorId int
with encryption
as
if not exists(select ins_id from Ins_Crs where ins_id = @instructorId)
delete from Instructor where ins_id = @instructorId;
else
select 'instructor table has relationship'

--deleteInstructor 50;
--deleteInstructor 20;










--department SP
--select
create proc getDepartmentById @dId int
with encryption
as
select *
from Department
where dept_id = @dId;

getDepartmentById 100

--make department name and manage id unique
alter table Department
add constraint departmentNameUniqueConstraint Unique(dept_name)

alter table Department
add constraint departmentMgrUniqueConstraint Unique(dept_mgr)

--insert
CREATE OR ALTER PROCEDURE InsertDepartment
    @dName VARCHAR(50),
    @mgrId INT
with encryption
AS
	INSERT INTO Department(dept_name, dept_mgr)
	VALUES (@dName,@mgrId);

    

EXEC InsertDepartment 'python',60;
--update
CREATE OR ALTER PROCEDURE UpdateDepartment
    @dId INT,
    @dName VARCHAR(50),
    @mgrId INT
with encryption
AS
    UPDATE Department
    SET dept_name = @dName,
	dept_mgr = @mgrId
    WHERE dept_id = @dId;

UpdateDepartment 2700, 'python',70;

--delete
create or alter proc deleteDepartment @dId int
with encryption
as
if not exists(select s.dept_id , i.dept_id from Student s join Instructor i  on s.dept_id = @dId or i.dept_id = @dId)
delete from Department where dept_id = @dId;
else
select 'Department table has relationship'

--deleteDepartment 3300;
--deleteDepartment 2900;






--Student Course SP
--select
create or alter proc getStudentGradesByStdId @stdId int
with encryption
as
select c.crs_title,  sc.grade
from Course c join Stu_Crs sc
on c.crs_id = sc.crs_id
where sc.stu_id = @stdId;

getStudentGradesByStdId 5

create or alter proc getStudentsGradeByCrsId @crsId int
with encryption
as
select s.stu_id,s.stu_fname + ' ' + s.stu_lname as 'full name',  sc.grade
from Student s join Stu_Crs sc
on s.stu_id = sc.stu_id
where sc.crs_id = @crsId;

getStudentsGradeByCrsId 200

--insert
CREATE OR ALTER PROCEDURE InsertStudentCourse
    @stdId int,
	@crsId int
with encryption
AS
    INSERT INTO Stu_Crs(stu_id,crs_id)
    VALUES (@stdId, @crsId);

InsertStudentCourse 7,300;
	
--update
CREATE OR ALTER PROCEDURE UpdateStudentCourse
    @stdId int,
	@crsId int,
	@grade int
with encryption
AS
    UPDATE Stu_Crs
    SET grade = @grade
    WHERE stu_id = @stdId and crs_id = @crsId;

UpdateStudentCourse 5,300,90;

--delete
create or alter proc deleteStudentCourse @stdId int, @crsId int
with encryption
as
delete from Stu_Crs where stu_id = @stdId and crs_id = @crsId;

--deleteStudentCourse 5 300

create or alter proc deleteStudentsByCrsId @crsId int
with encryption
as
delete from Stu_Crs where crs_id = @crsId;

--deleteStudentsByCrsId 300


create or alter proc deleteStudentCourseByStdId @stdId int
with encryption
as
delete from Stu_Crs where stu_id = @stdId;

--deleteStudentCourseByStdId 7



 


--instructor Course SP
--select
create or alter proc getInstructorCoursesByInsId @insId int
with encryption
as
select c.crs_title,  ic.start_date ,ic.end_date
from Course c join Ins_Crs ic
on c.crs_id = ic.course_id
where ic.ins_id = @insId;

getInstructorCoursesByInsId 20

create or alter proc getInstructorInCoursesBycrsId @crsId int
with encryption
as
select i.ins_id,i.ins_fname + ' ' + i.ins_lname as 'full name',  ic.start_date , ic.end_date
from Instructor i join Ins_Crs ic
on i.ins_id = ic.ins_id
where ic.course_id = @crsId;

getInstructorInCoursesBycrsId 200

--insert
CREATE OR ALTER PROCEDURE InsertInstractorCourse
    @insId int,
	@crsId int,
	@sDate date = null,
	@eDate date
with encryption
AS
    INSERT INTO Ins_Crs(ins_id,course_id,start_date,end_date)
    VALUES (@insId, @crsId,ISNULL(@sDate,getDate()),@eDate);

InsertInstractorCourse 40,300,null,'3/24/2025';
	
--update
CREATE OR ALTER PROCEDURE UpdateInstructorCourse
    @insId int,
	@crsId int,
	@sDate date,
	@eDate date
with encryption
AS
    UPDATE Ins_Crs
    SET start_date = @sDate,
	end_date = @eDate
    WHERE ins_id = @insId and course_id = @crsId;

UpdateInstructorCourse 40,300,'1/26/2025','2/3/2025';

--delete
create or alter proc deleteInstructorCourse @insId int, @crsId int
with encryption
as
delete from Ins_Crs where ins_id = @insId and course_id = @crsId;

--deleteInstructorCourse 40 300

create or alter proc deleteInstructorsByCrsId @crsId int
with encryption
as
delete from Ins_Crs where course_id = @crsId;

--deleteInstructorCourse 300


create or alter proc deleteInstructorCourseByInsId @insId int
with encryption
as
delete from Ins_Crs where ins_id = @insId;

--deleteInstructorCourse 40





 
-- SP for question table
--select record by id
create proc getQuestionById @id int
with encryption
as
select *
from question q
where q.qId = @id
-- calling
getQuestionById 7
 
--insert stored proc
create  proc insertQuestion @body varchar(max),@Type  varchar(max) ,@mark int ,@course_id int
with encryption
as
begin try
insert into Question ( qbody,qtype,qmark,course_id  )
values (@body,@Type,@mark,@course_id)
end try
begin catch
select 'Error'
end catch
--calling 
insertQuestion 'what is c#','mul',5,200

--update stored proc
create proc updateQuestion @id int, @body varchar(max),@Type  varchar(max) ,@mark int ,@course_id int
with encryption
as
begin try
update Question 
set qbody =@body ,
	qtype =@Type ,
	qmark = @mark ,
	course_id = @course_id
	where qid=@id
end try 
begin catch
select 'error happened'
end catch
--calling
updateQuestion 8,'what is c#','mul',2,200

--delete  stored proc
alter proc deleteQuestion  @id int 
with encryption
as
if   exists (select qId from Question where qId=@id)
delete from Question where qId=@id
else 
select 'this table has a relation ship with another table'
--calling
deleteQuestion 9

--questionAnswers table
--select record by id
create proc getQuestionAnswersById @id int
with encryption
as
select *
from QuestionAnswers qa
where qa.answerId = @id
-- calling
getQuestionAnswersById 1

 --insert stored proc
create  proc insertQuestionAnswers @queID int,@answer varchar(100) ,@isCorrect bit 
with encryption
as
begin try
insert into QuestionAnswers( Question_id,answer, is_Correct )
values (@queID,@answer,@isCorrect)
end try
begin catch
select 'Error'
end catch
--calling 
insertQuestionAnswers 7 ,'true','true'
-- there is a problem in updating table bec of relationships or constrains

--update stored proc
create proc updateQuestionAnswers @id int ,@queID int,@answer varchar(100) ,@isCorrect bit 
with encryption
as
begin try
update QuestionAnswers 
set  Question_id =@queID,
	answer =@answer,
	is_Correct = @isCorrect
	where answerId=@id
end try 
begin catch
select 'error happened'
end catch
--calling
updateQuestionAnswers 1,2,false,false

--delete  stored proc
create proc deleteQuestionAnswers  @id int 
with encryption
as
if   exists (select answerId  from QuestionAnswers where answerId=@id)
delete from QuestionAnswers where answerId=@id
else 
select 'this table has a relation ship with another table'
--calling
deleteQuestionAnswers 43









--ExamQuestions table
--select record by id
create proc getExamQuestionsByCompositeId @id int ,@id2 int
with encryption
as
select *
from ExamQuestions eq
where eq.ex_id = @id and eq.q_id =@id2
-- calling
getExamQuestionsByCompositeId 1,1
 
 --insert stored proc
create  proc insertExamQuestions @id int ,@id2 int
with encryption
as
begin try
insert into ExamQuestions( ex_id,q_id )
values (@id ,@id2)
end try
begin catch
select 'Error'
end catch
--calling 
insertExamQuestions 1,1
--note : values must be not conflicted
 

--delete  stored proc
alter proc deleteExamQuestions @id int ,@id2 int
with encryption
as
begin try
if exists (select 1 from ExamQuestions eq where eq.ex_id =@id and eq.q_id=@id2)
begin
delete from ExamQuestions  where  ex_id =@id and q_id=@id2
    PRINT 'Record deleted successfully';
end
else
    PRINT 'Record doesnt exist';
end try	
begin catch
select 'this table has a relation ship with another table'
end catch

--calling
deleteExamQuestions 2,2











--Std_Ans table
--select record by id
create proc getStd_AnsByCompositeId @id int ,@id2 int ,@id3 int
with encryption
as
select *
from Std_Ans sa
where sa.ex_id = @id and sa.q_id =@id2 and sa.std_id=@id3
-- calling
getStd_AnsByCompositeId 1,1,1
 
 --insert stored proc
	alter PROCEDURE insertStd_Ans 
    @id INT, 
    @id2 INT, 
    @id3 INT, 
    @std_answer INT, 
    @std_score INT
AS
 
    BEGIN TRY
        IF NOT EXISTS (
            SELECT 1 FROM Std_Ans 
            WHERE ex_id = @id AND q_id = @id2 AND std_id = @id3
        )
        BEGIN
       
            INSERT INTO Std_Ans (ex_id, q_id, std_id, std_answer, std_score)
            VALUES (@id, @id2, @id3, @std_answer, @std_score);
            
            select 'Record inserted successfully';
        END
        ELSE
            select 'Error: This record already exists';
    END TRY
    BEGIN CATCH
         
        select 'Insertion failed due to an error';
     
    END CATCH

	--calling
	insertStd_Ans 1,2,2,2,2
 

--delete  stored proc
create proc deleteStd_Ans @id int ,@id2 int ,@id3 int
with encryption
as
begin try
if exists (select 1 from Std_Ans   where    ex_id = @id AND q_id = @id2 AND std_id = @id3)
begin
delete from Std_Ans   WHERE ex_id = @id AND q_id = @id2 AND std_id = @id3
    select 'Record deleted successfully'
end
else
    select 'Record doesnt exist'
end try	
begin catch
select 'this table has a relation ship with another table'
end catch

--calling
deleteStd_Ans 2,2,1




/****************************Stored Procedures OF Exam **********************************/

 

----Exam Generation

create or alter proc GenerateExam   
          @NewExamId  int  output,  @NumOfMCQ int   ,  @NumOfTF int  , @CourseId int , @ExamDuration int , @TotalMark int=0 , @instructorId int
   As
	Begin
	   begin try 
		  begin transaction

				if not exists (select * from course c where c.crs_id=@CourseId )
				  begin
					select 'This Course is not existed ';
					rollback transaction;
					return;
				  end
				
					--Generate Exam
					 insert into Exam ( crs_id, ins_id, exDuration,totalMark )
					 values ( @CourseId ,@instructorId,@ExamDuration,@TotalMark );

					 --return Id that is added newly
					 set @NewExamId=SCOPE_IDENTITY();

					 --Select MCQs
					 insert into ExamQuestions (ex_id,q_id) 
					 select top (@NumOfMCQ) @NewExamId , q.qId
					 from Question q 
					 where q.course_id= @CourseId and q.qType='mul' 
					 order by NEWID();
				  
					 --Select TF Questions
					 insert into ExamQuestions (ex_id,q_id) 
					 select top (@NumOfTF) @NewExamId , q.qId
					 from Question q 
					 where q.course_id= @CourseId and q.qType='tf' 
					 order by NEWID();

					 --calculate total marks of injected question to be the mark of question
					 declare @totalMarks int;
					 select @totalMarks =sum(q.qMark)
					  from Question q
					  join ExamQuestions eq on eq.q_id=q.qId 
					  where eq.ex_id=@NewExamId;
					 
					 --update totalmark of exam
					 update Exam
					  set totalMark= @totalMarks
					  where ex_id=@NewExamId

					 --display exam model
					 select ex.ex_id,
							ex.exDuration,
							ex.totalMark,
							q.*
					 from ExamQuestions eq
					 join Question q on eq.q_id= q.qId
					 join Exam ex on  ex.ex_id=eq.ex_id;

				   
			   commit transaction
		end try 

		begin catch 
		   Rollback transaction;
		   select ERROR_MESSAGE() as 'error message' ;
		end catch
 end

/**testing
declare @GeneratedExamId int;
EXEC GenerateExam 
     @NumOfMCQ =2   ,
	 @NumOfTF =2  ,
	 @CourseId =200 ,
	 @ExamDuration =1 , 
	 @TotalMark =0 ,
	 @instructorId =1,
	 @NewExamId= @GeneratedExamId output;
print 'Generated Exam Id :'+Cast (@GeneratedExamId as nvarchar(max));*/
	   



----submit student Answer stored Procedure
Alter proc  SubmitStudentAnswer   
                    @exam_id int , @Question_id int ,@std_id int ,@Std_Answer int, @std_score int 
 As 
      begin  try 
	    begin transaction
			if not exists(select * from Exam ex where ex.ex_id=@exam_id)
			  begin
				  select'Exam not found !'
			  end

		  else if not exists( select * from Question q where q.qId=@Question_id)
			  begin 
				  select'Question not found !'
			  end

		  else if not exists( select * from Student std where std.stu_id=@std_id)
			  begin 
				  select'student not found !'
			  end

		 else 
			begin
			  insert into Std_Ans(ex_id,q_id,std_id,std_answer)
			  values(@exam_id,@Question_id,@std_id,@Std_Answer)
			end
        commit transaction   
	 end try 

	  begin catch 
	       rollback transaction
	       select ERROR_MESSAGE() as'ErrorMessage'
	  end catch 



/*-testing
 go
 EXEC SubmitStudentAnswer @exam_id =2 , @Question_id =1 ,@std_id =122 ,@Std_Answer =1, @std_score  =0  
 go
 EXEC SubmitStudentAnswer @exam_id =2 , @Question_id =4 ,@std_id =122 ,@Std_Answer =26, @std_score  =0 
 go 
 EXEC SubmitStudentAnswer @exam_id =2 , @Question_id =5 ,@std_id =122 ,@Std_Answer =29, @std_score  =0 
 go 
 EXEC SubmitStudentAnswer @exam_id =2 , @Question_id =8 ,@std_id =122 ,@Std_Answer =35, @std_score  =0 **/ 



--Exam Correction
create or alter proc CorrectSudentExam   @exam_id int , @std_id int  
As
     begin try 
	    begin transaction 
	     
			  if not exists (select * from Exam ex where ex.ex_id = @exam_id )
				   begin 
					 select 'Exam not found!'
					 return;
			  end

			 else if not exists (select * from Student std where std.stu_id= @std_id)
				begin 
				   select 'student not found!'
				   return;
				end 

			 else 
			   begin

			      --update stdAnswers TBL To cal question mark if std answer is true
				   update Std_Ans
				    set std_score= case when sa.std_answer =qa.answerId then q.qMark else 0 end 
			        from Std_Ans sa
				    inner join QuestionAnswers qa on qa.Question_id=sa.q_id and qa.is_Correct=1 and @exam_id=sa.ex_id and sa.std_id=@std_id
				    inner join Question q on q.qId=sa.q_id



			      -- calculate  final exam score
			       Declare @Exam_Score int =0
		           select @Exam_Score=sum(  sa.std_score )
				    from Std_Ans sa 
					where sa.std_id = @std_id and sa.ex_id = @exam_id
				   
				  
				
				  print 'Total mark for Exam no  '+cast(@exam_id as nvarchar )+ ' For student no : '+cast(@std_id as nvarchar )+' is '+ cast(@Exam_Score as nvarchar)

				  --get crs_id for update student grade for course

				  
			declare @crsId int = ( select c.crs_id
				  from Course c join Exam e
				  on c.crs_id = e.crs_id 
				  and e.ex_id = @exam_id);

			     	-- calculate exam grade 
						 update Stu_Crs
						set  grade = @Exam_Score
						where stu_id = @std_id and crs_id = @crsId

			   end
         commit transaction ;
		 --return Total Score of studnet in Exam
         select @Exam_Score as' Exam Score' 
		 --select  sa.std_score as stdscore from Std_Ans sa
	 end try
	 begin catch 
	     rollback transaction 
	     select ERROR_MESSAGE() as 'Error Message '
	end catch


	
/*EXEC CorrectSudentExam  @exam_id =2 , @std_id =122 **/



use Examination_System
/*****the first report ******/

Alter proc StudentInfoByDept
As
    
	begin try
			    select std.*
				from Student std join Department dep
				on std.dept_id=dep.dept_id;


				if @@ROWCOUNT =0
				begin
				  select 'Department  does not exist'as message 
				end
			 
	End try
	begin catch  
	    select ERROR_MESSAGE() as 'Error Message ';
	end catch

--EXEC StudentInfoByDept  @dept_id=2008


	/**************the second report***********/
Alter proc StudentGradesOnCourse  @std_id int 
  As
     
	begin try
	
		   select sc.*
		   from Stu_Crs sc join Course c
		   on sc.crs_id=c.crs_id
		   where sc.stu_id=@std_id 
	   
		   if @@ROWCOUNT =0
		   begin
			 select 'Student  does not exist'as message 
		  end		

			     
	  end try 
	  begin catch 
	    select ERROR_MESSAGE() as 'Error Message';
	  end catch

-- StudentGradesOnCourse 8

/****************The third report ***************/


Alter Proc InstructorCourses   @insId int 
As 
     begin try 

				 select c.crs_title ,count(std_C.stu_id) as 'Student number'
				 from Ins_Crs ins_C join Course c 
				 on c.crs_id=ins_C.course_id 
				 join Stu_Crs std_C on std_C.crs_id=Ins_C.course_id
				 where ins_C.ins_id=@insId
				 group by c.crs_title;

				if @@ROWCOUNT =0
				begin
				  select 'Instructor does not exist'as message 
				end
		  
	 end try
	 begin catch
	      select  ERROR_MESSAGE() as 'error Message';
	 end catch


/****************The fourth report**********************/
create or Alter proc CoursesTopics  @courseId   int 
As  
	  begin try
			    select t.*
			    from Topic t join Course c
				on c.crs_id=t.courseId and @courseId=c.crs_id;

				if @@ROWCOUNT =0
				begin
				  select 'Course id  does not exist'as message 
				end

		  
	  end try 
	  begin catch 
	    select   ERROR_MESSAGE() as 'Error message'
	  end catch


--ExEc CoursesTopics 200


/***********************the fifth report****************************/

create or Alter proc ExamQuestion @examId int 
As
    
	begin try 

			   select  q.qId as 'Question ID',qbody as 'Question text',q.qType as'Question Type',q.qMark as'Question Mark'
			   from Exam ex join ExamQuestions eq
			   on ex.ex_id=eq.ex_id 
			   and ex.ex_id = @examId
			   join Question q
			   on q.qId=eq.q_id
			   
			  if @@ROWCOUNT =0
				begin
				  select 'Exam  does not exist'as message 
				end	
	end try 

	begin catch 
	   select ERROR_MESSAGE() as 'Error Message'
	end catch 


/****************the sixth repot *********************/

create or Alter proc StudentModelAnswer_InExam @examId int , @stdId int
As 
     begin try
		     select sa.q_id as 'Question Id', q.qbody as 'Question text', qa.answer as'student Answer'
			 from Exam ex join Std_Ans sa
			 on ex.ex_id=sa.ex_id 
			 join Question q
			 on sa.q_id = q.qId
			 join QuestionAnswers qa
			 on qa.answerId = sa.std_answer

			 where sa.std_id=@stdId and ex.ex_id=@examId 
			 order by sa.q_id;

			if @@ROWCOUNT =0
			begin
				  select 'Exam or student do not exist'as message 
			end		
	end try 
	

	begin catch 
	  select ERROR_MESSAGE() as 'Error message';
	end catch













 










