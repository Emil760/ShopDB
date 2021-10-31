USE Shop

select * from Products

CREATE OR ALTER VIEW ProdcutBasicInfos
AS
SELECT 
Products.id,
ProductTypes.[name] AS 'type',
Countries.[name] AS 'location',
Manufactors.[name] AS 'manufactor',
Products.[name] AS 'product',
Products.[weight],
Products.rating
FROM Products
INNER JOIN ProductTypes ON ProductTypes.id = Products.id_type
INNER JOIN Countries ON Countries.id = Products.id_country
INNER JOIN Manufactors ON Manufactors.id = Products.id_manufactor
WHERE is_active = 1


CREATE OR ALTER VIEW BookInfos
AS
SELECT
Products.id AS 'id',
Countries.[name] AS 'location',
Products.[name] AS 'book name',
Authors.[name] AS 'author name',
Authors.surname AS 'author surname',
Themes.[name] AS 'theme',
Books.[year],
Books.price,
Books.quantity
FROM Products
INNER JOIN Countries ON Countries.id = Products.id_country
INNER JOIN Books ON Books.id = Products.id_book
INNER JOIN Authors ON Authors.id = Books.id_author
INNER JOIN Themes ON Themes.id = Books.id_theme
WHERE Products.is_active = 1


CREATE OR ALTER VIEW ClothInfos
AS
SELECT id, locathion, manufactor, [weight], rating, [cloth type], gender, [min price], [max price] FROM
(
	SELECT
	Products.id AS 'id',
	Countries.[name] AS 'locathion',
	Manufactors.[name] AS 'manufactor',
	Products.[name] AS 'name',
	Products.[weight],
	Products.rating,
	ClothTypes.[name] AS 'cloth type',
	Clothes.gender
	FROM Products
	INNER JOIN Countries ON Countries.id = Products.id_country
	INNER JOIN Manufactors ON Manufactors.id = Products.id_manufactor
	INNER JOIN Clothes ON Clothes.id = Products.id_cloth
	INNER JOIN ClothTypes ON ClothTypes.id = Clothes.id_type
	WHERE Products.is_active = 1
) AS Pr1
INNER JOIN
(
	SELECT 
	id_product,
	MIN(price) AS 'min price',
	MAX(price) AS 'max price'
	FROM ProductSizes
	GROUP BY id_product
) AS Pr2
ON Pr1.id = Pr2.id_product


CREATE OR ALTER VIEW CarStandartInfos
AS
SELECT
id,
manufactor,
[location],
[car name],
body,
transmission,
salon,
[power],
[has spoiler],
price,
quantity
FROM ProductTuningsInfos
WHERE ProductTuningsInfos.[version] = 'Standart'


CREATE OR ALTER VIEW ProductTuningsInfos
AS
SELECT
Products.id AS 'id',
Countries.[name] AS 'location',
Manufactors.[name] AS 'manufactor',
Products.[name] AS 'car name',
Products.[weight],
Products.rating,
Cars.body,
Cars.transmission,
ProductTunings.[version],
ProductTunings.salon,
ProductTunings.[power],
ProductTunings.has_spoiler AS 'has spoiler',
ProductTunings.price,
ProductTunings.quantity
FROM Products
INNER JOIN Countries ON Countries.id = Products.id_country
INNER JOIN Manufactors ON Manufactors.id = Products.id_manufactor
INNER JOIN Cars ON Cars.id = Products.id_car
INNER JOIN ProductTunings ON Products.id = ProductTunings.id_product
WHERE is_active = 1	


CREATE OR ALTER VIEW ProductColorInfos
AS
SELECT 
Products.[name] AS 'product name',
Colors.[name] AS 'color',
ProductColors.quantity
FROM Products
INNER JOIN ProductColors ON ProductColors.id_product = Products.id
INNER JOIN Colors ON Colors.id = ProductColors.id_color
WHERE Products.is_active = 1


