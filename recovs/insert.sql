-- Sample data for dbPOLL
-- Darren Goodair
-- CSSE3004 Group F

-- Users
SELECT 'Inserting Users' FROM dual;
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'aidan', 'password', 'aidanrowe@gmail.com', '-27.522299, 153.047111', 'Web User', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'stuart', 'password', 'stuartwsemple@gmail.com', '-27.570477, 152.841729', 'Web User', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'darren', 'password', 'darren.goodair@gmail.com', '-27.53722, 153.078308', 'Poll Master', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'david', 'password', 'd.fairbrother@uq.edu.au', '-27.53722, 153.078308', 'Poll Creator', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'louis', 'password', 'louisstow@gmail.com', '-27.474074, 152.995286', 'Poll Admin', TO_DATE('2011-03-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2011-10-20 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'louiss', 'password', 'louisstow@gmail.com', '-27.474074, 152.995286', 'Poll Admin', TO_DATE('2011-04-18 07:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2011-10-28 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'louissss', 'password', 'louisstow@gmail.com', '-27.474074, 152.995286', 'Poll Admin', TO_DATE('2011-05-18 08:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2011-09-25 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'andy', 'password', 's0956626962@hotmail.com', '-27.498831257455244, 152.9725170135498', 'System Admin', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));

-- Polls
SELECT 'Inserting Polls' FROM dual;
-- pollID = 1
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'General survey', '-27.474074, 152.995286', 'General survey to learn more about yourself', to_date('2011/05/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2011/11/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
	-- questID = 1
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location, chartType, fontColor) values (qseq.nextval, 'MultiResponse_Numeric', 'How old are you?', 1, SYSDATE, 1, 'Times New Roman', '-27.53722, 153.078308', 'pie', 'red');
		-- answerID = 1
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '17-20', 1, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '21-25', 1, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '26+', 1, 'F');
		
		
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location, chartType, fontColor) values (qseq.nextval, 'MultiResponse_Numeric', 'Whats your favourite colour?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308', 'pie', 'blue');
		-- answerID = 4
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Red', 2, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blue', 2, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Geen', 2, 'F');
		
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location, chartType) values (qseq.nextval, 'SingleResponse_Numeric', 'Whats your favourite animal?', 1, SYSDATE, 1, 'Georgia', '-27.53722, 153.078308', 'bar');
		-- answerID = 7
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Dog', 3, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Cat', 3, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Bird', 3, 'F');
		
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location, chartType) values (qseq.nextval, 'MultiResponse_Numeric', 'Are you single?', 1, SYSDATE, 1, 'Verdana', '-27.53722, 153.078308', 'bar');
		-- answerID = 10
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Yes', 4, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'No', 4, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Maybe', 4, 'F');
		
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location, chartType) values (qseq.nextval, 'MultiResponse_Numeric', 'What phone do you have?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308', 'bar');
		-- answerID = 13
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Nothing', 5, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'iPhone', 5, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Android', 5, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Other', 5, 'F');
		
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location, chartType) values (qseq.nextval, 'MultiResponse_Numeric', 'Boxers or briefs?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308', 'column');
		-- answerID = 17
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Boxers', 6, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Briefs', 6, 'F');
		
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location, chartType) values (qseq.nextval, 'MultiResponse_Numeric', 'Whats your hair colour?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308', 'column');
		-- answerID = 19
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Red', 7, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blue', 7, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Green', 7, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Black', 7, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blonde', 7, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Brown', 7, 'F');
		
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'MultiResponse_Numeric', 'Whats my name?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308');
		-- answerID = 25
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Stuart', 8, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Aidan', 8, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'David', 8, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Louis', 8, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Andy', 8, 'F');
		
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'MultiResponse_Numeric', 'What is your gender?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308');
		-- answerID = 30
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Male', 9, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Female', 9, 'F');
		
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'MultiResponse_Numeric', 'What is your occupation?', 1, SYSDATE, 1, 'Impact', '-27.53722, 153.078308');
		-- answerID = 32
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Dentist', 10, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Doctor', 10, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'IT', 10, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Fireman', 10, 'F');
	
