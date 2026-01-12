CREATE TABLE [dbo].[Scalings] (
    [ScallingID]  INT             IDENTITY (1, 1) NOT NULL,
    [ResourceID]  INT             NOT NULL,
    [Factor]      TINYINT         NOT NULL,
    [Data]        VARBINARY (MAX) NULL,
    [CreatedDate] DATETIME        NOT NULL
);



