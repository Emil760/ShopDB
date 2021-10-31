USE Shop


CREATE OR ALTER FUNCTION ShippingCheck(@id_customer INT, @id_country INT, @id_product INT, @quantity SMALLINT)
RETURNS SMALLMONEY
AS
BEGIN
	
	DECLARE @temp REAL
	DECLARE @shipping SMALLMONEY
	DECLARE @weight FLOAT 

	SET @weight = (SELECT [weight] FROM Products WHERE id = @id_product)
	--basic price for shipping
	SET @shipping = 5

	IF(@quantity > 200) SET @temp = 3
	ELSE IF(@quantity > 150) SET @temp = 2.8
	ELSE IF(@quantity > 100) SET @temp = 2.5
	ELSE IF(@quantity > 50) SET @temp = 2
	ELSE IF(@quantity > 25) SET @temp = 1.8
	ELSE IF(@quantity > 10) SET @temp = 1.5
	ELSE IF(@quantity > 5) SET @temp = 1.2
	ELSE SET @temp = 1

	IF(@weight > 10000) SET @shipping = @shipping * @temp * 3
	ELSE IF(@weight > 1000) SET @shipping = @shipping * @temp * 2
	ELSE IF(@weight > 100) SET @shipping = @shipping * @temp * 1.8
	ELSE IF(@weight > 10) SET @shipping = @shipping * @temp * 1.6
	ELSE IF(@weight > 5) SET @shipping = @shipping * @temp * 1.4
	ELSE IF(@weight > 1) SET @shipping = @shipping * @temp * 1.2

	IF((SELECT continent FROM ContinentCountries WHERE id_country =
		(SELECT id_country FROM Customers WHERE id = @id_customer ))
	= @id_country)
		SET @shipping = @shipping * ((100 + 20) / 100)
	ELSE
		SET @shipping = @shipping * ((100 + 50) / 100)
	
	RETURN @shipping

END