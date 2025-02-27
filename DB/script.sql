CREATE DATABASE [RiceWarehouse]
GO

USE [RiceWarehouse]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 2/20/2025 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[Gender] [nvarchar](10) NULL,
	[Age] [int] NULL,
	[Address] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Debts]    Script Date: 2/20/2025 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Debts](
	[DebtID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[DebtType] [nvarchar](1) NOT NULL,
	[Amount] [decimal](15, 2) NOT NULL,
	[Note] [nvarchar](max) NULL,
	[DebtDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DebtID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PorterTransactions]    Script Date: 2/20/2025 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PorterTransactions](
	[PorterTransactionID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionID] [int] NOT NULL,
	[PorterFee] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PorterTransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rice]    Script Date: 2/20/2025 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rice](
	[RiceID] [int] IDENTITY(1,1) NOT NULL,
	[RiceName] [nvarchar](255) NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[RiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RiceInSection]    Script Date: 2/20/2025 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiceInSection](
	[RiceSectionID] [int] IDENTITY(1,1) NOT NULL,
	[RiceID] [int] NOT NULL,
	[SectionID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RiceSectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 2/20/2025 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [int] IDENTITY(1,1) NOT NULL,
	[OwnerID] [int] NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](max) NULL,
	[Username] [nvarchar](100) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionHistory]    Script Date: 2/20/2025 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionHistory](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[TransactionDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 2/20/2025 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionType] [nvarchar](10) NOT NULL,
	[RiceID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[TransactionDate] [datetime] NULL,
	[PorterService] [bit] NULL,
	[TotalAmount] [decimal](15, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2/20/2025 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](max) NULL,
	[StoreName] [nvarchar](255) NULL,
	[Username] [nvarchar](100) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[Role] [nvarchar](10) NOT NULL,
	[Email] [nvarchar](255),
	[IsBanned] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WarehouseSections]    Script Date: 2/20/2025 10:51:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WarehouseSections](
	[SectionID] [int] IDENTITY(1,1) NOT NULL,
	[SectionName] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber]) VALUES (1, N'John Doe', N'Male', 35, N'123 Main St, City', N'1234567890')
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber]) VALUES (2, N'Jane Smith', N'Female', 28, N'456 Elm St, Town', N'0987654321')
INSERT [dbo].[Customers] ([CustomerID], [FullName], [Gender], [Age], [Address], [PhoneNumber]) VALUES (3, N'Alex Johnson', N'Other', 40, N'789 Pine St, Village', N'1122334455')
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Debts] ON 

INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate]) VALUES (1, 1, N'-', CAST(500.00 AS Decimal(15, 2)), N'Pending payment for rice order', CAST(N'2025-02-20T15:50:45.840' AS DateTime))
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate]) VALUES (2, 2, N'+', CAST(200.00 AS Decimal(15, 2)), N'Advance payment received', CAST(N'2025-02-20T15:50:45.840' AS DateTime))
INSERT [dbo].[Debts] ([DebtID], [CustomerID], [DebtType], [Amount], [Note], [DebtDate]) VALUES (3, 3, N'-', CAST(750.00 AS Decimal(15, 2)), N'Owed for previous order', CAST(N'2025-02-20T15:50:45.840' AS DateTime))
SET IDENTITY_INSERT [dbo].[Debts] OFF
GO
SET IDENTITY_INSERT [dbo].[PorterTransactions] ON 

