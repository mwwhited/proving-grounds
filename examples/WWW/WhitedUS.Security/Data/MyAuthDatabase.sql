/****** Object:  Table [dbo].[MyUser]    Script Date: 08/16/2008 01:02:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MyUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MyUser](
	[UniqueID] [uniqueidentifier] NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[EmailAddress] [varchar](300) NOT NULL,
	[IsDisabled] [bit] NOT NULL,
	[IsLocked] [bit] NOT NULL,
	[PasswordHash] [varchar](50) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateLastLogin] [datetime] NULL,
	[DateLastActivity] [datetime] NULL,
	[DateLastPasswordChange] [datetime] NULL,
	[DateLastLocked] [datetime] NULL,
	[Comment] [nvarchar](max) NULL,
	[ChangePasswordQuestion] [nvarchar](1024) NULL,
	[ChangePasswordAnswerHash] [varchar](50) NULL,
 CONSTRAINT [PK_MyUser_UniqueID] PRIMARY KEY CLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_MyUser_EmailAddress]    Script Date: 08/16/2008 01:02:55 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[MyUser]') AND name = N'IX_MyUser_EmailAddress')
CREATE UNIQUE NONCLUSTERED INDEX [IX_MyUser_EmailAddress] ON [dbo].[MyUser] 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [IX_MyUser_UserName]    Script Date: 08/16/2008 01:02:55 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[MyUser]') AND name = N'IX_MyUser_UserName')
CREATE UNIQUE NONCLUSTERED INDEX [IX_MyUser_UserName] ON [dbo].[MyUser] 
(
	[UserName] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MyApplication]    Script Date: 08/16/2008 01:02:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MyApplication]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MyApplication](
	[UniqueID] [uniqueidentifier] NOT NULL,
	[ApplicationName] [nvarchar](50) NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_MyApplication] PRIMARY KEY CLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MyRole]    Script Date: 08/16/2008 01:02:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MyRole]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MyRole](
	[UniqueID] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_MyRole] PRIMARY KEY CLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MyUserApplicationRole]    Script Date: 08/16/2008 01:02:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MyUserApplicationRole]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MyUserApplicationRole](
	[UserID] [uniqueidentifier] NOT NULL,
	[RoleID] [uniqueidentifier] NOT NULL,
	[ApplicationID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MySession]    Script Date: 08/16/2008 01:02:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MySession]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MySession](
	[UniqueID] [uniqueidentifier] NOT NULL,
	[ApplicationID] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateExpired] [datetime] NOT NULL,
	[DateLocked] [datetime] NOT NULL,
	[LockedId] [int] NOT NULL,
	[Locked] [bit] NOT NULL,
	[SessionItems] [nvarchar](max) NULL,
	[Flags] [int] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_MySession] PRIMARY KEY CLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MyUserApplicationRole_MyApplication]') AND parent_object_id = OBJECT_ID(N'[dbo].[MyUserApplicationRole]'))
ALTER TABLE [dbo].[MyUserApplicationRole]  WITH CHECK ADD  CONSTRAINT [FK_MyUserApplicationRole_MyApplication] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[MyApplication] ([UniqueID])
GO
ALTER TABLE [dbo].[MyUserApplicationRole] CHECK CONSTRAINT [FK_MyUserApplicationRole_MyApplication]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MyUserApplicationRole_MyRole]') AND parent_object_id = OBJECT_ID(N'[dbo].[MyUserApplicationRole]'))
ALTER TABLE [dbo].[MyUserApplicationRole]  WITH CHECK ADD  CONSTRAINT [FK_MyUserApplicationRole_MyRole] FOREIGN KEY([RoleID])
REFERENCES [dbo].[MyRole] ([UniqueID])
GO
ALTER TABLE [dbo].[MyUserApplicationRole] CHECK CONSTRAINT [FK_MyUserApplicationRole_MyRole]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MyUserApplicationRole_MyUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[MyUserApplicationRole]'))
ALTER TABLE [dbo].[MyUserApplicationRole]  WITH CHECK ADD  CONSTRAINT [FK_MyUserApplicationRole_MyUser] FOREIGN KEY([UserID])
REFERENCES [dbo].[MyUser] ([UniqueID])
GO
ALTER TABLE [dbo].[MyUserApplicationRole] CHECK CONSTRAINT [FK_MyUserApplicationRole_MyUser]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MySession_MyApplication]') AND parent_object_id = OBJECT_ID(N'[dbo].[MySession]'))
ALTER TABLE [dbo].[MySession]  WITH CHECK ADD  CONSTRAINT [FK_MySession_MyApplication] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[MyApplication] ([UniqueID])
GO
ALTER TABLE [dbo].[MySession] CHECK CONSTRAINT [FK_MySession_MyApplication]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MySession_MyUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[MySession]'))
ALTER TABLE [dbo].[MySession]  WITH CHECK ADD  CONSTRAINT [FK_MySession_MyUser] FOREIGN KEY([UserID])
REFERENCES [dbo].[MyUser] ([UniqueID])
GO
ALTER TABLE [dbo].[MySession] CHECK CONSTRAINT [FK_MySession_MyUser]
