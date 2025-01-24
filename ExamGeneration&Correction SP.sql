
/****************************Stored Procedures OF Exam **********************************/

use Examination_System

----Exam Generation

Alter proc GenerateExam   
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
					 insert into ExamQuestion (ex_id,q_id) 
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
Alter proc CorrectSudentExam   @exam_id int , @std_id int  
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
		           select @Exam_Score=sum(  sa.std_answer )
				    from Std_Ans sa
				   
				  
				
				  print 'Total mark for Exam no  '+cast(@exam_id as nvarchar )+ ' For student no : '+cast(@std_id as nvarchar )+' is '+ cast(@Exam_Score as nvarchar)



			     	-- calculate exam grade 
						 update Stu_Crs
						set  grade+= @Exam_Score

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


 