INSERT [dbo].[PorterTransactions] ([PorterTransactionID], [TransactionID], [PorterFee]) VALUES (1, 1, CAST(2000.00 AS Decimal(10, 2)))
INSERT [dbo].[PorterTransactions] ([PorterTransactionID], [TransactionID], [PorterFee]) VALUES (2, 3, CAST(2000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[PorterTransactions] OFF
GO
SET IDENTITY_INSERT [dbo].[Rice] ON 

INSERT [dbo].[Rice] ([RiceID], [RiceName], [Price], [Description]) VALUES (1, N'Jasmine Rice', CAST(25.50 AS Decimal(10, 2)), N'High-quality fragrant rice')
INSERT [dbo].[Rice] ([RiceID], [RiceName], [Price], [Description]) VALUES (2, N'Basmati Rice', CAST(30.00 AS Decimal(10, 2)), N'Long-grain aromatic rice')
INSERT [dbo].[Rice] ([RiceID], [RiceName], [Price], [Description]) VALUES (3, N'Brown Rice', CAST(20.75 AS Decimal(10, 2)), N'Whole grain rice with high fiber content')
SET IDENTITY_INSERT [dbo].[Rice] OFF
GO
SET IDENTITY_INSERT [dbo].[RiceInSection] ON 

INSERT [dbo].[RiceInSection] ([RiceSectionID], [RiceID], [SectionID], [Quantity]) VALUES (1, 1, 1, 500)
INSERT [dbo].[RiceInSection] ([RiceSectionID], [RiceID], [SectionID], [Quantity]) VALUES (2, 2, 2, 300)
INSERT [dbo].[RiceInSection] ([RiceSectionID], [RiceID], [SectionID], [Quantity]) VALUES (3, 3, 3, 200)
SET IDENTITY_INSERT [dbo].[RiceInSection] OFF
GO
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([StaffID], [OwnerID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash]) VALUES (1, 2, N'Michael Brown', N'7778889999', N'567 Worker St', N'michael', N'hashed_password4')
INSERT [dbo].[Staff] ([StaffID], [OwnerID], [FullName], [PhoneNumber], [Address], [Username], [PasswordHash]) VALUES (2, 2, N'Sarah Connor', N'6667778888', N'890 Labor Ave', N'sarah', N'hashed_password5')
SET IDENTITY_INSERT [dbo].[Staff] OFF
GO
SET IDENTITY_INSERT [dbo].[TransactionHistory] ON 

INSERT [dbo].[TransactionHistory] ([HistoryID], [TransactionID], [CustomerID], [TransactionDate]) VALUES (1, 1, 1, CAST(N'2025-02-20T15:50:45.830' AS DateTime))
INSERT [dbo].[TransactionHistory] ([HistoryID], [TransactionID], [CustomerID], [TransactionDate]) VALUES (2, 2, 2, CAST(N'2025-02-20T15:50:45.830' AS DateTime))
INSERT [dbo].[TransactionHistory] ([HistoryID], [TransactionID], [CustomerID], [TransactionDate]) VALUES (3, 3, 3, CAST(N'2025-02-20T15:50:45.830' AS DateTime))
INSERT [dbo].[TransactionHistory] ([HistoryID], [TransactionID], [CustomerID], [TransactionDate]) VALUES (4, 1, 1, CAST(N'2025-02-20T15:50:45.867' AS DateTime))
INSERT [dbo].[TransactionHistory] ([HistoryID], [TransactionID], [CustomerID], [TransactionDate]) VALUES (5, 2, 2, CAST(N'2025-02-20T15:50:45.867' AS DateTime))
INSERT [dbo].[TransactionHistory] ([HistoryID], [TransactionID], [CustomerID], [TransactionDate]) VALUES (6, 3, 3, CAST(N'2025-02-20T15:50:45.867' AS DateTime))
SET IDENTITY_INSERT [dbo].[TransactionHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[Transactions] ON 

INSERT [dbo].[Transactions] ([TransactionID], [TransactionType], [RiceID], [CustomerID], [Quantity], [TransactionDate], [PorterService], [TotalAmount]) VALUES (1, N'Import', 1, 1, 100, CAST(N'2025-02-20T15:50:45.820' AS DateTime), 1, CAST(2550.00 AS Decimal(15, 2)))
INSERT [dbo].[Transactions] ([TransactionID], [TransactionType], [RiceID], [CustomerID], [Quantity], [TransactionDate], [PorterService], [TotalAmount]) VALUES (2, N'Export', 2, 2, 50, CAST(N'2025-02-20T15:50:45.820' AS DateTime), 0, CAST(1500.00 AS Decimal(15, 2)))
INSERT [dbo].[Transactions] ([TransactionID], [TransactionType], [RiceID], [CustomerID], [Quantity], [TransactionDate], [PorterService], [TotalAmount]) VALUES (3, N'Import', 3, 3, 200, CAST(N'2025-02-20T15:50:45.820' AS DateTime), 1, CAST(4150.00 AS Decimal(15, 2)))
SET IDENTITY_INSERT [dbo].[Transactions] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [StoreName], [Username], [PasswordHash], [Role], [IsBanned]) VALUES (1, N'Admin User', N'5551112222', N'789 Center St', N'Main Store', N'admin', N'hashed_password1', N'Admin', 0)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [StoreName], [Username], [PasswordHash], [Role], [IsBanned]) VALUES (2, N'Store Owner', N'5553334444', N'456 Trade St', N'Local Mart', N'owner', N'hashed_password2', N'Owner', 0)
INSERT [dbo].[Users] ([UserID], [FullName], [PhoneNumber], [Address], [StoreName], [Username], [PasswordHash], [Role], [IsBanned]) VALUES (3, N'Warehouse Staff', N'5556667777', N'321 Worker St', NULL, N'staff', N'hashed_password3', N'Staff', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[WarehouseSections] ON 

INSERT [dbo].[WarehouseSections] ([SectionID], [SectionName]) VALUES (1, N'Section A')
INSERT [dbo].[WarehouseSections] ([SectionID], [SectionName]) VALUES (2, N'Section B')
INSERT [dbo].[WarehouseSections] ([SectionID], [SectionName]) VALUES (3, N'Section C')
SET IDENTITY_INSERT [dbo].[WarehouseSections] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__85FB4E38DA893D55]    Script Date: 2/20/2025 10:51:36 PM ******/
ALTER TABLE [dbo].[Customers] ADD UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Rice__3E2A633E071F06C6]    Script Date: 2/20/2025 10:51:36 PM ******/
ALTER TABLE [dbo].[Rice] ADD UNIQUE NONCLUSTERED 
(
	[RiceName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Staff__536C85E439AA6E52]    Script Date: 2/20/2025 10:51:36 PM ******/
ALTER TABLE [dbo].[Staff] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Staff__85FB4E383BECA425]    Script Date: 2/20/2025 10:51:36 PM ******/
ALTER TABLE [dbo].[Staff] ADD UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E4CF5FD05E]    Script Date: 2/20/2025 10:51:36 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__85FB4E3871BE311F]    Script Date: 2/20/2025 10:51:36 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Warehous__8DACF8BE09ADF11C]    Script Date: 2/20/2025 10:51:36 PM ******/
ALTER TABLE [dbo].[WarehouseSections] ADD UNIQUE NONCLUSTERED 
(
	[SectionName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Debts] ADD  DEFAULT (getdate()) FOR [DebtDate]
GO
ALTER TABLE [dbo].[PorterTransactions] ADD  DEFAULT ((2000)) FOR [PorterFee]
GO
ALTER TABLE [dbo].[TransactionHistory] ADD  DEFAULT (getdate()) FOR [TransactionDate]
GO
ALTER TABLE [dbo].[Transactions] ADD  DEFAULT (getdate()) FOR [TransactionDate]
GO
ALTER TABLE [dbo].[Transactions] ADD  DEFAULT ((0)) FOR [PorterService]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsBanned]
GO
ALTER TABLE [dbo].[Debts]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PorterTransactions]  WITH CHECK ADD FOREIGN KEY([TransactionID])
REFERENCES [dbo].[Transactions] ([TransactionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RiceInSection]  WITH CHECK ADD FOREIGN KEY([RiceID])
REFERENCES [dbo].[Rice] ([RiceID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RiceInSection]  WITH CHECK ADD FOREIGN KEY([SectionID])
REFERENCES [dbo].[WarehouseSections] ([SectionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD FOREIGN KEY([OwnerID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TransactionHistory]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[TransactionHistory]  WITH CHECK ADD FOREIGN KEY([TransactionID])
REFERENCES [dbo].[Transactions] ([TransactionID])
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD FOREIGN KEY([RiceID])
REFERENCES [dbo].[Rice] ([RiceID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD CHECK  (([Gender]='Other' OR [Gender]='Female' OR [Gender]='Male'))
GO
ALTER TABLE [dbo].[Debts]  WITH CHECK ADD CHECK  (([DebtType]='-' OR [DebtType]='+'))
GO
ALTER TABLE [dbo].[RiceInSection]  WITH CHECK ADD CHECK  (([Quantity]>=(0)))
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD CHECK  (([TransactionType]='Import' OR [TransactionType]='Export'))
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([Role]='Staff' OR [Role]='Owner' OR [Role]='Admin'))
GO
