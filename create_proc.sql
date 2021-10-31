USE Shop


CREATE OR ALTER PROCEDURE FindProducBasictInfo(
@type NVARCHAR(50),
@manufactor NVARCHAR(100),
@country NVARCHAR(50),
@id_type INT OUT,
@id_manufactor INT OUT,
@id_country INT OUT
)
AS
BEGIN
	
	SET @id_type = (SELECT id FROM ProductTypes WHERE [name] = @type)
	IF(@id_type IS NULL)
	BEGIN
		INSERT INTO ProductTypes VALUES(@type)
		SET @id_type = (SELECT MAX(id) FROM ProductTypes)
		RAISERROR('new type was added', 1, 1)
	END
	
	SET @id_manufactor = (SELECT id FROM Manufactors WHERE [name] = @manufactor)
	IF(@id_manufactor IS NULL)
	BEGIN
		INSERT INTO Manufactors VALUES(@manufactor)
	    SET @id_manufactor = (SELECT MAX(id) FROM Manufactors)
		RAISERROR('new manufactor was added', 1 ,1)
	END

	SET @id_country = (SELECT id FROM Countries WHERE [name] = @country)
	IF(@id_country IS NULL)
	BEGIN
		INSERT INTO Countries VALUES(@country)
		SET @id_country = (SELECT MAX(id) FROM Countries)
		RAISERROR('new country was added', 1, 1)
	END

END;


CREATE OR ALTER PROCEDURE AddBook(
@type NVARCHAR(50),
@manufactor NVARCHAR(100),
@country NVARCHAR(50),
@name NVARCHAR(100),
@weight REAL,
@author_name NVARCHAR(50),
@author_surname NVARCHAR(50),
@theme NVARCHAR(50),
@year SMALLINT,
@price SMALLMONEY,
@quantity SMALLINT = 1
)
AS
BEGIN

	DECLARE @id_author INT, @id_theme INT, @id_type INT, @id_manufactor INT, @id_country INT, @id_book INT
	EXEC FindProducBasictInfo @type, @manufactor, @country, @id_type OUT, @id_manufactor OUT, @id_country OUT 
				
	SET @id_author = (SELECT id FROM Authors WHERE [name] = @author_name AND surname = @author_surname)
	IF(@id_author IS NULL)
	BEGIN
		INSERT INTO Authors VALUES(@author_name, @author_surname)
		SET @id_author = (SELECT MAX(id) FROM Authors)
	END

	SET @id_theme = (SELECT id FROM Themes WHERE [name] = @theme)
	IF(@id_theme IS NULL)
	BEGIN
		INSERT INTO Themes VALUES (@theme)
		SET @id_theme = (SELECT MAX(id) FROM Themes)
		RAISERROR('new theme was added', 1, 1)
	END

	INSERT INTO Books VALUES(@id_author, @id_theme, @year, @price, @quantity)
	SET @id_book = (SELECT MAX(id) FROM Books)

	INSERT INTO Products(id_type, id_manufactor, id_country, [name], [weight], id_book) VALUES
	(@id_type, @id_manufactor, @id_country, @name, @weight, @id_book)
    
END;


CREATE OR ALTER PROCEDURE AddCar(
@type NVARCHAR(50),
@manufactor NVARCHAR(100),
@country NVARCHAR(50),
@name NVARCHAR(100),
@weight FLOAT,
@body NVARCHAR(50),
@transmission NVARCHAR(30) = 'Auto',
@sit_count TINYINT = 4,
@salon NVARCHAR(50),
@power SMALLINT,
@has_spoiler BIT,
@price MONEY,
@quantity SMALLINT = 1
)
AS
BEGIN
		
	DECLARE @id_type INT, @id_manufactor INT, @id_country INT, @id_car INT
	EXEC FindProducBasictInfo @type, @manufactor, @country, @id_type OUT, @id_manufactor OUT, @id_country OUT 

	INSERT INTO Cars VALUES (@body, @transmission, @sit_count)
	SET @id_car = (SELECT MAX(id) FROM Cars)

	INSERT INTO Products(id_type, id_manufactor, id_country, [name], [weight], id_car)
	VALUES (@id_type, @id_manufactor, @id_country, @name, @weight, @id_car)

	INSERT INTO ProductTunings VALUES
	((SELECT MAX(id) FROM Products), 'Standart', @salon, @power, @has_spoiler, @price, @quantity)