CREATE OR ALTER VIEW ProductSizeInfos
AS
SELECT
Products.[name] AS 'product name',
Sizes.[name] as 'size',
ProductSizes.price,
ProductSizes.quantity
FROM Products
INNER JOIN ProductSizes ON ProductSizes.id_product = Products.id
INNER JOIN Sizes ON Sizes.id = ProductSizes.id_size
WHERE Products.is_active = 1



CREATE OR ALTER VIEW ProductGiftInfo
AS
SELECT
Products.[name] AS 'product name',
Gifts.[name] AS 'gift',
Gifts.[description],
Gifts.price,
Gifts.quantity
FROM Gifts
INNER JOIN Products ON Products.id = Gifts.id_product
WHERE is_active = 1


CREATE OR ALTER VIEW PopularColorCloth
AS
SELECT
ClothTypes.[name] AS 'cloth type',
Colors.[name] AS 'color',
SUM(OrderProducts.price * OrderProducts.quantity) AS 'sum',
SUM(OrderProducts.quantity) AS 'count'
FROM OrderProducts
INNER JOIN Products ON Products.id = OrderProducts.id_product
INNER JOIN Clothes ON Clothes.id = Products.id_cloth
INNER JOIN ClothTypes ON ClothTypes.id = Clothes.id_type
INNER JOIN Colors ON Colors.id = OrderProducts.id_color
GROUP BY ClothTypes.[name], Colors.[name]


CREATE OR ALTER VIEW PopularColorCar
AS
SELECT
Colors.[name] AS 'color name',
SUM(OrderProducts.price * OrderProducts.quantity) AS 'sum',
SUM(OrderProducts.quantity) AS 'count'
FROM OrderProducts
INNER JOIN Products ON Products.id = OrderProducts.id_product
INNER JOIN ProductTunings ON ProductTunings.id_product = Products.id
INNER JOIN Colors ON Colors.id = OrderProducts.id_color
GROUP BY Colors.[name]


CREATE OR ALTER VIEW PopularSizeCloth
AS
SELECT 
ClothTypes.[name] AS 'cloth type',
Sizes.[name] AS 'size',
SUM(OrderProducts.quantity) AS 'count',
SUM(OrderProducts.price * OrderProducts.quantity) AS 'sum'
FROM OrderProducts
INNER JOIN Products ON Products.id = OrderProducts.id_product
INNER JOIN Clothes ON Clothes.id = Products.id_cloth
INNER JOIN ClothTypes ON ClothTypes.id = Clothes.id_type
INNER JOIN Sizes ON Sizes.id = OrderProducts.id_size
GROUP BY ClothTypes.[name], Sizes.[name]


CREATE OR ALTER VIEW NonActiveProductInfos
AS
SELECT
Products.id,
Products.[name] AS 'product name',
ProductTypes.[name] AS 'product type',
Manufactors.[name] AS 'manufactor name'
FROM Products
INNER JOIN Manufactors ON Manufactors.id = Products.id_manufactor
INNER JOIN ProductTypes ON ProductTypes.id = Products.id_type
WHERE Products.is_active = 0


CREATE OR ALTER VIEW ReviewInfos
AS
SELECT 
Customers.[login] AS 'customer login',
Countries.[name] AS 'customer counutry',
ProductTypes.[name] AS 'product type',
Products.[name] AS 'product name',
Reviews.rating,
Reviews.[text],
Reviews.[date]
FROM Reviews
INNER JOIN Customers ON Customers.id = Reviews.id_customer
INNER JOIN Countries ON Countries.id = Customers.id_country
INNER JOIN Products ON Products.id = Reviews.id_product
INNER JOIN ProductTypes ON ProductTypes.id = Products.id_type


CREATE OR ALTER VIEW CustomerBuyInfos
AS
SELECT [order prod id], [customer login], [from], [to], [date out], [date in],
	   [product id], manufactor, [product name], rating, [weight], price, shipping, quantity, [gift name]
