-- Sample data for dbPOLL
-- Darren Goodair
-- CSSE3004 Group F

-- Users
SELECT 'Inserting Users' FROM dual;
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'aidan', 'password1', 'aidanrowe@gmail.com', '-27.522299, 153.047111', 'Key User', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'stuart', 'pass', 'stuartwsemple@gmail.com', '-27.570477, 152.841729', 'Web User', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'darren', 'test', 'darren.goodair@gmail.com', '-27.53722, 153.078308', 'Poll Master', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'david', 'p4ss', 'd.fairbrother@uq.edu.au', '-27.53722, 153.078308', 'Poll Creator', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'louis', 'p00', 'louisstow@gmail.com', '-27.474074, 152.995286', 'Poll Admin', TO_DATE('2011-03-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2011-09-20 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'louiss', 'p00', 'louisstow@gmail.com', '-27.474074, 152.995286', 'Poll Admin', TO_DATE('2011-04-18 07:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2011-08-28 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'louissss', 'p00', 'louisstow@gmail.com', '-27.474074, 152.995286', 'Poll Admin', TO_DATE('2011-05-18 08:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2011-09-25 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Users(userID, userName, password, email, location, userLevel, created, expired) values (useq.nextval, 'andy', 'poo', 's0956626962@hotmail.com', '-27.498831257455244, 152.9725170135498', 'System Admin', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));

-- Polls
SELECT 'Inserting Polls' FROM dual;
-- pollID = 1
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'General survey', '-27.474074, 152.995286', 'General survey to learn more about yourself', to_date('2011/05/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2011/09/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
	-- questID = 1
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'mp-single', 'How old are you?', 1, SYSDATE, 1, 'Times New Roman', '-27.53722, 153.078308');
		-- answerID = 1
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '17-20', 1, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '21-25', 1, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '26+', 1, 'F');
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'mp-single', 'Whats your favourite colour?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308');
		-- answerID = 4
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Red', 2, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blue', 2, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Geen', 2, 'F');
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'sr-alphanum', 'Whats your favourite animal?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308');
		-- answerID = 7
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Dog', 3, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Cat', 3, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Bird', 3, 'F');
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'mp-single', 'Are you single?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308');
		-- answerID = 10
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Yes', 4, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'No', 4, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Maybe', 4, 'F');
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'mp-single', 'What are you wearing?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308');
		-- answerID = 13
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Nothing', 5, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Everything', 5, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'A Dress', 5, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'No socks', 5, 'F');
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'mp-single', 'Do you wear undies?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308');
		-- answerID = 17
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Yes', 6, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'No', 6, 'F');
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'mp-single', 'Whats your hair colour?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308');
		-- answerID = 19
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Red', 7, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blue', 7, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Green', 7, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Black', 7, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blonde', 7, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Brown', 7, 'F');
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'mp-single', 'Whats my name?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308');
		-- answerID = 25
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Red', 8, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Aidan', 8, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'David', 8, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Louis', 8, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Andy', 8, 'F');
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'mp-single', 'What is your gender?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308');
		-- answerID = 30
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Male', 9, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Female', 9, 'F');
	INSERT into Questions(questID, responseType, question, pollID, created, creator, font, location) values (qseq.nextval, 'mp-single', 'What is your occupation?', 1, SYSDATE, 1, 'Comic Sans MS', '-27.53722, 153.078308');
		-- answerID = 32
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Dentist', 10, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Doctor', 10, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'IT', 10, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Fireman', 10, 'F');
	
