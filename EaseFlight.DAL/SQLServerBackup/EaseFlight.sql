USE [master]
GO
/****** Object:  Database [EaseFlight]    Script Date: 10/13/2019 17:45:21 ******/
CREATE DATABASE [EaseFlight]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AirlineReservation', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AirlineReservation.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AirlineReservation_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AirlineReservation_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [EaseFlight] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EaseFlight].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EaseFlight] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EaseFlight] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EaseFlight] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EaseFlight] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EaseFlight] SET ARITHABORT OFF 
GO
ALTER DATABASE [EaseFlight] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EaseFlight] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EaseFlight] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EaseFlight] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EaseFlight] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EaseFlight] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EaseFlight] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EaseFlight] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EaseFlight] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EaseFlight] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EaseFlight] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EaseFlight] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EaseFlight] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EaseFlight] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EaseFlight] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EaseFlight] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EaseFlight] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EaseFlight] SET RECOVERY FULL 
GO
ALTER DATABASE [EaseFlight] SET  MULTI_USER 
GO
ALTER DATABASE [EaseFlight] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EaseFlight] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EaseFlight] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EaseFlight] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EaseFlight] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EaseFlight', N'ON'
GO
ALTER DATABASE [EaseFlight] SET QUERY_STORE = OFF
GO
USE [EaseFlight]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[Password] [varchar](250) NULL,
	[FullName] [nvarchar](250) NULL,
	[Gender] [bit] NULL,
	[Birthday] [datetime] NULL,
	[Email] [varchar](250) NULL,
	[Phone] [varchar](50) NULL,
	[Address] [nvarchar](250) NULL,
	[Identification] [varchar](50) NULL,
	[Photo] [varchar](250) NULL,
	[ResetPasswordToken] [varchar](250) NULL,
	[ExpireToken] [datetime] NULL,
	[AccountTypeID] [int] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountType]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Roles] [varchar](250) NULL,
 CONSTRAINT [PK_AccountType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Airport]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airport](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[City] [nvarchar](250) NULL,
 CONSTRAINT [PK_Airport] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlightRoad]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlightRoad](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
 CONSTRAINT [PK_FlightRoad] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlightRoadAirport]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlightRoadAirport](
	[FlightRoadID] [int] NOT NULL,
	[AirportID] [int] NOT NULL,
	[PlaceTakeoff] [bit] NULL,
 CONSTRAINT [PK_FlightRoadAirport] PRIMARY KEY CLUSTERED 
(
	[FlightRoadID] ASC,
	[AirportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlightRoadSchedule]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlightRoadSchedule](
	[ScheduleID] [int] NOT NULL,
	[FlightRoadID] [int] NOT NULL,
	[PlaneID] [int] NOT NULL,
	[Order] [int] NULL,
 CONSTRAINT [PK_FlightRoadSchedule] PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC,
	[FlightRoadID] ASC,
	[PlaneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PassengerTicket]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PassengerTicket](
	[TicketID] [int] NULL,
	[FullName] [nvarchar](250) NULL,
	[Gender] [bit] NULL,
	[Birtday] [datetime] NULL,
	[PassengerTypeID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PassengerType]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PassengerType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Discount] [int] NULL,
 CONSTRAINT [PK_PassengerType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plane]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plane](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Airline] [varchar](250) NULL,
	[Status] [varchar](250) NULL,
 CONSTRAINT [PK_Plane] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlaneFlightRoad]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaneFlightRoad](
	[PlaneID] [int] NOT NULL,
	[FlightRoadID] [int] NOT NULL,
 CONSTRAINT [PK_PlaneFlightRoad] PRIMARY KEY CLUSTERED 
(
	[PlaneID] ASC,
	[FlightRoadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlaneSeatClass]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaneSeatClass](
	[PlaneID] [int] NOT NULL,
	[SeatClassID] [int] NOT NULL,
	[Chair] [int] NULL,
	[Price] [float] NULL,
 CONSTRAINT [PK_PlaneSeatClass] PRIMARY KEY CLUSTERED 
(
	[PlaneID] ASC,
	[SeatClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DepartureDate] [datetime] NULL,
	[ArrivalDate] [datetime] NULL,
	[Status] [varchar](250) NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SeatClass]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeatClass](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
 CONSTRAINT [PK_SeatClass] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ticket]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NULL,
	[Price] [float] NULL,
	[Discount] [int] NULL,
	[Description] [nvarchar](1250) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SeatClassID] [int] NULL,
	[PaymentID] [varchar](250) NULL,
	[Status] [varchar](250) NULL,
 CONSTRAINT [PK_Ticket] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TicketSchedule]    Script Date: 10/13/2019 17:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketSchedule](
	[TicketID] [int] NOT NULL,
	[ScheduleID] [int] NOT NULL,
	[RoundTrip] [bit] NULL,
 CONSTRAINT [PK_TicketSchedule] PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC,
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([ID], [Username], [Password], [FullName], [Gender], [Birthday], [Email], [Phone], [Address], [Identification], [Photo], [ResetPasswordToken], [ExpireToken], [AccountTypeID], [Status]) VALUES (1, N'admin', N'$2y$12$89o04hUjiLkhKeQBuqEEh.BZbO0yuEj.1RL2f/dJbzlLEyxgxZxaO', N'Nguyễn Admin', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[AccountType] ON 

INSERT [dbo].[AccountType] ([ID], [Name], [Roles]) VALUES (1, N'Super Admin', N'SA AD')
INSERT [dbo].[AccountType] ([ID], [Name], [Roles]) VALUES (2, N'Admin', N'AD')
INSERT [dbo].[AccountType] ([ID], [Name], [Roles]) VALUES (3, N'User', N'US')
SET IDENTITY_INSERT [dbo].[AccountType] OFF
SET IDENTITY_INSERT [dbo].[PassengerType] ON 

INSERT [dbo].[PassengerType] ([ID], [Name], [Discount]) VALUES (1, N'Adult', 0)
INSERT [dbo].[PassengerType] ([ID], [Name], [Discount]) VALUES (2, N'Child', 20)
INSERT [dbo].[PassengerType] ([ID], [Name], [Discount]) VALUES (3, N'Infant', 50)
SET IDENTITY_INSERT [dbo].[PassengerType] OFF
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_AccountType] FOREIGN KEY([AccountTypeID])
REFERENCES [dbo].[AccountType] ([ID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_AccountType]
GO
ALTER TABLE [dbo].[FlightRoadAirport]  WITH CHECK ADD  CONSTRAINT [FK_FlightRoadAirport_Airport] FOREIGN KEY([AirportID])
REFERENCES [dbo].[Airport] ([ID])
GO
ALTER TABLE [dbo].[FlightRoadAirport] CHECK CONSTRAINT [FK_FlightRoadAirport_Airport]
GO
ALTER TABLE [dbo].[FlightRoadAirport]  WITH CHECK ADD  CONSTRAINT [FK_FlightRoadAirport_FlightRoad] FOREIGN KEY([FlightRoadID])
REFERENCES [dbo].[FlightRoad] ([ID])
GO
ALTER TABLE [dbo].[FlightRoadAirport] CHECK CONSTRAINT [FK_FlightRoadAirport_FlightRoad]
GO
ALTER TABLE [dbo].[FlightRoadSchedule]  WITH CHECK ADD  CONSTRAINT [FK_FlightRoadSchedule_FlightRoad] FOREIGN KEY([FlightRoadID])
REFERENCES [dbo].[FlightRoad] ([ID])
GO
ALTER TABLE [dbo].[FlightRoadSchedule] CHECK CONSTRAINT [FK_FlightRoadSchedule_FlightRoad]
GO
ALTER TABLE [dbo].[FlightRoadSchedule]  WITH CHECK ADD  CONSTRAINT [FK_FlightRoadSchedule_Plane] FOREIGN KEY([PlaneID])
REFERENCES [dbo].[Plane] ([ID])
GO
ALTER TABLE [dbo].[FlightRoadSchedule] CHECK CONSTRAINT [FK_FlightRoadSchedule_Plane]
GO
ALTER TABLE [dbo].[FlightRoadSchedule]  WITH CHECK ADD  CONSTRAINT [FK_FlightRoadSchedule_Schedule] FOREIGN KEY([ScheduleID])
REFERENCES [dbo].[Schedule] ([ID])
GO
ALTER TABLE [dbo].[FlightRoadSchedule] CHECK CONSTRAINT [FK_FlightRoadSchedule_Schedule]
GO
ALTER TABLE [dbo].[PassengerTicket]  WITH CHECK ADD  CONSTRAINT [FK_PassengerTicket_PassengerType] FOREIGN KEY([PassengerTypeID])
REFERENCES [dbo].[PassengerType] ([ID])
GO
ALTER TABLE [dbo].[PassengerTicket] CHECK CONSTRAINT [FK_PassengerTicket_PassengerType]
GO
ALTER TABLE [dbo].[PassengerTicket]  WITH CHECK ADD  CONSTRAINT [FK_PassengerTicket_Ticket] FOREIGN KEY([TicketID])
REFERENCES [dbo].[Ticket] ([ID])
GO
ALTER TABLE [dbo].[PassengerTicket] CHECK CONSTRAINT [FK_PassengerTicket_Ticket]
GO
ALTER TABLE [dbo].[PlaneFlightRoad]  WITH CHECK ADD  CONSTRAINT [FK_PlaneFlightRoad_FlightRoad] FOREIGN KEY([FlightRoadID])
REFERENCES [dbo].[FlightRoad] ([ID])
GO
ALTER TABLE [dbo].[PlaneFlightRoad] CHECK CONSTRAINT [FK_PlaneFlightRoad_FlightRoad]
GO
ALTER TABLE [dbo].[PlaneFlightRoad]  WITH CHECK ADD  CONSTRAINT [FK_PlaneFlightRoad_Plane] FOREIGN KEY([PlaneID])
REFERENCES [dbo].[Plane] ([ID])
GO
ALTER TABLE [dbo].[PlaneFlightRoad] CHECK CONSTRAINT [FK_PlaneFlightRoad_Plane]
GO
ALTER TABLE [dbo].[PlaneSeatClass]  WITH CHECK ADD  CONSTRAINT [FK_PlaneSeatClass_Plane] FOREIGN KEY([PlaneID])
REFERENCES [dbo].[Plane] ([ID])
GO
ALTER TABLE [dbo].[PlaneSeatClass] CHECK CONSTRAINT [FK_PlaneSeatClass_Plane]
GO
ALTER TABLE [dbo].[PlaneSeatClass]  WITH CHECK ADD  CONSTRAINT [FK_PlaneSeatClass_SeatClass] FOREIGN KEY([SeatClassID])
REFERENCES [dbo].[SeatClass] ([ID])
GO
ALTER TABLE [dbo].[PlaneSeatClass] CHECK CONSTRAINT [FK_PlaneSeatClass_SeatClass]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_Account]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_SeatClass] FOREIGN KEY([SeatClassID])
REFERENCES [dbo].[SeatClass] ([ID])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_SeatClass]
GO
ALTER TABLE [dbo].[TicketSchedule]  WITH CHECK ADD  CONSTRAINT [FK_TicketSchedule_Schedule] FOREIGN KEY([ScheduleID])
REFERENCES [dbo].[Schedule] ([ID])
GO
ALTER TABLE [dbo].[TicketSchedule] CHECK CONSTRAINT [FK_TicketSchedule_Schedule]
GO
ALTER TABLE [dbo].[TicketSchedule]  WITH CHECK ADD  CONSTRAINT [FK_TicketSchedule_Ticket] FOREIGN KEY([TicketID])
REFERENCES [dbo].[Ticket] ([ID])
GO
ALTER TABLE [dbo].[TicketSchedule] CHECK CONSTRAINT [FK_TicketSchedule_Ticket]
GO
USE [master]
GO
ALTER DATABASE [EaseFlight] SET  READ_WRITE 
GO
