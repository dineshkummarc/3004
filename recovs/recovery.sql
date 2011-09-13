-- Darren Goodair
-- CSSE3004 Group F

-- Sequences
CREATE SEQUENCE qseq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE aseq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE pseq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE useq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE wseq
START WITH 1
INCREMENT BY 1;

-- Tables
CREATE TABLE Questions(
    questID NUMBER(6) NOT NULL,
    demographic CHAR(1) DEFAULT 'F',
    responseType VARCHAR(15) NOT NULL,
    question VARCHAR2(255) NOT NULL,
    pollID NUMBER(6) NOT NULL,      -- pollID of Polls
    created DATE NOT NULL,
    font VARCHAR(255) DEFAULT null,
    fontColor VARCHAR(255) DEFAULT null,
    fontSize VARCHAR(255) DEFAULT null,
    correctIndicator VARCHAR(255) DEFAULT null,
    chartType VARCHAR(10) DEFAULT null,   -- chartID of Charts
    images VARCHAR(255) DEFAULT null,
    creator NUMBER(6) NOT NULL,     -- userID of Users
    location VARCHAR(255),
    CONSTRAINT pk_Questions PRIMARY KEY (questID)
);

CREATE TABLE Widgets(
    widgetID NUMBER(6) NOT NULL,
    widgetName VARCHAR(255) NOT NULL,
    widgetDescription VARCHAR(255) NOT NULL,
    CONSTRAINT pk_Widgets PRIMARY KEY (widgetID)
);

CREATE TABLE QuestionWidgets(
    questID NUMBER(6) NOT NULL,     -- questID of Questions
    widgetID NUMBER(6) NOT NULL,    -- widgetID of Widgets
    CONSTRAINT pk_QuestionWidgets PRIMARY KEY (questID, widgetID)
);

CREATE TABLE Templates(
    templateID NUMBER(6) NOT NULL,
    templateName VARCHAR(255) NOT NULL,
    userID NUMBER(6) NOT NULL,      -- userID of Users
    CONSTRAINT pk_Templates PRIMARY KEY (templateID, userID)
);

CREATE TABLE TemplateAnswers(
    templateAnswersID NUMBER(6) NOT NULL,
    templateID NUMBER(6) NOT NULL,  -- templateID of Templates
    answerPosition NUMBER(6) NOT NULL,
    answerValue VARCHAR(255) NOT NULL,
    CONSTRAINT pk_TemplateAnswers PRIMARY KEY (templateAnswersID, templateID)
);

CREATE TABLE Answers(
    answerID NUMBER(6) NOT NULL,
    keypad CHAR(1),
    answer VARCHAR2(255) NOT NULL,
    questID NUMBER(6) NOT NULL,     -- questID of Questions
    correct CHAR(1) NOT NULL,
    CONSTRAINT pk_Answers PRIMARY KEY (answerID)
);

CREATE TABLE Comparitives(
    questID NUMBER(6) NOT NULL,     -- questID of Questions
    compareTo NUMBER(6) NOT NULL,
    CONSTRAINT pk_Comparitives PRIMARY KEY (questID)
);

CREATE TABLE Rankings(
    answerID NUMBER(6) NOT NULL,    -- answerID of Answers
    weight NUMBER(6) NOT NULL,
    CONSTRAINT pk_Rankings PRIMARY KEY (answerID)
);

CREATE TABLE Responses(
    userID NUMBER(6) NOT NULL,
    created TIMESTAMP DEFAULT SYSDATE,
    questID NUMBER(6) NOT NULL,     -- questID of Questions
    CONSTRAINT pk_Responses PRIMARY KEY (questID, userID)
);

--SUB CLASS OF RESPONSES
CREATE TABLE ShortResponses(
    userID NUMBER(6) NOT NULL,
    questID NUMBER(6) NOT NULL,     -- questID of Questions
    response VARCHAR2(255) NOT NULL,
    CONSTRAINT pk_ShortResponses PRIMARY KEY (questID, userID)
);

--SUB CLASS OF RESPONSES
CREATE TABLE MultiResponses(
    userID NUMBER(6) NOT NULL,
    questID NUMBER(6) NOT NULL,     -- questID of Questions
    answerID NUMBER(6) NOT NULL,    -- answerID of Answer
    CONSTRAINT pk_MultiResponses PRIMARY KEY (questID, userID, answerID)
);

--SUB CLASS OF RESPONSES
CREATE TABLE KeyResponses(
    userID NUMBER(6) NOT NULL,
    questID NUMBER(6) NOT NULL,     -- questID of Questions
    keypad CHAR(1) NOT NULL,
    CONSTRAINT pk_KeyResponses PRIMARY KEY (questID, userID)
);

CREATE TABLE Polls(
    pollID NUMBER(6) NOT NULL,
    pollName VARCHAR2(255) NOT NULL,
    location VARCHAR2(255),
    description VARCHAR2(255),
    startDate TIMESTAMP,
    finishDate TIMESTAMP,
    CONSTRAINT pk_Polls PRIMARY KEY (pollID)
);

CREATE TABLE Users(
    userID NUMBER(6) NOT NULL,
    userName VARCHAR2(255) NOT NULL,
    password VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    location VARCHAR2(255),
    userLevel VARCHAR(255),
    created DATE,
    expired DATE,
    CONSTRAINT userLevel_const CHECK (userLevel IN ('Web User', 'Key User', 'Poll Master', 'Poll Creator', 'Poll Admin', 'System Admin')),
    CONSTRAINT pk_Users PRIMARY KEY (userID),
    CONSTRAINT uk_Users UNIQUE (userName)
);

CREATE TABLE Attendance(
    pollID NUMBER(6) NOT NULL,
    userID NUMBER(6) NOT NULL,
    location VARCHAR2(255) NOT NULL,
    lastModified Date NOT NULL,
    CONSTRAINT pk_attendance PRIMARY KEY (pollID, userID)
);

CREATE TABLE Assigned(
    userID NUMBER(6) NOT NULL,      -- userID of Users
    pollID NUMBER(6) NOT NULL,      -- pollID of Polls
    role VARCHAR(255) NOT NULL,
    status VARCHAR(5) DEFAULT 'false',
    CONSTRAINT userRole CHECK (role IN ('Web User', 'Key User', 'Poll Master', 'Poll Creator', 'Poll Admin')),
    CONSTRAINT pk_Assigned PRIMARY KEY (userID, pollID)
);

CREATE TABLE Feedback(
	userID NUMBER(6) NOT NULL,      -- userID of Users
	questID NUMBER(6) NOT NULL,
	created TIMESTAMP DEFAULT SYSDATE,
	text VARCHAR2(255) NOT NULL,
	CONSTRAINT pk_Feedback PRIMARY KEY (userID, questID)
);

-- DAVID'S
CREATE TABLE PollCreatorLink(PCPID INTEGER, PollID INTEGER, UserID INTEGER);
CREATE SEQUENCE pclink_autonumber;
CREATE TRIGGER pclink_trigger
BEFORE INSERT ON PollCreatorLink
for each row
begin
  select pclink_autonumber.nextval into :new.PCPID from dual;
end pclink_trigger;
/
CREATE TABLE PollAdmins(UserID INTEGER, Username VARCHAR2(50));
CREATE SEQUENCE pa_autonumber;
CREATE TRIGGER pa_trigger
BEFORE INSERT ON PollAdmins
for each row
begin
  select pa_autonumber.nextval into :new.UserID from dual;
end pa_trigger;
/
-- END DAVID'S

commit;