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
-- new
CREATE SEQUENCE plseq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE mseq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE uiseq
START WITH 1
INCREMENT BY 1;
--end

-- Tables
CREATE TABLE Questions(
    questID INTEGER NOT NULL,
    demographic CHAR(1) DEFAULT 'F',
    responseType VARCHAR(35) NOT NULL,
    question VARCHAR2(255) NOT NULL,
    pollID INTEGER NOT NULL,      -- pollID of Polls
    created DATE NOT NULL,
    font VARCHAR(255) DEFAULT null,
    fontColor VARCHAR(255) DEFAULT null,
    fontSize VARCHAR(255) DEFAULT null,
    correctIndicator VARCHAR(255) DEFAULT null,
    chartType VARCHAR(10) DEFAULT null,   -- chartID of Charts
    images VARCHAR(255) DEFAULT null,
    creator INTEGER NOT NULL,     -- userID of Users
    location VARCHAR(255),
    CONSTRAINT pk_Questions PRIMARY KEY (questID)
);

CREATE TABLE Widgets(
    widgetID INTEGER NOT NULL,
    widgetName VARCHAR(255) NOT NULL,
    widgetDescription VARCHAR(255) NOT NULL,
    CONSTRAINT pk_Widgets PRIMARY KEY (widgetID)
);

CREATE TABLE QuestionWidgets(
    questID INTEGER NOT NULL,     -- questID of Questions
    widgetID INTEGER NOT NULL,    -- widgetID of Widgets
    CONSTRAINT pk_QuestionWidgets PRIMARY KEY (questID, widgetID)
);

CREATE TABLE Templates(
    templateID INTEGER NOT NULL,
    templateName VARCHAR(255) NOT NULL,
    userID INTEGER NOT NULL,      -- userID of Users
    CONSTRAINT pk_Templates PRIMARY KEY (templateID, userID)
);

CREATE TABLE TemplateAnswers(
    templateAnswersID INTEGER NOT NULL,
    templateID INTEGER NOT NULL,  -- templateID of Templates
    answerPosition INTEGER NOT NULL,
    answerValue VARCHAR(255) NOT NULL,
    CONSTRAINT pk_TemplateAnswers PRIMARY KEY (templateAnswersID, templateID)
);

CREATE TABLE Answers(
    answerID INTEGER NOT NULL,
    keypad CHAR(1),
    answer VARCHAR2(255) NOT NULL,
    questID INTEGER NOT NULL,     -- questID of Questions
    correct CHAR(1) NOT NULL,
	weight INTEGER DEFAULT NULL,
    CONSTRAINT pk_Answers PRIMARY KEY (answerID)
);

CREATE TABLE Comparitives(
    questID INTEGER NOT NULL,     -- questID of Questions
    compareTo INTEGER NOT NULL,
    CONSTRAINT pk_Comparitives PRIMARY KEY (questID)
);

CREATE TABLE Responses(
    userID INTEGER NOT NULL,
    created TIMESTAMP DEFAULT SYSDATE,
    questID INTEGER NOT NULL,     -- questID of Questions
    CONSTRAINT pk_Responses PRIMARY KEY (questID, userID)
);

--SUB CLASS OF RESPONSES
CREATE TABLE ShortResponses(
    userID INTEGER NOT NULL,
    questID INTEGER NOT NULL,     -- questID of Questions
    response VARCHAR2(255) NOT NULL,
    CONSTRAINT pk_ShortResponses PRIMARY KEY (questID, userID)
);

--SUB CLASS OF RESPONSES
CREATE TABLE MultiResponses(
    userID INTEGER NOT NULL,
    questID INTEGER NOT NULL,     -- questID of Questions
    answerID INTEGER NOT NULL,    -- answerID of Answer
    plID INTEGER,
    CONSTRAINT pk_MultiResponses PRIMARY KEY (questID, userID, answerID)
);

