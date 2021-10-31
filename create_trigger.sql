USE Shop

CREATE OR ALTER TRIGGER ProductColors_InsertTrigger
ON ProductColors
INSTEAD OF INSERT
AS
BEGIN

	IF((SELECT COUNT(*) 
		FROM ProductColors
		WHERE id_product = (SELECT id_product FROM inserted) AND
		id_color = (SELECT id_color FROM inserted)) 
	= 0)
	BEGIN
		INSERT INTO ProductColors VALUES(
		(SELECT id_product FROM inserted),
		(SELECT id_color FROM inserted),
		(SELECT quantity FROM inserted))
	END
	ELSE
	BEGIN
		UPDATE ProductColors 
		SET quantity = quantity + (SELECT quantity FROM inserted)
		WHERE  id_product = (SELECT id_product FROM inserted) AND
		id_color = (SELECT id_color FROM inserted)
		RAISERROR('this color alredy exists new quantity was updated', 1, 1)
	END

END


CREATE OR ALTER TRIGGER ProductSizes_InsertTrigger
ON ProductSizes
INSTEAD OF INSERT
AS
BEGIN

	IF((SELECT COUNT(*)
		FROM ProductSizes 
		WHERE id_product = (SELECT id_product FROM inserted) AND
		id_size = (SELECT id_size FROM inserted)) 
	= 0)
	BEGIN
		INSERT INTO ProductSizes VALUES(
		(SELECT id_product FROM inserted),
		(SELECT id_size FROM inserted),
		(SELECT price FROM inserted),
		(SELECT quantity FROM inserted))
	END
	ELSE
	BEGIN
		UPDATE ProductSizes 
		SET price = (SELECT price FROM inserted),
		quantity = quantity + (SELECT quantity FROM inserted)
		WHERE id_product = (SELECT id_product FROM inserted) AND
		id_size = (SELECT id_size FROM inserted)
		RAISERROR('this size alredy exists new quantity and price was updated', 1 , 1)
	END

END


CREATE OR ALTER TRIGGER ProductTuning_InsertTrigger
ON ProductTunings
INSTEAD OF INSERT
AS
BEGIN

	IF(
	(SELECT COUNT(*)
	 FROM ProductTunings
	 WHERE id_product = (SELECT id_product FROM inserted) AND
	 [version] = (SELECT [version] FROM inserted))
	  = 0)

		INSERT INTO ProductTunings VALUES(
		(SELECT id_product FROM inserted),
		(SELECT [version] FROM inserted),
		(SELECT salon FROM inserted),
		(SELECT [power] FROM inserted),
		(SELECT has_spoiler FROM inserted),
		(SELECT price FROM inserted),
		(SELECT quantity FROM inserted)
		)
	ELSE
	BEGIN
		UPDATE ProductTunings 
		SET price = (SELECT price FROM inserted),
		quantity = quantity + (SELECT quantity FROM inserted)
		WHERE id_product = (SELECT id_product FROM inserted) AND
		[version] = (SELECT [version] FROM inserted)
		RAISERROR('this version alredy exists price and quantity was updated', 1, 1)
	END
END


CREATE OR ALTER TRIGGER  Reviews_InsertTrigger
ON Reviews
AFTER INSERT
AS
BEGIN
	
	IF((SELECT rating FROM Products WHERE id = (SELECT id_product FROM inserted)) = 0)
	BEGIN
		UPDATE Products 
		SET rating = (SELECT rating FROM inserted)
		WHERE id = (SELECT id_product FROM inserted)
	END
	ELSE
	BEGIN
		UPDATE Products
		SET rating = (rating + (SELECT rating FROM inserted)) / 2
		WHERE id = (SELECT id_product FROM inserted)
	END

END