END


CREATE OR ALTER PROCEDURE AddCloth(
@type NVARCHAR(50),
@manufactor NVARCHAR(100),
@country NVARCHAR(50),
@name NVARCHAR(100),
@weight REAL,
@gender NVARCHAR(20),
@cloth_type NVARCHAR(30)
)
AS
BEGIN
	
	DECLARE @id_type INT, @id_manufactor INT, @id_country INT, @id_cloth_type INT, @id_cloth INT
	EXEC FindProducBasictInfo @type, @manufactor, @country, @id_type OUT, @id_manufactor OUT, @id_country OUT 

	SET @id_cloth_type = (SELECT id FROM ClothTypes WHERE [name] = @cloth_type)
	IF(@id_cloth_type IS NULL)
	BEGIN
		INSERT INTO ClothTypes VALUES(@cloth_type)
		SET @id_cloth_type = (SELECT MAX(id) FROM ClothTypes)
		RAISERROR('new cloth type was added', 1, 1)
	END

	INSERT INTO Clothes VALUES(@gender, @id_cloth_type)
	SET @id_cloth = (SELECT MAX(id) FROM Clothes)
	
	INSERT INTO Products(id_type, id_manufactor, id_country, [name], [weight], id_cloth)
	VALUES(@id_type, @id_manufactor, @id_country, @name, @weight, @id_cloth)

END


CREATE OR ALTER PROCEDURE AddComputer(
@type NVARCHAR(50),
@manufactor NVARCHAR(100),
@country NVARCHAR(50),
@name NVARCHAR(100),
@weight REAL,
@OS NVARCHAR(20),
@screen_size TINYINT,
@cpu_name NVARCHAR(20),
@cpu_speed REAL,
@cores_count TINYINT,
@ram_speed SMALLINT,
@ram_capacity SMALLINT,
@storage_type NVARCHAR(20),
@storage_capacity SMALLINT,
@has_camera BIT,
@price SMALLMONEY,
@quantity SMALLINT = 1
)
AS
BEGIN
	
	DECLARE @id_type INT, @id_manufactor INT, @id_country INT, @id_computer INT
	EXEC FindProducBasictInfo @type, @manufactor, @country, @id_type OUT, @id_manufactor OUT, @id_country OUT 

	INSERT INTO Computers VALUES
	(@OS, @screen_size, @cpu_name, @cpu_speed, @cores_count, @ram_speed, @ram_capacity, @storage_type, @storage_capacity, @price, @has_camera, @quantity)
	SET @id_computer = (SELECT MAX(id) FROM Computers)
	
	INSERT INTO Products(id_type, id_manufactor, id_country, [name], [weight], id_computer) 
	VALUES(@id_type, @id_manufactor, @id_country, @name, CAST(@weight AS FLOAT), @id_computer)

END


CREATE OR ALTER PROCEDURE AddProductColor(
@id_product INT,
@color NVARCHAR(50),
@quantity SMALLINT = 1
)
AS
BEGIN

	DECLARE @id_color INT
	SET @id_color = (SELECT id FROM Colors WHERE [name] = @color)
	
	IF((SELECT id FROM Products WHERE id = @id_product) IS NULL)
	BEGIN
		RAISERROR('this product dont exists', 11, 1)
		RETURN
	END

	IF(@id_color IS NULL)
	BEGIN
		INSERT INTO Colors VALUES(@color)
		SET @id_color = (SELECT MAX(id) FROM Colors)
		RAISERROR('new color added', 1, 1)
	END
		
	INSERT INTO ProductColors VALUES(@id_product, @id_color, @quantity)
	
END


CREATE OR ALTER PROCEDURE AddProductSize(
@id_product INT,
@size NVARCHAR(20),
@price MONEY,
@quantity SMALLINT
)
AS
BEGIN

	DECLARE @id_size INT
	SET @id_size = (SELECT id FROM Sizes WHERE [name] = @size)

	IF((SELECT id FROM Products WHERE id = @id_product) IS NULL)
	BEGIN
		RAISERROR('this product dont exists', 11, 1)
		RETURN
	END

	IF(@id_size IS NULL)
	BEGIN
		INSERT INTO Sizes VALUES(@size)
		SET @id_size = (SELECT MAX(id) FROM Sizes)
		RAISERROR('new size added', 1, 1)
	END

	INSERT INTO ProductSizes VALUES(@id_product, @id_size, @price, @quantity)

