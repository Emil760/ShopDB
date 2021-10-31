USE Shop

CREATE DATABASE Shop
ON PRIMARY
(NAME = file1, FILENAME = 'C:\TempSQL\file1.mdf', SIZE = 1 MB, MAXSIZE = UNLIMITED,  FILEGROWTH = 2 MB),
(NAME = file2, FILENAME = 'C:\TempSQL\file2.ndf', SIZE = 1 MB, MAXSIZE = UNLIMITED, FILEGROWTH = 2 MB)
LOG ON
(NAME = log1, FILENAME = 'C:\TempSQL\log1.ldf', SIZE = 1 MB, MAXSIZE = 100 MB, FILEGROWTH = 1 MB),
(NAME = log2, FILENAME = 'C:\TempSQL\log2.ldf', SIZE = 1 MB, MAXSIZE = 100 MB, FILEGROWTH = 1 MB)

CREATE DATABASE Shop
ON (FILENAME = 'C:\TempSQL\file1.mdf')
FOR ATTACH 
-----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Authors(
id INT PRIMARY KEY IDENTITY(1,1),
[name] NVARCHAR(50) NOT NULL,
surname NVARCHAR(50) NOT NULL
);


CREATE TABLE Themes(
id INT PRIMARY KEY IDENTITY(1,1), 
[name] NVARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE Books(
id INT PRIMARY KEY IDENTITY(1,1),
id_author INT FOREIGN KEY REFERENCES Authors(id) NOT NULL,
id_theme INT FOREIGN KEY REFERENCES Themes(id) NOT NULL,
[year] SMALLINT NOT NULL,
price SMALLMONEY NOT NULL,
quantity SMALLINT DEFAULT 1 NOT NULL
);


CREATE TABLE ClothTypes(
id INT PRIMARY KEY IDENTITY(1,1),
[name] NVARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE Clothes(
id INT PRIMARY KEY IDENTITY(1,1),
gender NVARCHAR(20) NOT NULL,
id_type INT FOREIGN KEY REFERENCES ClothTypes(id) NOT NULL
);


CREATE TABLE Cars(
id INT PRIMARY KEY IDENTITY(1,1),
body NVARCHAR(50) NOT NULL,
transmission NVARCHAR(20) DEFAULT 'Auto' NOT NULL,
sit_count TINYINT DEFAULT 4 NOT NULL
);


CREATE TABLE Computers(
id INT PRIMARY KEY IDENTITY(1,1),
OS NVARCHAR(20),
screen_size TINYINT NOT NULL,
cpu_name NVARCHAR(30) NOT NULL,
cpu_speed REAL NOT NULL,
cores_count TINYINT NOT NULL,
ram_speed SMALLINT,
ram_capacity SMALLINT,
storage_type NVARCHAR(20),
storage_capacity SMALLINT,
has_camera BIT DEFAULT 1 NOT NULL,
price SMALLMONEY NOT NULL,
quantity SMALLINT DEFAULT 1 NOT NULL
);


CREATE TABLE Colors(
id INT PRIMARY KEY IDENTITY(1,1),
[name] NVARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE Sizes(
id INT PRIMARY KEY IDENTITY(1,1),
[name] NVARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE Manufactors(
id INT PRIMARY KEY IDENTITY(1,1),
[name] NVARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE ProductTypes(
id INT PRIMARY KEY IDENTITY(1,1),
[name] NVARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE Countries(
id INT PRIMARY KEY IDENTITY(1,1),
[name] NVARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE ContinentCountries(
continent NVARCHAR(30) NOT NULL,
id_country INT FOREIGN KEY REFERENCES Countries(id) NOT NULL
);


CREATE TABLE Customers(
id INT PRIMARY KEY IDENTITY(1,1),
[login] NCHAR(15) NOT NULL,
[password] NCHAR(15) NOT NULL,
age TINYINT NOT NULL,
id_country INT FOREIGN KEY REFERENCES Countries(id) NOT NULL, 
[card] CHAR(9) UNIQUE NOT NULL,
[money] MONEY DEFAULT 0 NOT NULL,

CONSTRAINT CK_Login CHECK(LEN([login]) >= 6 AND LEN([login]) <= 15),
CONSTRAINT CK_Password CHECK(LEN([password]) >= 6 AND LEN([password]) <= 15),
CONSTRAINT CK_Age CHECK (age > 16 AND age < 120),
CONSTRAINT CK_Card CHECK(LEN([card]) = 9)
);


CREATE TABLE Products(
id INT PRIMARY KEY IDENTITY(1,1),
id_type INT FOREIGN KEY REFERENCES ProductTypes(id) NOT NULl,
id_manufactor INT FOREIGN KEY REFERENCES Manufactors(id),
id_country INT FOREIGN KEY REFERENCES Countries(id) NOT NULL,
[name] NVARCHAR(100) NOT NULL,
[weight] FLOAT,
rating REAL DEFAULT 0,
is_active BIT DEFAULT 1 NOT NULL,
id_cloth INT FOREIGN KEY REFERENCES Clothes(id),
id_book INT FOREIGN KEY REFERENCES Books(id),
id_computer INT FOREIGN KEY REFERENCES Computers(id), 
id_car INT FOREIGN KEY REFERENCES Cars(id)
);


CREATE TABLE ProductCountries(
id_product INT FOREIGN KEY REFERENCES Products(id) NOT NULL,
id_country INT FOREIGN KEY REFERENCES Countries(id) NOT NULL
);


CREATE TABLE Gifts(
id INT PRIMARY KEY IDENTITY(1,1),
id_product INT FOREIGN KEY REFERENCES Products(id) NOT NULL,
[name] NVARCHAR(100) NOT NULL,
[description] NVARCHAR(300),
price SMALLMONEY DEFAULT 0 NOT NULL,
quantity SMALLINT DEFAULT 1 NOT NULL
);


CREATE TABLE Reviews(
id INT PRIMARY KEY IDENTITY(1,1),
id_customer INT FOREIGN KEY REFERENCES Customers(id) NOT NULL,
id_product INt FOREIGN KEY REFERENCES Products(id) NOT NULL,
rating REAL,
[text] NVARCHAR(500),
[date] DATE DEFAULT GETDATE() NOT NULL,

CONSTRAINT CK_rating CHECK(rating >= 1 AND rating <= 5)
);


CREATE TABLE ProductSizes(
id_product INT FOREIGN KEY REFERENCES Products(id) NOT NULL,
id_size INT FOREIGN KEY REFERENCES Sizes(id) NOT NULL,
price MONEY,
quantity SMALLINT DEFAULT 1 NOT NULL,

CONSTRAINT UK_ProductSize UNIQUE(id_product, id_size)
);


CREATE TABLE ProductColors(
id_product INT FOREIGN KEY REFERENCES Products(id) NOT NULL,
id_color INT FOREIGN KEY REFERENCES Colors(id) NOT NULL,
quantity SMALLINT DEFAULT 1 NOT NULL,

CONSTRAINT UK_ProductColor UNIQUE(id_product, id_color)
);


CREATE TABLE ProductTunings(
id INT PRIMARY KEY IDENTITY(1,1),
id_product INT FOREIGN KEY REFERENCES Products(id) NOT NULL,
[version] NVARCHAR(30) NOT NULL,
salon NVARCHAR(50) NOT NULL,
[power] SMALLINT NOT NULL,
has_spoiler BIT DEFAULT 0 NOT NULL,
price MONEY NOT NULL,
quantity SMALLINT DEFAULT 1 NOT NULL,

CONSTRAINT UK_ProductVersion UNIQUE(id_product, [version])
);


CREATE TABLE Orders(
id INT PRIMARY KEY IDENTITY(1,1),
id_customer INT FOREIGN KEY REFERENCES Customers(id) NOT NULL,
date_out DATE DEFAULT GETDATE() NOT NULL,
date_in DATE
);

CREATE TABLE OrderProducts(
id INT PRIMARY KEY IDENTITY(1,1),
id_order INT FOREIGN KEY REFERENCES Orders(id) NOT NULL,
id_country INT FOREIGN KEY REFERENCES Countries(id) NOT NULL,
id_product INT FOREIGN KEY REFERENCES Products(id) NOT NULL,
id_color INT FOREIGN KEY REFERENCES Colors(id),
id_size INT FOREIGN KEY REFERENCES Sizes(id),
id_tuning INT FOREIGN KEY REFERENCES ProductTunings(id),
id_gift INT FOREIGN KEY REFERENCES Gifts(id),
price MONEY NOT NULL,
shipping SMALLMONEY,
quantity SMALLINT DEFAULT 1 NOT NULL
); 