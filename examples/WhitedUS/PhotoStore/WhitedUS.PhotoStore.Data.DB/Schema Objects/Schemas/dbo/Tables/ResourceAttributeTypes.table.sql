CREATE TABLE [dbo].[ResourceAttributeTypes] (
    [ResourceAttributeTypeID] INT           IDENTITY (1, 1) NOT NULL,
    [AttributeGroup]          NVARCHAR (50) NOT NULL,
    [AttributeName]           NVARCHAR (50) NOT NULL,
    [Attribute]               AS            ((replace([AttributeGroup],'.','')+'_')+[AttributeName]) PERSISTED,
    [FieldType]               NVARCHAR (50) NULL,
    [FieldLength]             INT           NULL
);