END


CREATE OR ALTER PROCEDURE AddProductTuning(
@id_product INT,
@version NVARCHAR(50),
@salon NVARCHAR(50),
@power SMALLINT,
@has_spoiler BIT,
@price MONEY,
@quantity SMALLINT = 1
)
AS
BEGIN
	
	IF((SELECT id FROM Products WHERE id = @id_product) IS NOT NULL)
		INSERT INTO ProductTunings VALUES(@id_product, @version, @salon, @power, @has_spoiler, @price, @quantity)
	ELSE
		RAISERROR('this product dont exists', 11, 1)
END;


CREATE OR ALTER PROCEDURE AddReview(
@id_product INT,
@id_customer INT,
@rating REAL,
@text NVARCHAR(300),
@date DATE 
)
AS
BEGIN
	
	IF((SELECT id FROM Customers WHERE id = @id_customer) IS NULL)
	BEGIN
		RAISERROR('this customer dont exists', 11, 1)
		RETURN
	END

	IF((SELECT id FROM Products WHERE id = @id_product) IS NULL)
	BEGIN
		RAISERROR('this product dont exists', 11, 1)
		RETURN
	END

	INSERT INTO Reviews VALUES(@id_product, @id_customer, @rating, @text, @date)

END


CREATE OR ALTER PROCEDURE AddOrder(
@id_customer INT,
@orders OrderPrductsMassive READONLY
)
AS
BEGIN
	
	DECLARE @id_order INT, @id_country INT, @id_product INT, @id_color INT, @id_size INT, @id_tuning INT, @id_gift INT, @price MONEY, @quantity INT
	
	INSERT INTO Orders(id_customer, date_out) VALUES(@id_customer, GETDATE())
	SET @id_order = (SELECT MAX(id) FROM Orders)

	DECLARE cur CURSOR FOR
	SELECT * FROM @orders

	OPEN cur
	FETCH NEXT FROM cur INTO @id_country, @id_product,  @id_color, @id_size, @id_tuning, @id_gift, @price, @quantity

	WHILE(@@FETCH_STATUS = 0)
	BEGIN

		IF(@id_gift IS NOT NULL)
			SET @price = @price + (SELECT price FROM Gifts WHERE id = @id_gift)

		INSERT INTO OrderProducts(id_order, id_country, id_product, id_color, id_size, id_tuning, id_gift, price, quantity, shipping)
		VALUES (@id_order, @id_country, @id_product, @id_color, @id_size, @id_tuning, @id_gift,  @price, @quantity,
		dbo.ShippingCheck(@id_customer, @id_country, @id_product, @quantity))
		
		FETCH NEXT FROM cur INTO @id_country, @id_product, @id_color, @id_size, @id_tuning, @id_gift, @price, @quantity
		EXEC DecreaseProductQuantity @id_product, @id_gift, @id_color, @id_size, @id_tuning, @quantity
	END

	CLOSE cur
	DEALLOCATE cur
	
END


CREATE OR ALTER PROCEDURE DecreaseProductQuantity(@id_product INT, @id_gift INT, @id_color INT, @id_size INT, @id_tuning INT, @quantity SMALLINT)
AS
BEGIN

	DECLARE @id_book INT,  @id_computer INT, @id_car INT, @id_cloth INT
	
	SELECT @id_book = id_book, @id_cloth = id_cloth, @id_car = id_car, @id_cloth = id_cloth
	FROM Products
	WHERE id = @id_product

	IF(@id_book IS NOT NULL)
	BEGIN
		UPDATE Books
		SET quantity = quantity - @quantity
		WHERE id = @id_book
	END
	ELSE IF(@id_computer IS NOT NULL)
	BEGIN
		UPDATE Computers
		SET quantity = quantity - @quantity
		WHERE id = @id_computer
	END
	ELSE IF(@id_car IS NOT NULL)
	BEGIN
		UPDATE ProductTunings 
		SET quantity = quantity - @quantity
		WHERE id = @id_tuning

		UPDATE ProductColors 
		SET quantity = quantity - @quantity
		WHERE id_product = @id_product AND id_color = @id_color
	END
	ELSE IF(@id_cloth IS NOT NULL)
	BEGIN
		UPDATE ProductColors
		SET quantity = quantity - @quantity
		WHERE id_product = @id_product AND id_color = @id_color  
		
		UPDATE ProductSizes 
		SET quantity = quantity - @quantity
		WHERE id_product = @id_product AND id_size = @id_size
	END

	IF(@id_gift IS NOT NULL)
	BEGIN
		UPDATE Gifts 
		SET quantity = quantity - 1
		WHERE id = @id_gift
	END