FROM
(
	SELECT 
	OrderProducts.id AS 'order prod id',
	Customers.[login] AS 'customer login',
	Countries.[name] AS 'to',
	Orders.date_out AS 'date out',
	Orders.date_in AS 'date in',
	Products.id AS 'product id',
	Manufactors.[name] AS 'manufactor',
	Products.[name] AS 'product name',
	Products.rating,
	Products.[weight],
	OrderProducts.price,
	OrderProducts.shipping,
	OrderProducts.quantity,
	Gifts.[name] AS 'gift name'
	FROM OrderProducts
	INNER JOIN Orders ON Orders.id = OrderProducts.id_order
	INNER JOIN Customers ON Customers.id = Orders.id_customer
	INNER JOIN Countries ON Countries.id = OrderProducts.id_country 
	INNER JOIN Products ON Products.id = OrderProducts.id_product
	INNER JOIN Manufactors ON Manufactors.id = Products.id_manufactor
	LEFT JOIN Gifts ON Gifts.id_product = Products.id
) AS Pr1
INNER JOIN
(
	SELECT 
	OrderProducts.id,
	Countries.[name] AS 'from'
	FROM OrderProducts
	INNER JOIN Countries ON Countries.id = OrderProducts.id_country
) AS Pr2
ON Pr1.[order prod id] = Pr2.id


CREATE OR ALTER VIEW ClothBuyInfos
AS
SELECT
CustomerBuyInfos.[customer login],
CustomerBuyInfos.[from],
CustomerBuyInfos.[to],
CustomerBuyInfos.[date out],
CustomerBuyInfos.[date in],
CustomerBuyInfos.manufactor,
CustomerBuyInfos.[product name], 
ClothTypes.[name] AS 'cloth type',
Clothes.gender,
Colors.[name] AS 'color',
Sizes.[name] AS 'size',
CustomerBuyInfos.rating,
CustomerBuyInfos.[weight],
CustomerBuyInfos.price,
CustomerBuyInfos.shipping,
CustomerBuyInfos.quantity,
CustomerBuyInfos.[gift name]
FROM
CustomerBuyInfos
INNER JOIN Products ON Products.id = [product id]
INNER JOIN OrderProducts ON OrderProducts.id = [order prod id] 
INNER JOIN Clothes ON Clothes.id = Products.id_cloth
INNER JOIN ClothTypes ON ClothTypes.id = Clothes.id_type
INNER JOIN Colors ON Colors.id = OrderProducts.id_color
INNER JOIN Sizes ON Sizes.id = OrderProducts.id_size


CREATE OR ALTER VIEW ComputerBuyInfos
AS
SELECT 
CustomerBuyInfos.[customer login],
CustomerBuyInfos.[from],
CustomerBuyInfos.[to],
CustomerBuyInfos.[date out],
CustomerBuyInfos.[date in],
CustomerBuyInfos.manufactor,
CustomerBuyInfos.[product name], 
Computers.OS,
Computers.screen_size AS 'screen size',
Computers.cpu_name AS 'cpu name',
Computers.cpu_speed AS 'cpu speed',
Computers.cores_count AS 'cores count',
Computers.ram_capacity AS 'ram capacity',
Computers.ram_speed AS 'ram speed',
Computers.storage_type AS 'storage type',
Computers.storage_capacity AS 'storage capacity',
CASE(Computers.has_camera)
	WHEN 0 THEN 'No'
	ELSE 'Yes'
END AS 'camera',
CustomerBuyInfos.rating,
CustomerBuyInfos.[weight],
CustomerBuyInfos.price,
CustomerBuyInfos.shipping,
CustomerBuyInfos.quantity,
CustomerBuyInfos.[gift name]
FROM CustomerBuyInfos
INNER JOIN Products ON Products.id = [product id]
INNER JOIN Computers ON Computers.id = Products.id_computer



