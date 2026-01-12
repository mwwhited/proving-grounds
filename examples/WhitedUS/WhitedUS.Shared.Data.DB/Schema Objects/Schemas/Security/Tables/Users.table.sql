CREATE TABLE [Security].[Users] (
    [UserID]                     UNIQUEIDENTIFIER NOT NULL,
    [UserName]                   NVARCHAR (256)   NOT NULL,
    [Email]                      NVARCHAR (512)   NOT NULL,
    [Description]                NVARCHAR (MAX)   NULL,
    [PasswordCrypt]              NVARCHAR (256)   NULL,
    [IsServiceAccount]           BIT              NOT NULL,
    [IsApproved]                 BIT              NOT NULL,
    [IsLockedOut]                BIT              NOT NULL,
    [IsOnline]                   BIT              NOT NULL,
    [CreationDate]               DATETIME         NOT NULL,
    [LastActivityDate]           DATETIME         NOT NULL,
    [LastLockoutDate]            DATETIME         NOT NULL,
    [LastLoginDate]              DATETIME         NOT NULL,
    [LastPasswordChangedDate]    DATETIME         NOT NULL,
    [RecoveryQuestion]           NVARCHAR (MAX)   NULL,
    [RecoveryAnswer]             NVARCHAR (256)   NULL,
    [FailedPasswordCount]        INT              NOT NULL,
    [FailedPasswordWindowsStart] DATETIME         NOT NULL,
    [FailedAnswerCount]          INT              NOT NULL,
    [FailedAnswerWindowsStart]   DATETIME         NOT NULL
);