END 


CREATE OR ALTER PROCEDURE FindProductSizes(@id_product INT)
AS
BEGiN

	SELECT	Sizes.id, Sizes.[name], ProductSizes.price,	ProductSizes.quantity
	FROM ProductSizes
	INNER JOIN Sizes ON Sizes.id = ProductSizes.id_size
	WHERE id_product = @id_product

END


CREATE OR ALTER PROCEDURE FindProductGifts(@id_product INT)
AS
BEGIN

	SELECT [name], [description], price
	FROM Gifts 
	WHERE id_product = @id_product

END


CREATE OR ALTER PROCEDURE FindProductTunings(@id_product INT)
AS
BEGIN
	
	SELECT [version], salon, [power], has_spoiler, price, quantity
	FROM ProductTunings
	WHERE id_product = @id_product

END 


CREATE OR ALTER PROCEDURE FindProductColors(@id_product INT)
AS
BEGIN

	SELECT Colors.id, Colors.[name], ProductColors.quantity
	FROM ProductColors
	INNER JOIN Colors ON Colors.id = ProductColors.id_color
	WHERE ProductColors.id_product = @id_product
	
END


CREATE OR ALTER PROCEDURE FilterClothes(
@manufactors IntegerMassive READONLY,
@types IntegerMassive READONLY,
@genders StringMassive READONLY,
@sizes IntegerMassive READONLY,
@colors IntegerMassive READONLY,
@rating TINYINT,
@money_from SMALLMONEY,
@money_to SMALLMONEY
)
AS
BEGIN
	
	SELECT * FROM
	(
		SELECT 
		Products.id,
		Manufactors.[name] AS 'manufactor name',
		Products.[name] AS 'name',
		Products.[weight],
		Products.rating,
		Clothes.gender,
		ClothTypes.[name] AS 'cloth type'	
		FROM Products
		INNER JOIN Manufactors ON Manufactors.id = Products.id_manufactor
		INNER JOIN Clothes ON Clothes.id = Products.id_cloth
		INNER JOIN ClothTypes ON ClothTypes.id = Clothes.id_type
		INNER JOIN ProductSizes ON ProductSizes.id_size = Products.id
		INNER JOIN ProductColors ON ProductColors.id_color = Products.id
		WHERE Clothes.gender IN (SELECT [name] FROM @genders)
		AND ClothTypes.id IN (SELECT id FROM @types)  
		AND ProductSizes.id_size IN (SELECT id FROM @sizes) 
		AND ProductColors.id_color IN (SELECT id FROM @colors)
		AND ProductSizes.price BETWEEN @money_from AND @money_to
		AND Manufactors.id IN (SELECT id FROM @manufactors)	
		AND Products.rating = @rating
		AND Products.is_active = 1
	) AS Pr1
	INNER JOIN 
	(
		SELECT 
		ProductSizes.id_product,
		MIN(ProductSizes.price) AS 'min price',
		MAX(ProductSizes.price) AS 'max price'
		FROM ProductSizes
		GROUP BY ProductSizes.id_product
	) AS Pr2
	ON Pr1.id = Pr2.id_product

END


