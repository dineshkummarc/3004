-- Sample data for dbPOLL
-- Aidan Rowe 27/5/11
-- CSSE3004 Group F

-- Users
SELECT 'Inserting Users' FROM dual;
INSERT into Users(userID, userName, password, email, location, userLevel) values (1, 'aidan', 'password1', 'aidanrowe@gmail.com', '(-27.522299, 153.047111)', 'Poll Creator');
INSERT into Users(userID, userName, password, email, location, userLevel) values (2, 'stuart', 'pass', 'stuartwsemple@gmail.com', '(-27.570477, 152.841729)', 'Poll Creator');
INSERT into Users(userID, userName, password, email, location, userLevel) values (3, 'darren', 'test', 'darren.goodair@gmail.com', '(-27.53722, 153.078308)', 'Poll Creator');
INSERT into Users(userID, userName, password, email, location, userLevel) values (4, 'david', 'p4ss', 'd.fairbrother@uq.edu.au', '(-27.53722, 153.078308)', 'Poll Creator');
INSERT into Users(userID, userName, password, email, location, userLevel) values (5, 'louis', 'p00', 'louisstow@gmail.com', '(-27.474074, 152.995286)', 'Poll Creator');
INSERT into Users(userID, userName, password, email, location, userLevel) values (6, 'andy', 'poo', 's0956626962@hotmail.com', '(-27.498831257455244, 152.9725170135498)', 'Poll Creator');

-- Polls
SELECT 'Inserting Polls' FROM dual;
INSERT into Polls(pollID, pollName, location, description) values (1, 'General survey', '1', 'A general survey to get to know all the subjects.');
INSERT into Polls(pollID, pollName, location, description) values (2, 'Movie information', '2', 'A Poll to determine movie information.');
INSERT into Polls(pollID, pollName, location, description) values (3, 'Basci Mathematics', '3', 'Simple test to work out the mathemtical skill level of students.');

-- Question
SELECT 'Inserting Questions' FROM dual;
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (1, 'F', 'M', 'How old are you?', 1, SYSDATE, 1);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (2, 'F', 'M', 'Whats your favourite colour?', 1, SYSDATE, 1);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (3, 'F', 'S', 'Favourite animal?', 1, SYSDATE, 1);

INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (4, 'F', 'M', 'Favourite Star Wars movie?', 2, SYSDATE, 2);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (5, 'F', 'S', 'Favourite LOTR movie?', 2, SYSDATE, 2);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (6, 'F', 'M', 'Favourite Back to the Future movie?', 2, SYSDATE, 2);

INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (7, 'F', 'M', '1+1=?', 3, SYSDATE, 3);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (8, 'F', 'S', '2+1=?', 3, SYSDATE, 3);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (9, 'F', 'M', '5+1=?', 3, SYSDATE, 3);

-- Answers
SELECT 'Inserting Answers' FROM dual;
INSERT into Answers(answerID, keypad, answer, questID, correct) values (1, 'F', '17-20', 1, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (2, 'F', '21-25', 1, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (3, 'F', '26+', 1, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (4, 'F', 'Red', 2, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (5, 'F', 'Blue', 2, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (6, 'F', 'Geen', 2, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (7, 'F', 'Dog', 3, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (8, 'F', 'Cat', 3, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (9, 'F', 'Bird', 3, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (10, 'F', 'Episode 1', 4, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (11, 'F', 'Episode 2', 4, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (12, 'F', 'Episode 3', 4, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (13, 'F', 'Episode 4', 4, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (14, 'F', 'Episode 5', 4, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (15, 'F', 'Episode 6', 4, 'T');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (16, 'F', '1', 5, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (17, 'F', '2', 5, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (18, 'F', '3', 5, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (19, 'F', 'I', 6, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (20, 'F', 'II', 6, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (21, 'F', 'III', 6, 'T');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (22, 'F', '1', 7, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (23, 'F', '2', 7, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (24, 'F', '3', 7, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (25, 'F', '1', 8, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (26, 'F', '2', 8, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (27, 'F', '3', 8, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (28, 'F', '4', 9, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (29, 'F', '5', 9, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (30, 'F', '6', 9, 'F');

commit;