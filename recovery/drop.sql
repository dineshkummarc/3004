DROP SEQUENCE qseq;

DROP SEQUENCE aseq;

DROP SEQUENCE pseq;

DROP SEQUENCE useq;

ALTER TABLE Questions DROP CONSTRAINT pk_Questions;
DROP TABLE Questions;

ALTER TABLE Widgets DROP CONSTRAINT pk_Widgets;
DROP TABLE Widgets;

ALTER TABLE QuestionWidgets DROP CONSTRAINT pk_QuestionWidgets;
DROP TABLE QuestionWidgets;

ALTER TABLE Templates DROP CONSTRAINT pk_Templates;
DROP TABLE Templates;

ALTER TABLE TemplateAnswers DROP CONSTRAINT pk_TemplateAnswers;
DROP TABLE TemplateAnswers;

ALTER TABLE Comparitives DROP CONSTRAINT pk_Comparitives;
DROP TABLE Comparitives;

ALTER TABLE Answers DROP CONSTRAINT pk_Answers;
DROP TABLE Answers;

ALTER TABLE Rankings DROP CONSTRAINT pk_Rankings;
DROP TABLE Rankings;

ALTER TABLE Responses DROP CONSTRAINT pk_Responses;
DROP TABLE Responses;

ALTER TABLE KeyResponses DROP CONSTRAINT pk_KeyResponses;
DROP TABLE KeyResponses;

ALTER TABLE ShortResponses DROP CONSTRAINT pk_ShortResponses;
DROP TABLE ShortResponses;

ALTER TABLE Polls DROP CONSTRAINT pk_Polls;
DROP TABLE Polls;

ALTER TABLE Users DROP CONSTRAINT pk_Users;
DROP TABLE Users;

ALTER TABLE Assigned DROP CONSTRAINT userRole;
ALTER TABLE Assigned DROP CONSTRAINT pk_Assigned;
DROP TABLE Assigned;