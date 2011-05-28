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

-- Tables
CREATE TABLE Questions(
    questID NUMBER(6) NOT NULL,
    demographic CHAR(1) NOT NULL,
    responseType CHAR(1) NOT NULL,
    question VARCHAR2(255) NOT NULL,
    pollID NUMBER(6) NOT NULL,      -- pollID of Polls
    created DATE NOT NULL,
    font VARCHAR(255),
    correctIndicator VARCHAR(255),
    chartType NUMBER(6),   -- chartID of Charts
    images VARCHAR(255),
    creator NUMBER(6) NOT NULL,     -- userID of Users
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
    answerID NUMBER(6) NOT NULL,    -- answerID of Answer
    created TIMESTAMP NOT NULL,
    questID NUMBER(6) NOT NULL,     -- questID of Questions
    CONSTRAINT pk_Responses PRIMARY KEY (answerID, questID)
);

CREATE TABLE KeyResponses(
    responseID NUMBER(6) NOT NULL,  -- responseID of Responses
    keypad CHAR(1) NOT NULL,
    CONSTRAINT pk_KeyResponses PRIMARY KEY (responseID)
);

CREATE TABLE ShortResponses(
    responseID NUMBER(6) NOT NULL,  -- responseID of Responses
    response VARCHAR2(255) NOT NULL,
    CONSTRAINT pk_ShortResponses PRIMARY KEY (responseID)
);

CREATE TABLE Polls(
    pollID NUMBER(6) NOT NULL,
    pollName VARCHAR2(255) NOT NULL,
    location VARCHAR2(255) NOT NULL,
    description VARCHAR2(255) NOT NULL,
    CONSTRAINT pk_Polls PRIMARY KEY (pollID)
);

CREATE TABLE Users(
    userID NUMBER(6) NOT NULL,
    userName VARCHAR2(255) NOT NULL,
    password VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    location VARCHAR2(255) NOT NULL,
    userLevel VARCHAR(255) NOT NULL,
    CONSTRAINT userLevel_const CHECK (userLevel IN ('Web User', 'Key User', 'Poll Master', 'Poll Creator', 'Poll Admin')),
    CONSTRAINT pk_Users PRIMARY KEY (userID)
);

CREATE TABLE Assigned(
    userID NUMBER(6) NOT NULL,      -- userID of Users
    pollID NUMBER(6) NOT NULL,      -- pollID of Polls
    role VARCHAR(255) NOT NULL,
    CONSTRAINT userRole CHECK (role IN ('Web User', 'Key User', 'Poll Master', 'Poll Creator', 'Poll Admin')),
    CONSTRAINT pk_Assigned PRIMARY KEY (userID, pollID)
);
