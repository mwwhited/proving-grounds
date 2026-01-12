CREATE TABLE [Security].[Applications] (
    [ApplicationID]                        UNIQUEIDENTIFIER NOT NULL,
    [Name]                                 NVARCHAR (200)   NOT NULL,
    [Description]                          NVARCHAR (MAX)   NULL,
    [EnablePasswordReset]                  BIT              NOT NULL,
    [MaxInvalidPasswordAttempts]           INT              NOT NULL,
    [MinRequiredNonAlphanumericCharacters] INT              NOT NULL,
    [MinRequiredPasswordLength]            INT              NOT NULL,
    [PasswordAttemptWindow]                INT              NOT NULL,
    [PasswordStrengthRegularExpression]    NVARCHAR (MAX)   NULL,
    [RequiresQuestionAndAnswer]            BIT              NOT NULL,
    [RequiresUniqueEmail]                  BIT              NOT NULL,
    [InvalidPasswordWindow]                DATETIME         NOT NULL
);



