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
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (3, 'F', 'M', 'How old are you?', 1, SYSDATE, 1);

INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (4, 'F', 'M', 'Favourite Star Wars movie?', 2, SYSDATE, 2);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (5, 'F', 'M', 'Favourite LOTR movie?', 2, SYSDATE, 2);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (6, 'F', 'M', 'Favourite Back to the Future movie?', 2, SYSDATE, 2);

INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (7, 'F', 'M', '1+1=?', 3, SYSDATE, 3);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (8, 'F', 'M', '2+1=?', 3, SYSDATE, 3);
INSERT into Questions(questID, demographic, responseType, question, pollID, created, creator) values (9, 'F', 'M', '5+1=?', 3, SYSDATE, 3);

-- Answers
SELECT 'Inserting Answers' FROM dual;
INSERT into Answers(answerID, keypad, answer, questID, correct) values (1, 'F', '17-20', 1, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (2, 'F', '21-25', 1, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (3, 'F', '26+', 1, 'F');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (4, 'F', 'Episode 1', 2, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (5, 'F', 'Episode 2', 2, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (6, 'F', 'Episode 3', 2, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (7, 'F', 'Episode 4', 2, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (8, 'F', 'Episode 5', 2, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (9, 'F', 'Episode 6', 2, 'T');

INSERT into Answers(answerID, keypad, answer, questID, correct) values (10, 'F', 'Part I', 3, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (11, 'F', 'Part II', 3, 'F');
INSERT into Answers(answerID, keypad, answer, questID, correct) values (12, 'F', 'Part II', 3, 'F');


commit;