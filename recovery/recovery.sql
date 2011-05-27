-- Schema for dbPOLL
-- Louis Stowasser 25/5/11
-- CSSE3004 Group F

CREATE TABLE Questions(
	questID NUMBER(6) PRIMARY KEY,
	demographic CHAR(1) NOT NULL,
	responseType CHAR(1) NOT NULL,
	question VARCHAR2(255) NOT NULL,
        pollID NUMBER(6) PRIMARY KEY,
	created TIMESTAMP NOT NULL
);

CREATE TABLE Answers(
	answerID NUMBER(6) PRIMARY KEY,
	keypad CHAR(1),
	answer VARCHAR2(255) NOT NULL,
	questID NUMBER(6) NOT NULL,
	correct CHAR(1) NOT NULL
);

CREATE TABLE Comparitives(
	questID NUMBER(6) PRIMARY KEY,
	compareTo NUMBER(6) NOT NULL
);

CREATE TABLE Rankings(
	answerID NUMBER(6) PRIMARY KEY,
	weight NUMBER(6)
);

CREATE TABLE Responses(
	answerID NUMBER(6) PRIMARY KEY,
	created TIMESTAMP NOT NULL,
	questID NUMBER(6) NOT NULL
);

CREATE TABLE KeyResponses(
	responseID NUMBER(6) PRIMARY KEY,
	keypad CHAR(1) NOT NULL
);

CREATE TABLE ShortResponses(
	responseID NUMBER(6) PRIMARY KEY,
	response VARCHAR2(255) NOT NULL
);

CREATE TABLE Polls(
	pollID NUMBER(6) PRIMARY KEY,
	pollName VARCHAR2(255) NOT NULL,
	location VARCHAR2(255) NOT NULL
);

CREATE TABLE Users(
	userID NUMBER(6) PRIMARY KEY,
	userName VARCHAR2(255) NOT NULL,
	password VARCHAR2(255) NOT NULL,
	email VARCHAR2(255) NOT NULL,
	location VARCHAR2(255) NOT NULL
);

CREATE TABLE Assigned(
	userID NUMBER(6),
	pollID NUMBER(6),
	role VARCHAR(255) NOT NULL,
	CONSTRAINT userRole CHECK (role IN ('Web User', 'Key User', 'Poll Master', 'Poll Creator', 'Poll Admin', 'System Admin')),
	CONSTRAINT pk_Assigned PRIMARY KEY (userID, pollID)
);