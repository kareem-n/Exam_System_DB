

use Examination_System

/***************************Course Table*****************************/

--Select Course
create proc SelectCourseSp 
 As
   select * 
   from Course

--insert Course
create proc InsertCourseSP 
         @course_id int , @Course_Name nvarchar(max), @c_durtion int , @c_description nvarchar(max), @topic_id int
As
   insert into Course (crs_id,crs_title,crs_duration,crs_description,topic_id)   
   values(@course_id , @Course_Name, @c_durtion  , @c_description , @topic_id )

 
 --delete course 
 create proc DeleteCourseSp   @course_id int
 As
    Delete from Course 
	where crs_id=@course_id

 -- update Course name
 create proc UpdateCourseName 
           @course_id int , @Course_Name nvarchar(max)
 As
         update Course
		 set crs_title=@Course_Name
		 where crs_id=@course_id

-- update Course description
 create proc UpdateCourseDescription 
           @course_id int , @c_description nvarchar(max)
 As
         update Course
		 set crs_description=@c_description
		 where crs_id=@course_id

-- update Course topic
 create proc UpdateCourseTopic 
           @course_id int ,  @topic_id int
 As
         update Course
		 set topic_id= @topic_id 
		 where crs_id=@course_id

--update course duration
 create proc UpdateCourseDuration
           @course_id int ,  @c_durtion int
 As
         update Course
		 set crs_duration=  @c_durtion 
		 where crs_id=@course_id

 --************************************Topic Table******************************--
 --selct topic 
 create proc SelectTopicSP 
 As 
    select * from Topic

-- insert topic 
create proc InsertTopicSP
      @topicId int ,  @TopicName nvarchar(max)
As
   insert into Topic (topic_id,topic_name)
   values (@topicId,@TopicName)

--delete topic 
 create proc DeleteTopicSP  @topicId int 
 As
     delete from Topic 
	 where topic_id=@topicId


--update Topic Name
 create proc UpdateTopicName  @topicid int, @topicName nvarchar(max)
 As   
    update Topic
	set topic_name=@topicName






  