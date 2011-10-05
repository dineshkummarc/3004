-- Darren Goodair
-- CSSE3004 Group F

DROP SEQUENCE qseq;
DROP SEQUENCE aseq;
DROP SEQUENCE pseq;
DROP SEQUENCE useq;
DROP SEQUENCE wseq;

ALTER TABLE Questions DROP CONSTRAINT pk_Questions;
ALTER TABLE Widgets DROP CONSTRAINT pk_Widgets;
ALTER TABLE QuestionWidgets DROP CONSTRAINT pk_QuestionWidgets;
ALTER TABLE Templates DROP CONSTRAINT pk_Templates;
ALTER TABLE TemplateAnswers DROP CONSTRAINT pk_TemplateAnswers;
ALTER TABLE Comparitives DROP CONSTRAINT pk_Comparitives;
ALTER TABLE Answers DROP CONSTRAINT pk_Answers;
ALTER TABLE Responses DROP CONSTRAINT pk_Responses;
ALTER TABLE KeyResponses DROP CONSTRAINT pk_KeyResponses;
ALTER TABLE ShortResponses DROP CONSTRAINT pk_ShortResponses;
ALTER TABLE MultiResponses DROP CONSTRAINT pk_MultiResponses;
ALTER TABLE Feedback DROP CONSTRAINT pk_Feedback;
ALTER TABLE Polls DROP CONSTRAINT pk_Polls;
ALTER TABLE Assigned DROP CONSTRAINT userRole;
ALTER TABLE Assigned DROP CONSTRAINT pk_Assigned;
ALTER TABLE Attendance DROP CONSTRAINT pk_Attendance;
ALTER TABLE Users DROP CONSTRAINT pk_Users;
ALTER TABLE Users DROP CONSTRAINT uk_Users;

DROP TABLE Questions;
DROP TABLE Widgets;
DROP TABLE QuestionWidgets;
DROP TABLE Templates;
DROP TABLE TemplateAnswers;
DROP TABLE Comparitives;
DROP TABLE Answers;
DROP TABLE Responses;
DROP TABLE KeyResponses;
DROP TABLE ShortResponses;
DROP TABLE MultiResponses;
DROP TABLE Feedback;
DROP TABLE Polls;
DROP TABLE Assigned;
DROP TABLE Attendance;
DROP TABLE Users;

-- Davids
DROP SEQUENCE pclink_autonumber;
DROP SEQUENCE pa_autonumber;

DROP TRIGGER  pclink_trigger;
DROP TRIGGER  pa_trigger;

DROP TABLE PollCreatorLink;
DROP TABLE PollAdmins;
--

commit;