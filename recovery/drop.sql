DROP TABLE Questions;

DROP TABLE Comparitives;

DROP TABLE Answers;

DROP TABLE Ranking;

DROP TABLE Responses;

DROP TABLE KeyResponses;

DROP TABLE ShortResponses;

DROP TABLE Polls;

DROP TABLE Users;

ALTER TABLE Assigned DROP CONSTRAINT userRole;
ALTER TABLE Assigned DROP CONSTRAINT pk_Assigned;
DROP TABLE Assigned;