--SUB CLASS OF RESPONSES
CREATE TABLE KeyResponses(
    --userID INTEGER,
    clickerID VARCHAR2(30) NOT NULL,
    questID INTEGER NOT NULL,     -- questID of Questions
    answerID INTEGER NOT NULL    -- answerID of Answer
);

CREATE TABLE Polls(
    pollID INTEGER NOT NULL,
    pollName VARCHAR2(255) NOT NULL,
    location VARCHAR2(255),
    description VARCHAR2(255),
    startDate TIMESTAMP,
    finishDate TIMESTAMP,
    country VARCHAR2(255) DEFAULT '1',
    state VARCHAR2(255) DEFAULT '1',
    city VARCHAR2(255) DEFAULT '1',
    suburb VARCHAR2(255) DEFAULT '1',
    street VARCHAR2(255) DEFAULT '1',
    unitNumber VARCHAR2(255) DEFAULT '1',
    activeQuestion INTEGER DEFAULT 0,
    keypad VARCHAR2(5) DEFAULT 'FALSE',
    CONSTRAINT pk_Polls PRIMARY KEY (pollID)
);

--New Table
CREATE TABLE pollLocation(
plID INTEGER NOT NULL,
pollID INTEGER NOT NULL,
country VARCHAR(255) NOT NULL,
state VARCHAR(255) NOT NULL,
city VARCHAR(255) NOT NULL,
suburb VARCHAR(255) NOT NULL, 
street VARCHAR(255) NOT NULL,
unit VARCHAR(10),
CONSTRAINT pk_pollLocation PRIMARY KEY (plID)
);

CREATE TABLE Messages(
msgID INTEGER NOT NULL,
pollID INTEGER NOT NULL,
fromUser INTEGER NOT NULL,
toUser INTEGER NOT NULL,
created TIMESTAMP NOT NULL,
message VARCHAR(255) NOT NULL,
isRead VARCHAR(1) NOT NULL,
CONSTRAINT pk_Messages PRIMARY KEY (msgID),
CONSTRAINT isRead_const CHECK (isRead IN ('T', 'F'))
);

CREATE TABLE UserInfo(
uiID INTEGER  NOT NULL,
userID INTEGER NOT NULL,
pollID INTEGER NOT NULL,
information VARCHAR(255) NOT NULL,
CONSTRAINT pk_UserInfo PRIMARY KEY (uiID)
);

-- end new

CREATE TABLE Users(
    userID INTEGER NOT NULL,
    userName VARCHAR2(255) NOT NULL,
    password VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    location VARCHAR2(255),
    userLevel VARCHAR(255) DEFAULT 'Web User',
    created DATE DEFAULT SYSDATE,
    expired DATE,
	clickerID VARCHAR2(30),
    CONSTRAINT userLevel_const CHECK (userLevel IN ('Web User', 'Key User', 'Poll Master', 'Poll Creator', 'Poll Admin', 'System Admin')),
    CONSTRAINT pk_Users PRIMARY KEY (userID),
    CONSTRAINT uk_Users UNIQUE (userName)
);

CREATE TABLE Attendance(
    pollID INTEGER NOT NULL,
    userID INTEGER NOT NULL,
    location VARCHAR2(255) NOT NULL,
    lastModified Date NOT NULL,
    CONSTRAINT pk_attendance PRIMARY KEY (pollID, userID)
);

CREATE TABLE Assigned(
    userID INTEGER NOT NULL,      -- userID of Users
    pollID INTEGER NOT NULL,      -- pollID of Polls
    role VARCHAR(255) NOT NULL,
    status VARCHAR(5) DEFAULT 'false',
    CONSTRAINT userRole CHECK (role IN ('Web User', 'Key User', 'Poll Master', 'Poll Creator', 'Poll Admin')),
    CONSTRAINT pk_Assigned PRIMARY KEY (userID, pollID)
);

CREATE TABLE Feedback(
	userID INTEGER NOT NULL,      -- userID of Users
	questID INTEGER NOT NULL,
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