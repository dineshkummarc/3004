DROP SEQUENCE qseq;

DROP SEQUENCE aseq;

DROP SEQUENCE pseq;

DROP SEQUENCE useq;

DROP TABLE Questions;

DROP TABLE Comparitives;

DROP TABLE Answers;

DROP TABLE Rankings;

DROP TABLE Responses;

DROP TABLE KeyResponses;

DROP TABLE ShortResponses;

DROP TABLE Polls;

DROP TABLE Users;

ALTER TABLE Assigned DROP CONSTRAINT userRole;
ALTER TABLE Assigned DROP CONSTRAINT pk_Assigned;
DROP TABLE Assigned;