-- pollID = 2
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Movie Poll 1', '-27.474074, 152.995286', 'Quick poll to work out your favourite movies', to_date('2009/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2012/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, images, location, chartType) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Which Star Wars movies do you like?', 2, SYSDATE, 1, 'images/q/sw.png', '-27.53722, 153.078308', 'pie');
		-- answerID = 36
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 1', 11, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 2', 11, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 3', 11, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 4', 11, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 5', 11, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 6', 11, 'T');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, images, location, chartType) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Favourite LOTR movie?', 2, SYSDATE, 1, 'images/q/lotr.jpg', '-27.53722, 153.078308', 'column');
		-- answerID = 42
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'The Fellowship of the Ring', 12, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'The Two Towers', 12, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'The Return of the King', 12, 'F');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, images, location, chartType) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Favourite Back to the Future movie?', 2, SYSDATE, 1, 'images/q/bttf.jpg', '-27.53722, 153.078308', 'bar');
		-- answerID = 45
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'I', 13, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'II', 13, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'III', 13, 'T');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, location) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Favourite Godfather movie?', 2, SYSDATE, 1, '-27.53722, 153.078308');
		-- answerID = 48
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 1', 14, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 2', 14, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 3', 14, 'F');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, location) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'What genres do you enjoy?', 2, SYSDATE, 1, '-27.53722, 153.078308');
		-- answerID = 51
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Action', 15, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Drama', 15, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'SciFi', 15, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Romance', 15, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Horror', 15, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Comedy', 15, 'F');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, location) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Which disney films have you seen?', 2, SYSDATE, 1, '-27.53722, 153.078308');
		-- answerID = 57
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Moulin', 16, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Snow white and thre seven dwarves', 16, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Batman', 16, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Little Mermaid', 16, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'The new spiderman movie', 16, 'F');
		
-- pollID = 3
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Basic Mathematics', '-27.474074, 152.995286', 'Simple test to work out the mathemtical skill level of students.', to_date('2009/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2012/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'F', 'sr-num', '1+1=?', 3, SYSDATE, 3, 'Times New Roman', '-27.53722, 153.078308');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'F', 'sr-num', '2+1=?', 3, SYSDATE, 3, 'Times New Roman', '-27.53722, 153.078308');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'F', 'sr-num', '5+1=?', 3, SYSDATE, 3, 'Times New Roman', '-27.53722, 153.078308');
	

-- polls Past
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Video Game Survery', '-27.474074, 152.995286', 'Survey on video games played by youths.', to_date('2009/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2010/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Movie Quiz 2', '-27.474074, 152.995286', 'Second part in an epic tale about movie quizes.', to_date('2009/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2010/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Basic Spelling', '-27.474074, 152.995286', 'Are you smarter than a fifth grader?', to_date('2009/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2010/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));

-- polls Future
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Another Quiz', '-27.474074, 152.995286', 'Yet another quiz.', to_date('2029/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2030/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Advanced History', '-27.474074, 152.995286', 'Information from WW1 to WW2.', to_date('2029/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2030/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Ancient History AB3', '-27.474074, 152.995286', 'Who were the ancient Egyptians?', to_date('2029/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2032/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));

SELECT 'Inserting Polls' FROM dual;
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'General survey', 'Brisbane', 'A general survey to get to know all the subjects.', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2011-03-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Movie information', 'Taipei', 'A Poll to determine movie information.', TO_DATE('2010-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Basic Mathematics', 'New York', 'Simple test to work out the mathemtical skill level of students.', TO_DATE('2012-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2013-03-21 23:42:21', 'YYYY-MM-DD HH24:MI:SS'));

-- Andy Questions
SELECT 'Inserting Questions' FROM dual;
--20
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, correctIndicator) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'How old are you?', 10, SYSDATE, 1, 'Comic Sans MS', 'dicks.png');

--Answer--62~64
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '17-20', 20, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '21-25', 20, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '26+', 20, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,20,62);
		INSERT into MultiResponses(userID, questID, answerID) values (7,20,62);
		INSERT into MultiResponses(userID, questID, answerID) values (2,20,64);
		INSERT into MultiResponses(userID, questID, answerID) values (6,20,62);
		INSERT into MultiResponses(userID, questID, answerID) values (1,20,62);
		INSERT into MultiResponses(userID, questID, answerID) values (5,20,63);
		INSERT into MultiResponses(userID, questID, answerID) values (3,20,64);
		INSERT into MultiResponses(userID, questID, answerID) values (4,20,63);

