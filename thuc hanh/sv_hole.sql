
CREATE TABLE [dbo].[SINHVIEN_HOLE](
	[MaSinhVien] [nvarchar](10) NOT NULL,
	[MaLop] [nvarchar](15) NOT NULL,
	[HoDem] [nvarchar](45) NOT NULL,
	[Ten] [nvarchar](15) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [bit] NOT NULL,
	[NoiSinh] [nvarchar](250) NULL,
 CONSTRAINT [PK_SINHVIEN_HOLE ] PRIMARY KEY CLUSTERED 
(
	[MaSinhVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
)

GO