CREATE OR ALTER PROCEDURE FilterComputer(
@manufactors IntegerMassive READONLY,
@cpus StringMassive READONLY,
@min_core_count TINYINT,
@max_core_count TINYINT,
@min_ram_capacity TINYINT,
@max_ram_capacity TINYINT,
@min_storage_capacity SMALLINT,
@max_storage_capacity SMALLINT,
@rating TINYINT,
@min_price SMALLMONEY,
@max_price SMALLMONEY
)
AS
BEGIN

	SELECT 
	Products.id,
	Manufactors.[name] AS 'manufactor name',
	Products.[name] AS 'name',
	Products.[weight],
	Products.rating,
	Computers.OS,
	Computers.screen_size,
	Computers.cpu_name,
	Computers.cpu_speed,
	Computers.cores_count,
	Computers.ram_speed,
	Computers.ram_capacity,
	Computers.storage_type,
	Computers.storage_capacity,
	Computers.has_camera,
	Computers.price,
	Computers.quantity
	FROM Products	
	INNER JOIN Manufactors ON Manufactors.id = Products.id_manufactor
	INNER JOIN Computers ON Computers.id = Products.id_computer
	WHERE Manufactors.id IN (SELECT id FROM @manufactors)
	AND SUBSTRING(Computers.cpu_name,0,2) IN (SELECT [name] FROM @cpus)
	AND Computers.cores_count BETWEEN @min_core_count AND @max_core_count
	AND Computers.ram_capacity BETWEEN @min_ram_capacity AND @max_ram_capacity
	AND Computers.storage_capacity BETWEEN @min_storage_capacity AND @max_storage_capacity
	AND Products.rating = @rating
	AND Products.is_active = 1

END


CREATE OR ALTER PROCEDURE FilterCar(
@manufactors IntegerMassive READONLY,
@bodies StringMassive READONLY,
@colors IntegerMassive READONLY,
@rating TINYINT,
@min_price MONEY,
@max_price MONEY
)
AS
BEGIN

	SELECT
	Products.id,
	Manufactors.[name],
	Products.[name],
	Products.[weight],
	Products.rating,
	Cars.body,
	Cars.transmission,
	Cars.sit_count
	FROM Products
	INNER JOIN Manufactors ON Manufactors.id = Products.id_manufactor
	INNER JOIN ProductColors ON ProductColors.id_product = Products.id
	INNER JOIN Cars ON Cars.id = Products.id_car
	INNER JOIN ProductTunings ON ProductTunings.id_product = Products.id
	WHERE ProductTunings.[version] = 'Standart'
	AND Manufactors.id IN (SELECT id FROM @manufactors)
	AND Cars.body IN (SELECT [name] FROM @bodies)
	AND ProductColors.id_color IN (SELECT id FROM @colors)
	AND Products.rating = @rating
	AND ProductTunings.price BETWEEN @min_price AND @max_price
	AND Products.is_active = 1

END


CREATE OR ALTER PROCEDURE FilterBook(
@themes IntegerMassive READONLY,
@rating TINYINT,
@min_price SMALLMONEY,
@max_price SMALLMONEY
)
AS
BEGIN
	
	SELECT 
	Products.[name],
	Products.rating,
	Themes.[name] AS 'theme name',
	Authors.[name] AS 'author name',
	Authors.surname AS 'author surname'
	FROM Products
	INNER JOIN Books ON Books.id = Products.id_book
	INNER JOIN Themes ON Themes.id = Books.id_theme
	INNER JOIN Authors ON Authors.id = Books.id_author
	WHERE Books.id_theme IN (SELECT id FROM Themes)
	AND Products.rating = @rating 
	AND Books.price BETWEEN @min_price AND @max_price
	AND Products.is_active = 1

END 


CREATE OR ALTER PROCEDURE ShowProductInCountry(@country NVARCHAR(50), @type NVARCHAR(50))
AS
BEGIN

	SELECT 
	Products.id AS 'product id',
	Manufactors.[name] AS 'manufactor name',
	Countries.[name] AS 'country name',
	Products.[name] AS 'product',
	Products.[weight],
	Products.rating 
	FROM Products
	INNER JOIN Manufactors ON Manufactors.id = Products.id_manufactor
	INNER JOIN Countries ON Countries.id = Products.id_country
	WHERE Products.id_country = (SELECT id FROM Countries WHERE [name] = @country)
	AND Products.id_type = (SELECT id FROM ProductTypes WHERE [name] = @type) 
	AND is_active = 1

END


select * from Products where id = 3