--21
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, correctIndicator) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Whats your favourite colour?', 10, SYSDATE, 1, 'Comic Sans MS', 'dicks.png');

--Answer--65~67
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Red', 21, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blue', 21, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Geen', 21, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,21,65);
		INSERT into MultiResponses(userID, questID, answerID) values (7,21,65);
		INSERT into MultiResponses(userID, questID, answerID) values (2,21,66);
		INSERT into MultiResponses(userID, questID, answerID) values (6,21,65);
		INSERT into MultiResponses(userID, questID, answerID) values (1,21,66);
		INSERT into MultiResponses(userID, questID, answerID) values (5,21,67);
		INSERT into MultiResponses(userID, questID, answerID) values (3,21,67);
		INSERT into MultiResponses(userID, questID, answerID) values (4,21,67);

--22
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, correctIndicator) values (qseq.nextval, 'F', 'SingleResponse_Numeric', 'How was your day?', 10, SYSDATE, 1, 'Comic Sans MS', 'dicks.png');

--Answer--68~70
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Dog', 22, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Cat', 22, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Bird', 22, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,22,68);
		INSERT into MultiResponses(userID, questID, answerID) values (7,22,68);
		INSERT into MultiResponses(userID, questID, answerID) values (2,22,68);
		INSERT into MultiResponses(userID, questID, answerID) values (6,22,69);
		INSERT into MultiResponses(userID, questID, answerID) values (1,22,69);
		INSERT into MultiResponses(userID, questID, answerID) values (5,22,69);
		INSERT into MultiResponses(userID, questID, answerID) values (3,22,70);
		INSERT into MultiResponses(userID, questID, answerID) values (4,22,69);

--23
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, correctIndicator) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Favourite Star Wars movie?', 11, SYSDATE, 1, 'vaginas.png');

--Answer--71~76
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 1', 23, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 2', 23, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 3', 23, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 4', 23, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 5', 23, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 6', 23, 'T');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,23,76);
		INSERT into MultiResponses(userID, questID, answerID) values (7,23,76);
		INSERT into MultiResponses(userID, questID, answerID) values (2,23,75);
		INSERT into MultiResponses(userID, questID, answerID) values (6,23,74);
		INSERT into MultiResponses(userID, questID, answerID) values (1,23,73);
		INSERT into MultiResponses(userID, questID, answerID) values (5,23,73);
		INSERT into MultiResponses(userID, questID, answerID) values (3,23,72);
		INSERT into MultiResponses(userID, questID, answerID) values (4,23,71);
		
--24
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, correctIndicator) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Favourite LOTR movie?', 11, SYSDATE, 1, 'vaginas.png');

--Answer--77~79
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '1', 24, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '2', 24, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '3', 24, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,24,77);
		INSERT into MultiResponses(userID, questID, answerID) values (7,24,77);
		INSERT into MultiResponses(userID, questID, answerID) values (2,24,78);
		INSERT into MultiResponses(userID, questID, answerID) values (6,24,78);
		INSERT into MultiResponses(userID, questID, answerID) values (1,24,79);
		INSERT into MultiResponses(userID, questID, answerID) values (5,24,79);
		INSERT into MultiResponses(userID, questID, answerID) values (3,24,79);
		INSERT into MultiResponses(userID, questID, answerID) values (4,24,79);
--25
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, correctIndicator) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Favourite Back to the Future movie?', 11, SYSDATE, 1, 'vaginas.png');

--Answer--80~82
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'I', 25, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'II', 25, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'III', 25, 'T');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,25,82);
		INSERT into MultiResponses(userID, questID, answerID) values (7,25,82);
		INSERT into MultiResponses(userID, questID, answerID) values (2,25,81);
		INSERT into MultiResponses(userID, questID, answerID) values (6,25,82);
		INSERT into MultiResponses(userID, questID, answerID) values (1,25,81);
		INSERT into MultiResponses(userID, questID, answerID) values (5,25,80);
		INSERT into MultiResponses(userID, questID, answerID) values (3,25,80);
		INSERT into MultiResponses(userID, questID, answerID) values (4,25,80);

--26
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font) values (qseq.nextval, 'F', 'sr-num', '1+1=?', 12, SYSDATE, 3, 'Times New Roman');

