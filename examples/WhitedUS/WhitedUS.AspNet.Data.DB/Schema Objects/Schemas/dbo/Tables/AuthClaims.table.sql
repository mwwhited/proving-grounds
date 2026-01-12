CREATE TABLE [dbo].[AuthClaims] (
    [AuthClaimID] BIGINT           IDENTITY (1, 1) NOT NULL,
    [UserID]      UNIQUEIDENTIFIER NOT NULL,
    [ClaimString] NVARCHAR (450)   NOT NULL
);