CREATE OR ALTER VIEW BookBuyInfos
AS
SELECT 
CustomerBuyInfos.[customer login],
CustomerBuyInfos.[from],
CustomerBuyInfos.[to],
CustomerBuyInfos.[date out],
CustomerBuyInfos.[date in],
CustomerBuyInfos.manufactor,
CustomerBuyInfos.[product name], 
Authors.[name] AS 'author name',
Authors.surname AS 'author surname',
Themes.[name] AS 'theme name',
Books.[year],
CustomerBuyInfos.rating,
CustomerBuyInfos.[weight],
CustomerBuyInfos.price,
CustomerBuyInfos.shipping,
CustomerBuyInfos.quantity,
CustomerBuyInfos.[gift name]
FROM CustomerBuyInfos
INNER JOIN Products ON Products.id = [product id]
INNER JOIN Books ON Books.id = Products.id_book
INNER JOIN Authors ON Authors.id = Books.id_author
INNER JOIN Themes ON Themes.id = Books.id_theme


CREATE OR ALTER VIEW CarBuyInfos
AS
SELECT
CustomerBuyInfos.[customer login],
CustomerBuyInfos.[from],
CustomerBuyInfos.[to],
CustomerBuyInfos.[date out],
CustomerBuyInfos.[date in],
CustomerBuyInfos.manufactor,
CustomerBuyInfos.[product name], 
Cars.body,
Cars.transmission,
Cars.sit_count AS 'sit count',
ProductTunings.[version],
ProductTunings.salon,
ProductTunings.[power],
CASE(ProductTunings.has_spoiler)
	WHEN 0 THEN 'No'
	ELSE 'Yes'
END AS 'has spoiler',
CustomerBuyInfos.rating,
CustomerBuyInfos.[weight],
CustomerBuyInfos.price,
CustomerBuyInfos.shipping,
CustomerBuyInfos.quantity,
CustomerBuyInfos.[gift name]
FROM CustomerBuyInfos
INNER JOIN Products ON Products.id = [product id]
INNER JOIN Cars ON Cars.id = Products.id_car
INNER JOIN ProductTunings ON ProductTunings.id_product = Products.id

--CREATE OR ALTER PROCEDURE ProductTypeByMonth (@year SMALLINT)
--AS
--BEGIN
	
--	SELECT
--	ProductTypes.[name] AS 'product type',
--	MONTH(Orders.date_out) AS 'month',
--	SUM(OrderProducts.quantity) AS 'count',
--	SUM(OrderProducts.price * OrderProducts.quantity) AS 'sum'
--	FROM OrderProducts
--	INNER JOIN Orders ON Orders.id = OrderProducts.id_order
--	INNER JOIN Products ON OrderProducts.id_product = Products.id
--	INNER JOIN ProductTypes ON ProductTypes.id = Products.id_type
--	WHERE YEAR(Orders.date_out) = @year
--	GROUP BY ProductTypes.[name],  MONTH(Orders.date_out)

--END

exec ProductTypeByMonth 2020

CREATE OR ALTER PROCEDURE CountryProductTypeByMonth(
@countries StringMassive READONLY,
@types StringMassive READONLY,
@years IntegerMassive READONLY)
AS
BEGIN

	SELECT
	Countries.[name] AS 'country',
	ProductTypes.[name] AS 'type',
	MONTH(Orders.date_out) AS 'month',
	SUM(OrderProducts.quantity) AS 'count',
	SUM(OrderProducts.price * OrderProducts.quantity) AS 'sum'
	FROM OrderProducts
	INNER JOIN Orders ON Orders.id = OrderProducts.id_order
	INNER JOIN Customers ON Customers.id = Orders.id_customer
	LEFT JOIN Countries ON Countries.id = Customers.id_country
	INNER JOIN Products ON OrderProducts.id_product = Products.id
	INNER JOIN ProductTypes ON ProductTypes.id = Products.id_type
	WHERE Countries.[name] IN (SELECT [name] FROM @countries)
	AND ProductTypes.[name] IN (SELECT [name] FROM @types) 
	AND YEAR(Orders.date_out) IN (SELECT id FROM @years)
	GROUP BY Countries.[name], ProductTypes.[name],  MONTH(Orders.date_out)

END