-- pollID = 2
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Movie Poll 1', '-27.474074, 152.995286', 'Quick poll to work out your favourite movies', to_date('2009/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2012/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, images, location) values (qseq.nextval, 'F', 'mp-multiple', 'Which Star Wars movies do you like?', 2, SYSDATE, 1, '/images/q/sw.png', '-27.53722, 153.078308');
		-- answerID = 36
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 1', 11, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 2', 11, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 3', 11, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 4', 11, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 5', 11, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 6', 11, 'T');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, images, location) values (qseq.nextval, 'F', 'mp-single', 'Favourite LOTR movie?', 2, SYSDATE, 1, '/images/q/lotr.jpg', '-27.53722, 153.078308');
		-- answerID = 42
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'The Fellowship of the Ring', 12, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'The Two Towers', 12, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'The Return of the King', 12, 'F');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, images, location) values (qseq.nextval, 'F', 'mp-single', 'Favourite Back to the Future movie?', 2, SYSDATE, 1, '/images/q/bttf.jpg', '-27.53722, 153.078308');
		-- answerID = 45
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'I', 13, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'II', 13, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'III', 13, 'T');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, location) values (qseq.nextval, 'F', 'mp-single', 'Favourite Godfather movie?', 2, SYSDATE, 1, '-27.53722, 153.078308');
		-- answerID = 48
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 1', 14, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 2', 14, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 3', 14, 'F');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, location) values (qseq.nextval, 'F', 'mp-multiple', 'What genres do you enjoy?', 2, SYSDATE, 1, '-27.53722, 153.078308');
		-- answerID = 51
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Action', 15, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Drama', 15, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'SciFi', 15, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Romance', 15, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Horror', 15, 'F');
		INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Comedy', 15, 'F');
	INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, location) values (qseq.nextval, 'F', 'mp-multiple', 'Which disney films have you seen?', 2, SYSDATE, 1, '-27.53722, 153.078308');
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
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'General survey2', '-27.474074, 152.995286', 'A general survey to get to know all the subjects.', to_date('2009/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2010/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Movie information2', '-27.474074, 152.995286', 'A Poll to determine movie information.', to_date('2009/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2010/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Basci Mathematics2', '-27.474074, 152.995286', 'Simple test to work out the mathemtical skill level of students.', to_date('2009/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2010/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));

-- polls Future
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'General survey3', '-27.474074, 152.995286', 'A general survey to get to know all the subjects.', to_date('2029/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2030/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Movie information3', '-27.474074, 152.995286', 'A Poll to determine movie information.', to_date('2029/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2030/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Basci Mathematics3', '-27.474074, 152.995286', 'Simple test to work out the mathemtical skill level of students.', to_date('2029/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'), to_date('2032/08/12 12:00:00', 'yyyy-mm-dd HH24:MI:SS'));

SELECT 'Inserting Polls' FROM dual;
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'General survey', 'Brisbane', 'A general survey to get to know all the subjects.', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2011-03-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Movie information', 'Taipei', 'A Poll to determine movie information.', TO_DATE('2010-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT into Polls(pollID, pollName, location, description, startDate, finishDate) values (pseq.nextval, 'Basci Mathematics', 'New York', 'Simple test to work out the mathemtical skill level of students.', TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2013-03-21 23:42:21', 'YYYY-MM-DD HH24:MI:SS'));

-- Andy Questions
SELECT 'Inserting Questions' FROM dual;
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, correctIndicator) values (qseq.nextval, 'F', 'mp-single', 'How old are you?', 10, SYSDATE, 1, 'Comic Sans MS', 'dicks.png');
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, correctIndicator) values (qseq.nextval, 'F', 'mp-single', 'Whats your favourite colour?', 10, SYSDATE, 1, 'Comic Sans MS', 'dicks.png');
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, correctIndicator) values (qseq.nextval, 'F', 'sr-alphanum', 'How was your day?', 10, SYSDATE, 1, 'Comic Sans MS', 'dicks.png');

INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, correctIndicator) values (qseq.nextval, 'F', 'mp-multiple', 'Favourite Star Wars movie?', 11, SYSDATE, 1, 'vaginas.png');
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, correctIndicator) values (qseq.nextval, 'F', 'mp-single', 'Favourite LOTR movie?', 11, SYSDATE, 1, 'vaginas.png');
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, correctIndicator) values (qseq.nextval, 'F', 'mp-single', 'Favourite Back to the Future movie?', 11, SYSDATE, 1, 'vaginas.png');

INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font) values (qseq.nextval, 'F', 'sr-num', '1+1=?', 12, SYSDATE, 3, 'Times New Roman');
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font) values (qseq.nextval, 'F', 'sr-num', '2+1=?', 12, SYSDATE, 3, 'Times New Roman');
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font) values (qseq.nextval, 'F', 'sr-num', '5+1=?', 12, SYSDATE, 3, 'Times New Roman');

INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, textColor) values (qseq.nextval, 'F', 'mp-single', 'Are you single?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, textColor) values (qseq.nextval, 'F', 'mp-single', 'What are you wearing??', 10, SYSDATE, 1, 'Comic Sans MS', 'red');
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, textColor) values (qseq.nextval, 'F', 'mp-single', 'Do you wear undies?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, textColor) values (qseq.nextval, 'F', 'mp-single', 'Whats your hair colour?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, textColor) values (qseq.nextval, 'F', 'mp-single', 'Whats my name?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');

INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'mp-single', 'Favourite Godfather movie?', 11, SYSDATE, 1);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'mp-multiple', 'What genres do you enjoy?', 11, SYSDATE, 1);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'mp-multiple', 'Which disney films have you seen?', 11, SYSDATE, 1);

INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, textColor) values (qseq.nextval, 'T', 'mp-single', 'What is your gender?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator, font, textColor) values (qseq.nextval, 'T', 'mp-single', 'What is your occupation?', 10, SYSDATE, 1, 'Comic Sans MS', 'red');

SELECT 'Inserting Answers' FROM dual;
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '17-20', 20, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '21-25', 20, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '26+', 20, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Red', 21, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blue', 21, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Geen', 21, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Dog', 22, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Cat', 22, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Bird', 22, 'F');
----------

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 1', 23, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 2', 23, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 3', 23, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 4', 23, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 5', 23, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 6', 23, 'T');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '1', 24, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '2', 24, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '3', 24, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'I', 25, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'II', 25, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'III', 25, 'T');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '1', 26, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '2', 26, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '3', 26, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '1', 27, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '2', 27, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '3', 27, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '4', 28, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '5', 28, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '6', 28, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Yes', 29, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'No', 29, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Maybe', 29, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Nothing', 30, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Everything', 30, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'A Dress', 30, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'No socks', 30, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Yes', 31, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'No', 31, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Red', 32, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blue', 32, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Green', 32, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Black', 32, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blonde', 32, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Brown', 32, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Red', 33, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Aidan', 33, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'David', 33, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Louis', 33, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Andy', 33, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 1', 34, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 2', 34, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Part 3', 34, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Action', 35, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Drama', 35, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'SciFi', 35, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Romance', 35, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Horror', 35, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Comedy', 35, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Moulin', 36, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Snow white and thre seven dwarves', 36, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Batman', 36, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Little Mermaid', 36, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'The new spiderman movie', 36, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Male', 37, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Female', 37, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Dentist', 38, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Doctor', 38, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'IT', 38, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Fireman', 38, 'F');

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

INSERT into Assigned(userID, pollID, role) values (2, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 5, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 6, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 7, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 8, 'Web User');
INSERT into Assigned(userID, pollID, role) values (2, 9, 'Web User');

INSERT into Assigned(userID, pollID, role) values (3, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 5, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 6, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 7, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 8, 'Web User');
INSERT into Assigned(userID, pollID, role) values (3, 9, 'Web User');

INSERT into Assigned(userID, pollID, role) values (4, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 5, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 6, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 7, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 8, 'Web User');
INSERT into Assigned(userID, pollID, role) values (4, 9, 'Web User');

INSERT into Assigned(userID, pollID, role) values (5, 1, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 2, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 3, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 4, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 5, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 6, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 7, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 8, 'Web User');
INSERT into Assigned(userID, pollID, role) values (5, 9, 'Web User');

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
INSERT into Assigned(userID, pollID, role) values (2, 10, 'Poll Creator');
INSERT into Assigned(userID, pollID, role) values (3, 11, 'Poll Master');
INSERT into Assigned(userID, pollID, role) values (5, 11, 'Poll Master');
INSERT into Assigned(userID, pollID, role) values (4, 11, 'Poll Creator');
INSERT into Assigned(userID, pollID, role) values (1, 12, 'Poll Creator');
INSERT into Assigned(userID, pollID, role) values (2, 12, 'Poll Master');

-- Add widgets to the DB
SELECT 'Adding widgets' FROM dual;
INSERT into Widgets(widgetID, widgetName, widgetDescription) values (wseq.nextval, 'timer', '60');

-- Assign widgets to question
SELECT 'Assigning wigdget to question' FROM dual;
INSERT into QuestionWidgets(questID, widgetID) values (1, 1);
INSERT into QuestionWidgets(questID, widgetID) values (2, 1);
INSERT into QuestionWidgets(questID, widgetID) values (3, 1);
INSERT into QuestionWidgets(questID, widgetID) values (4, 1);

--Davids
INSERT INTO dcf_Polls(Name, Admin) VALUES ('Test poll', 'administrator');
INSERT INTO dcf_Polls(Name, Admin) VALUES ('Another poll', 'dcf');
INSERT INTO dcf_Polls(Name, Admin) VALUES ('Yet another poll', 'dcf');
INSERT INTO dcf_PollCreatorLink(PollID, UserID) VALUES (2, 1);
INSERT INTO dcf_PollCreatorLink(PollID, UserID) VALUES (2, 2);
INSERT INTO dcf_PollCreatorLink(PollID, UserID) VALUES (3, 2);
INSERT INTO dcf_PollCreatorLink(PollID, UserID) VALUES (3, 1);
INSERT INTO dcf_PollCreators(Username, Password, Email) VALUES ('dcf', 'password', 'schoolsarge@schoolsarge.org');
INSERT INTO dcf_PollCreators(Username, Password, Email) VALUES ('admin', 'password', 'schoolsarge@schoolsarge.org');
INSERT INTO dcf_PollCreators(Username, Password, Email) VALUES ('tester', 'password', 'schoolsarge@schoolsarge.org');
INSERT INTO dcf_PollAdmins(Username, Password, Email) VALUES ('adcf', 'password', 'schoolsarge@schoolsarge.org');
INSERT INTO dcf_PollAdmins(Username, Password, Email) VALUES ('aadmin', 'password', 'schoolsarge@schoolsarge.org');
INSERT INTO dcf_PollAdmins(Username, Password, Email) VALUES ('atester', 'password', 'schoolsarge@schoolsarge.org');
--

commit;