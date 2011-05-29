-- Sample data for dbPOLL
-- Aidan Rowe 27/5/11
-- CSSE3004 Group F

-- Users
SELECT 'Inserting Users' FROM dual;
INSERT into Users(userID, userName, password, email, location, userLevel) values (useq.nextval, 'aidan', 'password1', 'aidanrowe@gmail.com', '(-27.522299, 153.047111)', 'Poll Creator');
INSERT into Users(userID, userName, password, email, location, userLevel) values (useq.nextval, 'stuart', 'pass', 'stuartwsemple@gmail.com', '(-27.570477, 152.841729)', 'Poll Creator');
INSERT into Users(userID, userName, password, email, location, userLevel) values (useq.nextval, 'darren', 'test', 'darren.goodair@gmail.com', '(-27.53722, 153.078308)', 'Poll Creator');
INSERT into Users(userID, userName, password, email, location, userLevel) values (useq.nextval, 'david', 'p4ss', 'd.fairbrother@uq.edu.au', '(-27.53722, 153.078308)', 'Poll Creator');
INSERT into Users(userID, userName, password, email, location, userLevel) values (useq.nextval, 'louis', 'p00', 'louisstow@gmail.com', '(-27.474074, 152.995286)', 'Poll Creator');
INSERT into Users(userID, userName, password, email, location, userLevel) values (useq.nextval, 'andy', 'poo', 's0956626962@hotmail.com', '(-27.498831257455244, 152.9725170135498)', 'Poll Creator');

-- Polls
SELECT 'Inserting Polls' FROM dual;
INSERT into Polls(pollID, pollName, location, description) values (pseq.nextval, 'General survey', '1', 'A general survey to get to know all the subjects.');
INSERT into Polls(pollID, pollName, location, description) values (pseq.nextval, 'Movie information', '2', 'A Poll to determine movie information.');
INSERT into Polls(pollID, pollName, location, description) values (pseq.nextval, 'Basci Mathematics', '3', 'Simple test to work out the mathemtical skill level of students.');

-- Question
SELECT 'Inserting Questions' FROM dual;
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'M', 'How old are you?', 1, SYSDATE, 1);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'M', 'Whats your favourite colour?', 1, SYSDATE, 1);
--INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'S', 'Favourite animal?', 1, SYSDATE, 1);

INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'M', 'Favourite Star Wars movie?', 2, SYSDATE, 1);
--INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'S', 'Favourite LOTR movie?', 2, SYSDATE, 1);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'M', 'Favourite Back to the Future movie?', 2, SYSDATE, 1);

INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'M', '1+1=?', 3, SYSDATE, 3);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'S', '2+1=?', 3, SYSDATE, 3);
--INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (qseq.nextval, 'F', 'M', '5+1=?', 3, SYSDATE, 3);

-- Answers
SELECT 'Inserting Answers' FROM dual;
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '1', '17-20', 1, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '2', '21-25', 1, 'F');
--INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '26+', 1, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '1', 'Red', 2, 'F');
--INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Blue', 2, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '2', 'Geen', 2, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '1', 'Dog', 3, 'F');
--INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Cat', 3, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '2', 'Bird', 3, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '1', 'Episode 1', 4, 'F');
--INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 2', 4, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '2', 'Episode 3', 4, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '3', 'Episode 4', 4, 'F');
--INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', 'Episode 5', 4, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '4', 'Episode 6', 4, 'T');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '1', '1', 5, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '2', '2', 5, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '3', '3', 5, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '1', 'I', 6, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '2', 'II', 6, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '3', 'III', 6, 'T');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '1', '1', 7, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '2', '2', 7, 'F');
--INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '3', 7, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '1', '1', 8, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '2', '2', 8, 'F');
--INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '3', 8, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, '1', '4', 9, 'F');
--INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '5', 9, 'F');
--INSERT into Answers(answerID, keypad, answer, questID, correct) values (aseq.nextval, 'F', '6', 9, 'F');

INSERT into Assigned(userID, pollID, role) values (1, 1, 'Poll Creator');
INSERT into Assigned(userID, pollID, role) values (1, 2, 'Poll Creator');
INSERT into Assigned(userID, pollID, role) values (2, 3, 'Poll Creator');


commit;