--Answer--83~85
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '1', 26, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '2', 26, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '3', 26, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,26,84);
		INSERT into MultiResponses(userID, questID, answerID) values (7,26,85);
		INSERT into MultiResponses(userID, questID, answerID) values (2,26,84);
		INSERT into MultiResponses(userID, questID, answerID) values (6,26,84);
		INSERT into MultiResponses(userID, questID, answerID) values (1,26,84);
		INSERT into MultiResponses(userID, questID, answerID) values (5,26,83);
		INSERT into MultiResponses(userID, questID, answerID) values (3,26,83);
		INSERT into MultiResponses(userID, questID, answerID) values (4,26,83);
--27
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font) values (qseq.nextval, 'F', 'sr-num', '2+1=?', 12, SYSDATE, 3, 'Times New Roman');

--Answer--86~88
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '1', 27, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '2', 27, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '3', 27, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,27,88);
		INSERT into MultiResponses(userID, questID, answerID) values (7,27,87);
		INSERT into MultiResponses(userID, questID, answerID) values (2,27,87);
		INSERT into MultiResponses(userID, questID, answerID) values (6,27,87);
		INSERT into MultiResponses(userID, questID, answerID) values (1,27,87);
		INSERT into MultiResponses(userID, questID, answerID) values (5,27,87);
		INSERT into MultiResponses(userID, questID, answerID) values (3,27,86);
		INSERT into MultiResponses(userID, questID, answerID) values (4,27,86);
--28
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font) values (qseq.nextval, 'F', 'sr-num', '5+1=?', 12, SYSDATE, 3, 'Times New Roman');

--Answer--89~91
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '4', 28, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '5', 28, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '6', 28, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,28,89);
		INSERT into MultiResponses(userID, questID, answerID) values (7,28,89);
		INSERT into MultiResponses(userID, questID, answerID) values (2,28,89);
		INSERT into MultiResponses(userID, questID, answerID) values (6,28,89);
		INSERT into MultiResponses(userID, questID, answerID) values (1,28,90);
		INSERT into MultiResponses(userID, questID, answerID) values (5,28,90);
		INSERT into MultiResponses(userID, questID, answerID) values (3,28,91);
		INSERT into MultiResponses(userID, questID, answerID) values (4,28,90);
--29
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, fontColor) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Are you single?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');

--Answer--92~94
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Yes', 29, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'No', 29, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Maybe', 29, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,29,92);
		INSERT into MultiResponses(userID, questID, answerID) values (7,29,92);
		INSERT into MultiResponses(userID, questID, answerID) values (2,29,92);
		INSERT into MultiResponses(userID, questID, answerID) values (6,29,93);
		INSERT into MultiResponses(userID, questID, answerID) values (1,29,93);
		INSERT into MultiResponses(userID, questID, answerID) values (5,29,94);
		INSERT into MultiResponses(userID, questID, answerID) values (3,29,94);
		INSERT into MultiResponses(userID, questID, answerID) values (4,29,94);
--30
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, fontColor) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'What are you wearing??', 10, SYSDATE, 1, 'Comic Sans MS', 'red');

--Answer--95~98
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Nothing', 30, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Everything', 30, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'A Dress', 30, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'No socks', 30, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,30,96);
		INSERT into MultiResponses(userID, questID, answerID) values (7,30,98);
		INSERT into MultiResponses(userID, questID, answerID) values (2,30,98);
		INSERT into MultiResponses(userID, questID, answerID) values (6,30,97);
		INSERT into MultiResponses(userID, questID, answerID) values (1,30,96);
		INSERT into MultiResponses(userID, questID, answerID) values (5,30,95);
		INSERT into MultiResponses(userID, questID, answerID) values (3,30,95);
		INSERT into MultiResponses(userID, questID, answerID) values (4,30,95);
--31
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, fontColor) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Do you wear undies?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');

--Answer--99~100
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Yes', 31, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'No', 31, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,31,99);
		INSERT into MultiResponses(userID, questID, answerID) values (7,31,99);
		INSERT into MultiResponses(userID, questID, answerID) values (2,31,99);
		INSERT into MultiResponses(userID, questID, answerID) values (6,31,100);
		INSERT into MultiResponses(userID, questID, answerID) values (1,31,100);
		INSERT into MultiResponses(userID, questID, answerID) values (5,31,100);
		INSERT into MultiResponses(userID, questID, answerID) values (3,31,100);
		INSERT into MultiResponses(userID, questID, answerID) values (4,31,100);
--32
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, fontColor) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Whats your hair colour?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');

--Answer--101~106
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Red', 32, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blue', 32, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Green', 32, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Black', 32, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blonde', 32, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Brown', 32, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,32,106);
		INSERT into MultiResponses(userID, questID, answerID) values (7,32,105);
		INSERT into MultiResponses(userID, questID, answerID) values (2,32,106);
		INSERT into MultiResponses(userID, questID, answerID) values (6,32,104);
		INSERT into MultiResponses(userID, questID, answerID) values (1,32,103);
		INSERT into MultiResponses(userID, questID, answerID) values (5,32,102);
		INSERT into MultiResponses(userID, questID, answerID) values (3,32,101);
		INSERT into MultiResponses(userID, questID, answerID) values (4,32,101);

--33
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, fontColor) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Whats my name?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');

--Answer--107~111
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Red', 33, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Aidan', 33, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'David', 33, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Louis', 33, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Andy', 33, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,33,110);
		INSERT into MultiResponses(userID, questID, answerID) values (7,33,110);
		INSERT into MultiResponses(userID, questID, answerID) values (2,33,109);
		INSERT into MultiResponses(userID, questID, answerID) values (6,33,108);
		INSERT into MultiResponses(userID, questID, answerID) values (1,33,109);
		INSERT into MultiResponses(userID, questID, answerID) values (5,33,108);
		INSERT into MultiResponses(userID, questID, answerID) values (3,33,107);
		INSERT into MultiResponses(userID, questID, answerID) values (4,33,107);

--34
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Favourite Godfather movie?', 11, SYSDATE, 1);

--Answer--112~114
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 1', 34, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 2', 34, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 3', 34, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,34,112);
		INSERT into MultiResponses(userID, questID, answerID) values (7,34,114);
		INSERT into MultiResponses(userID, questID, answerID) values (2,34,114);
		INSERT into MultiResponses(userID, questID, answerID) values (6,34,112);
		INSERT into MultiResponses(userID, questID, answerID) values (1,34,113);
		INSERT into MultiResponses(userID, questID, answerID) values (5,34,113);
		INSERT into MultiResponses(userID, questID, answerID) values (3,34,112);
		INSERT into MultiResponses(userID, questID, answerID) values (4,34,112);
--35
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'What genres do you enjoy?', 11, SYSDATE, 1);

--Answer--115~120
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Action', 35, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Drama', 35, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'SciFi', 35, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Romance', 35, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Horror', 35, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Comedy', 35, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,35,120);
		INSERT into MultiResponses(userID, questID, answerID) values (7,35,120);
		INSERT into MultiResponses(userID, questID, answerID) values (2,35,118);
		INSERT into MultiResponses(userID, questID, answerID) values (6,35,117);
		INSERT into MultiResponses(userID, questID, answerID) values (1,35,116);
		INSERT into MultiResponses(userID, questID, answerID) values (5,35,116);
		INSERT into MultiResponses(userID, questID, answerID) values (3,35,115);
		INSERT into MultiResponses(userID, questID, answerID) values (4,35,115);

--36
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'MultiResponse_Numeric', 'Which disney films have you seen?', 11, SYSDATE, 1);

--Answer--121~125
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Moulin', 36, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Snow white and thre seven dwarves', 36, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Batman', 36, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Little Mermaid', 36, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'The new spiderman movie', 36, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,36,121);
		INSERT into MultiResponses(userID, questID, answerID) values (7,36,121);
		INSERT into MultiResponses(userID, questID, answerID) values (2,36,122);
		INSERT into MultiResponses(userID, questID, answerID) values (6,36,123);
		INSERT into MultiResponses(userID, questID, answerID) values (1,36,124);
		INSERT into MultiResponses(userID, questID, answerID) values (5,36,125);
		INSERT into MultiResponses(userID, questID, answerID) values (3,36,123);
		INSERT into MultiResponses(userID, questID, answerID) values (4,36,124);
--37--
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, fontColor) values (qseq.nextval, 'T', 'MultiResponse_Numeric', 'What is your gender?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');

--Answer--126~127
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Male', 37, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Female', 37, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,37,126);
		INSERT into MultiResponses(userID, questID, answerID) values (7,37,127);
		INSERT into MultiResponses(userID, questID, answerID) values (2,37,126);
		INSERT into MultiResponses(userID, questID, answerID) values (6,37,126);
		INSERT into MultiResponses(userID, questID, answerID) values (1,37,127);
		INSERT into MultiResponses(userID, questID, answerID) values (5,37,126);
		INSERT into MultiResponses(userID, questID, answerID) values (3,37,126);
		INSERT into MultiResponses(userID, questID, answerID) values (4,37,127);
--38
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, fontColor) values (qseq.nextval, 'T', 'MultiResponse_Numeric', 'What is your occupation?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');

--Answer--128~131
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Dentist', 38, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Doctor', 38, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'IT', 38, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Fireman', 38, 'F');
--Response--
		INSERT into MultiResponses(userID, questID, answerID) values (8,38,130);
		INSERT into MultiResponses(userID, questID, answerID) values (7,38,131);
		INSERT into MultiResponses(userID, questID, answerID) values (2,38,131);
		INSERT into MultiResponses(userID, questID, answerID) values (6,38,129);
		INSERT into MultiResponses(userID, questID, answerID) values (1,38,130);
		INSERT into MultiResponses(userID, questID, answerID) values (5,38,130);
		INSERT into MultiResponses(userID, questID, answerID) values (3,38,128);
		INSERT into MultiResponses(userID, questID, answerID) values (4,38,128);


------------------------------


-- Assin users to polls
SELECT 'Assigning users to Polls' FROM dual;

INSERT into Assigned(userID, pollID, role) values (1, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (1, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (1, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (1, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (1, 5, 'Web User');
INSERT into Assigned(userID, pollID, role) values (1, 6, 'Web User');
INSERT into Assigned(userID, pollID, role) values (1, 7, 'Web User');
INSERT into Assigned(userID, pollID, role) values (1, 8, 'Web User');
INSERT into Assigned(userID, pollID, role) values (1, 9, 'Web User');
--INSERT into Assigned(userID, pollID, role) values (1, 10, 'Web User');

INSERT into Assigned(userID, pollID, role) values (2, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 5, 'Web User');
--INSERT into Assigned(userID, pollID, role) values (2, 6, 'Web User');
--INSERT into Assigned(userID, pollID, role) values (2, 7, 'Web User');
--INSERT into Assigned(userID, pollID, role) values (2, 8, 'Web User');
--INSERT into Assigned(userID, pollID, role) values (2, 9, 'Web User');
--INSERT into Assigned(userID, pollID, role) values (2, 10, 'Poll Master');

INSERT into Assigned(userID, pollID, role) values (3, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 5, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 6, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 7, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 8, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 9, 'Web User');
--INSERT into Assigned(userID, pollID, role) values (3, 10, 'Web User');

INSERT into Assigned(userID, pollID, role) values (4, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 5, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 6, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 7, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 8, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 9, 'Web User');
--INSERT into Assigned(userID, pollID, role) values (4, 10, 'Web User');

INSERT into Assigned(userID, pollID, role) values (5, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 5, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 6, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 7, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 8, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 9, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 10, 'Poll Master');

INSERT into Assigned(userID, pollID, role) values (6, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (6, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (6, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (6, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (6, 5, 'Web User');
INSERT into Assigned(userID, pollID, role) values (6, 6, 'Web User');
INSERT into Assigned(userID, pollID, role) values (6, 7, 'Web User');
INSERT into Assigned(userID, pollID, role) values (6, 8, 'Web User');
INSERT into Assigned(userID, pollID, role) values (6, 9, 'Web User');
INSERT into Assigned(userID, pollID, role) values (6, 10, 'Web User');

INSERT into Assigned(userID, pollID, role) values (7, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (7, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (7, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (7, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (7, 5, 'Web User');
INSERT into Assigned(userID, pollID, role) values (7, 6, 'Web User');
INSERT into Assigned(userID, pollID, role) values (7, 7, 'Web User');
INSERT into Assigned(userID, pollID, role) values (7, 8, 'Web User');
INSERT into Assigned(userID, pollID, role) values (7, 9, 'Web User');
INSERT into Assigned(userID, pollID, role) values (7, 10, 'Web User');

INSERT into Assigned(userID, pollID, role) values (8, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (8, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (8, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (8, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (8, 5, 'Web User');
INSERT into Assigned(userID, pollID, role) values (8, 6, 'Web User');
INSERT into Assigned(userID, pollID, role) values (8, 7, 'Web User');
INSERT into Assigned(userID, pollID, role) values (8, 8, 'Web User');
INSERT into Assigned(userID, pollID, role) values (8, 9, 'Web User');
INSERT into Assigned(userID, pollID, role) values (8, 10, 'Web User');


INSERT into Responses(userID, questID) values (2, 37);
INSERT into Responses(userID, questID) values (3, 37);
INSERT into Responses(userID, questID) values (4, 37);
INSERT into Responses(userID, questID) values (5, 37);
INSERT into Responses(userID, questID) values (6, 37);

INSERT into Responses(userID, questID) values (2, 38);
INSERT into Responses(userID, questID) values (3, 38);
INSERT into Responses(userID, questID) values (4, 38);
INSERT into Responses(userID, questID) values (5, 38);
INSERT into Responses(userID, questID) values (6, 38);

INSERT into Attendance(pollID, userID, location, lastModified) values(10, 1, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(10, 2, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(10, 3, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(10, 4, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(10, 5, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(10, 6, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(10, 7, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(10, 8, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(11, 1, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(11, 2, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(11, 3, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(11, 4, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(12, 1, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(12, 2, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(12, 3, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(12, 4, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(12, 5, '-27.498831257455244, 152.9725170135498', SYSDATE);
INSERT into Attendance(pollID, userID, location, lastModified) values(12, 6, '-27.498831257455244, 152.9725170135498', SYSDATE);

INSERT into Assigned(userID, pollID, role) values (1, 10, 'Poll Creator');
INSERT into Assigned(userID, pollID, role) values (4, 10, 'Poll Master');
INSERT into Assigned(userID, pollID, role) values (2, 10, 'Poll Master');
INSERT into Assigned(userID, pollID, role) values (3, 11, 'Poll Master');
INSERT into Assigned(userID, pollID, role) values (5, 11, 'Poll Master');
INSERT into Assigned(userID, pollID, role) values (4, 11, 'Poll Creator');
INSERT into Assigned(userID, pollID, role) values (1, 12, 'Poll Creator');
INSERT into Assigned(userID, pollID, role) values (2, 12, 'Poll Master');

-- Add widgets to the DB
SELECT 'Adding widgets' FROM dual;
INSERT into Widgets(widgetID, widgetName, widgetDescription) values (wseq.nextval, 'timer', '10');

-- Assign widgets to question
SELECT 'Assigning wigdget to question' FROM dual;
INSERT into QuestionWidgets(questID, widgetID) values (1, 1);
INSERT into QuestionWidgets(questID, widgetID) values (2, 1);
INSERT into QuestionWidgets(questID, widgetID) values (3, 1);
INSERT into QuestionWidgets(questID, widgetID) values (4, 1);

--Davids
INSERT INTO Polls(PollID, PollName) VALUES (pseq.nextval, 'CSSE3004 week one poll');
INSERT INTO Polls(PollID, PollName) VALUES (pseq.nextval, 'Animal poll');
INSERT INTO Polls(PollID, PollName) VALUES (pseq.nextval, 'Polar bear poll');

INSERT INTO PollCreatorLink(PollID, UserID) VALUES (13, 4);
INSERT INTO PollCreatorLink(PollID, UserID) VALUES (14, 4);
INSERT INTO PollCreatorLink(PollID, UserID) VALUES (15, 4);
INSERT INTO PollCreatorLink(PollID, UserID) VALUES (3, 4);
INSERT INTO PollCreatorLink(PollID, UserID) VALUES (1, 4);

INSERT INTO PollAdmins(Username) VALUES ('andy');
INSERT INTO PollAdmins(Username) VALUES ('stuart');
INSERT INTO PollAdmins(Username) VALUES ('louiss');
INSERT INTO PollAdmins(Username) VALUES ('david');
--

commit;