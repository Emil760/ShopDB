USE Shop

INSERT INTO ContinentCountries VALUES
('North America', 7),
('North America', 3),
('Europe', 6),
('Europe', 1),
('Europe', 2),
('Europe', 5),
('Asia', 4)

select * from Countries

EXEC AddBook 'Book', 'manufactor1', 'France', 'book1', 80, 'name1', 'surname1', 'adventure', 2014 , 12, 4
EXEC AddBook 'Book', 'manufactor1', 'Germany', 'book2', 100, 'name5', 'surname5', 'sport', 2013 , 12, 2
EXEC AddBook 'Book', 'manufactor1', 'USA', 'book3', 100, 'name4', 'surname4', 'detective', 2012 , 12, 5
EXEC AddBook 'Book', 'manufactor2', 'China', 'book4', 120, 'name3', 'surname3', 'sport', 2015 , 12, 4
EXEC AddBook 'Book', 'manufactor2', 'USA', 'book5', 50, 'name4', 'surname4', 'detective', 2017 , 12, 3 
EXEC AddBook 'Book', 'manufactor4', 'Germany', 'book6', 60, 'name2', 'surname2', 'sport', 2019 , 12, 5
EXEC AddBook 'Book', 'manufactor2', 'USA', 'book7', 100, 'name3', 'surname3', 'instruction', 2014 , 12, 8
EXEC AddBook 'Book', 'manufactor5', 'USA', 'book8', 60, 'name3', 'surname3', 'instruction', 2015 , 12, 11
EXEC AddBook 'Book', 'manufactor1', 'China', 'book9', 130, 'name1', 'surname1', 'detective', 2013 , 12, 120
EXEC AddBook 'Book', 'manufactor4', 'Italy', 'book10', 80, 'name5', 'surname5', 'fantasy', 2012 , 12, 4
EXEC AddBook 'Book', 'manufactor5', 'Italy', 'book11', 100, 'name6', 'surname6', 'adventure', 2015 , 12, 9
EXEC AddBook 'Book', 'manufactor2', 'Italy', 'book12', 27, 'name2', 'surname2', 'fantasy', 2012 , 12, 4
EXEC AddBook 'Book', 'manufactor3', 'France', 'book13', 100, 'name1', 'surname1', 'adventure', 2013 , 12, 5
EXEC AddBook 'Book', 'manufactor2', 'Germany', 'book14', 100, 'name2', 'surname2', 'fantasy', 2014 , 12, 8


EXEC AddComputer 'Computer', 'Asus', 'China', 'comp1', 2.1, 'Windows', '15', 'i5-2010H', 2.2, 2, 1800, 4, 'HDD', 512, 1, 400, 32
EXEC AddComputer 'Computer', 'Asus', 'China', 'comp1', 2.1, 'Windows', '17', 'i5-10100', 3.1, 4, 3500, 8, 'SDD', 1024, 1, 2000, 10
EXEC AddComputer 'Computer', 'Lenova', 'Italy', 'comp1', 2.1, 'Windows', '17', 'i3-5110U', 2.0, 2, 2300, 12, 'SSHD', 512, 0, 1000, 3
EXEC AddComputer 'Computer', 'Asus', 'France', 'comp1', 2.1, 'Windows', '15', 'i7-5010HQ', 3, 4, 2800, 12, 'SSD', 1, 1, 2400, 3
EXEC AddComputer 'Computer', 'Apple', 'USA', 'comp1', 2.1, 'MacOS', '17', 'i7-9750H', 2.6, 6, 3400, 16, 'SSD', 2048, 1, 3400, 3
EXEC AddComputer 'Computer', 'Apple', 'USA', 'comp1', 2.1, 'MacOS', '12', 'i5-2010H', 2.2, 2, 2500, 4, 'HDD', 2048, 0, 1400, 8
EXEC AddComputer 'Computer', 'Hp', 'USA','comp1', 2.1, 'Linux', '15', 'i5-2010H', 2.2, 2, 2500, 12, 'SSHD', 2048, 1, 2440, 9
EXEC AddComputer 'Computer', 'Microsoft', 'USA', 'comp1', 2.1, 'Linux', '12', 'i9-9900K', 3.0, 2, 3800, 32, 'SSD', 3072, 1, 5500, 10


EXEC AddCar 'Car', 'BMW', 'Germany', 'car1', 1500, 'Sedan', 'Auto', 4, 'black leather', 350, 0, 32000,4
EXEC AddCar 'Car', 'Aston Martin', 'England', 'car2', 1000, 'Sedan', 'Auto', 2, 'white leather', 650, 0, 123000, 2
EXEC AddCar 'Car', 'Mercedes', 'Germany', 'car3', 1500, 'Sedan', 'Auto', 4, 'red leather with wood', 300, 1, 320000, 3
EXEC AddCar 'Car', 'Audi', 'Germany', 'car4', 1500, 'Targa', 'Auto', 2, 'carbon', 500, 0, 235000, 5
EXEC AddCar 'Car', 'Renault', 'France', 'car5', 2500, 'Hatchback', 'Auto', 4, 'wool with wood', 250, 0, 150000, 2
EXEC AddCar 'Car', 'Peugeot', 'France', 'car6', 2500, 'Hatchback', 'Auto', 4, 'wool', 350, 0, 50000, 5  
EXEC AddCar 'Car', 'BMW', 'Germany', 'car7', 1500, 'Crossover', 'Auto', 4, 'black leather', 350, 1, 35000, 4 
EXEC AddCar 'Car', 'Honda', 'USA', 'car8', 3450, 'Cabriolet', 'Auto',  2, 'leather', 500, 1, 450000, 7
EXEC AddCar 'Car', 'Peugeot', 'France', 'car9', 2000, 'Crossover', 'Manual', 4,'leather', 114, 0, 23000, 9
EXEC AddCar 'Car', 'Pagani', 'Italy', 'car10', 2000, 'Cabriolet', 'Auto', 2, 'leather', 905, 1, 90000, 2
EXEC AddCar 'Car', 'Aston Martin', 'China', 'car11', 3450,' Sedan', 'Auto', 4, 'leather', 309, 0, 22000, 6


EXEC AddProductTuning 23, 'Sport', 'black leather', 600, 1, 89000, 2
EXEC AddProductTuning 24, 'GT', 'white leather with wood', 700, 0, 165000, 3
EXEC AddProductTuning 25, 'Comfort', 'brown leather', 500, 1, 100000, 3
EXEC AddProductTuning 23, 'Sport+', 'black leather', 600, 0, 110000, 5
EXEC AddProductTuning 24, 'Sport', 'black leather', 550, 0, 190000, 2
EXEC AddProductTuning 25, 'Sport+', 'yellow leather', 600, 1, 230000, 5
EXEC AddProductTuning 26, 'Sport+', 'black leather', 570, 1, 82900, 6


EXEC AddCloth 'Cloth', 'manufactor1', 'Germany', 'cloth1', 0.1, 'male', 'Jeans'
EXEC AddCloth 'Cloth', 'manufactor2','Germany', 'cloth2', 0.06, 'male', 'Shorts'
EXEC AddCloth 'Cloth', 'manufactor4',  'USA', 'cloth3', 0.05, 'female', 'Blouse'
EXEC AddCloth 'Cloth', 'manufactor4', 'Italy', 'cloth4', 0.1, 'kids', 'Jeans'
EXEC AddCloth 'Cloth', 'manufactor5', 'Italy', 'cloth5', 0.15, 'female', 'Jacket'
EXEC AddCloth 'Cloth', 'manufactor6', 'France', 'cloth6', 0.015, 'aged', 'Socks'
EXEC AddCloth 'Cloth', 'manufactor6',' France', 'cloth7', 0.015, 'female', 'Socks'
EXEC AddCloth 'Cloth', 'manufactor8', 'USA', 'cloth8', 0.08, 'male', 'Jeans'
EXEC AddCloth 'Cloth', 'manufactor8', 'USA', 'cloth9', 0.02, 'aged', 'Socks'


EXEC AddProductColor 34, 'green', 30
EXEC AddProductColor 34, 'red', 40
EXEC AddProductColor 35, 'blue', 45
EXEC AddProductColor 35, 'red', 50
EXEC AddProductColor 36, 'white', 16
EXEC AddProductColor 36, 'black', 23
EXEC AddProductColor 37, 'green', 25
EXEC AddProductColor 37, 'pink', 53
EXEC AddProductColor 38, 'yellow', 34
EXEC AddProductColor 38, 'gray', 18
EXEC AddProductColor 38, 'black', 23
EXEC AddProductColor 39, 'black', 45
EXEC AddProductColor 40, 'black', 4
EXEC AddProductColor 40, 'white', 5
EXEC AddProductColor 41, 'green', 3


EXEC AddProductColor 23, 'gray', 4
EXEC AddProductColor 23, 'gold', 3
EXEC AddProductColor 24, 'yellow', 6
EXEC AddProductColor 25, 'yellow', 1
EXEC AddProductColor 26, 'gray', 2
EXEC AddProductColor 27, 'green', 5
EXEC AddProductColor 28, 'blue', 4
EXEC AddProductColor 28, 'black', 2


EXEC AddProductSize 34, 'S', 24, 36
EXEC AddProductSize 34, 'M', 25, 32
EXEC AddProductSize 35, 'S', 26, 30
EXEC AddProductSize 35, 'M', 14, 28
EXEC AddProductSize 36, 'L', 10, 26
EXEC AddProductSize 37, 'M', 15, 18
EXEC AddProductSize 37, 'L', 18, 24
EXEC AddProductSize 37, 'L', 20, 18
EXEC AddProductSize 38, 'S', 10, 16
EXEC AddProductSize 38, 'M', 12, 22
EXEC AddProductSize 38, 'L', 14, 20
EXEC AddProductSize 39, 'S', 20, 15
EXEC AddProductSize 40, 'M', 22, 22
EXEC AddProductSize 41, 'S', 24, 23
EXEC AddProductSize 42, 'S', 15, 20


INSERT INTO ProductCountries VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1,6),
(2, 1),
(3, 1), (3, 2), (3, 6), 
(4, 2), (4, 4), (4, 6),
(5, 1), (5, 3), (5, 4), (5, 5),
(6, 3), (6, 4), (6,5),
(7, 3),
(8, 1), (8, 2), (8, 4), (8,5),

(9, 1), (9, 4),
(10, 2),
(11, 3),
(12, 5),
(13, 3), (13, 5), (13,6),
(14, 1), (14, 5), (14,6),
(15, 1), (15, 4), (15,5), (15,6),
(16, 1), (16, 2),(16 ,4),

(17 ,1), (17, 2), (17, 3), (17, 4),
(18, 2), (18 ,3), (18,4),
(19, 3),
(20 ,1), (20, 3), (20,4), (20,6),
(21 ,1), (21, 3), (21, 4), (21, 6),
(22 ,1), (22, 3), (22,4), (22,6),
(23 ,1), (23, 3), (23,4),

(24 ,1), 
(25 ,1), 
(26, 5), (26, 6),
(27, 5), (27, 6),
(28, 5), (28, 6),
(29, 5), (29, 6),
(30, 5), (30, 6),
(31, 1), (31, 2), (31, 3),
(32, 1), (32, 2), (32, 3), (32, 4), (32, 5),
(33, 1), (33, 3), (33, 4), (33, 5),
(34, 1), (34, 5), (34, 6),
(35, 1), (35, 3),
(36, 1),
(37, 1), (37, 6),
(38, 1), (38, 3), (38, 4), (38, 5),
(39, 1), (39, 2), (39, 3), (39, 4),
(40, 1), (40, 2), (40, 3), (40, 4), (40, 5), (40, 6)


INSERT INTO Customers VALUES
('login1', 'password1', 19, 1, '0000-0000', 1000000),
('login2', 'password2', 21, 2, '0000-0001', 1200000),
('login3', 'password3', 33, 3, '0000-0002', 1300000),
('login4', 'password4', 48, 4, '0000-0003', 1400000),
('login5', 'password5', 56, 5, '0000-0005', 1500000)


INSERT INTO Reviews VALUES
(1, 1, 3, 'review1', '2019-4-15'),
(1, 2, 3, 'review2', '2019-4-15'),
(2, 3, 4, 'review3', '2019-5-2'),
(2, 4, 5, 'review4', '2019-3-2'),
(2, 5, 3, 'review5', '2019-4-15'),
(2, 6, 4, 'review5', '2019-4-15'),
(3, 1, 2, 'review6', '2019-5-13'),
(3, 7, 3, 'review7', '2019-1-28'),
(3, 8, 5, 'review8', '2019-4-15'),
(3, 9, 2, 'review9', '2019-4-15'),
(4, 10, 5, 'review10', '2019-6-21'),
(4, 11, 5, 'review11', '2019-4-15'),
(4, 12, 5, 'review12', '2019-1-28'),
(4, 13, 2, 'review13', '2019-4-3'),
(5, 14, 3, 'review14', '2019-7-18'),
(5, 15, 1, 'review15', '2019-7-18'),
(5, 16, 4, 'review16', '2019-7-18'),
(5, 17, 5, 'review17', '2019-7-18'),
(5, 18, 2, 'review18', '2019-7-18'),
(5, 19, 1, 'review19', '2019-7-18'),
(1, 3, 5, 'review20', '2018-5-3')


EXEC ShowProductInCountry 'USA', 'Book'
EXEC ShowProductInCountry 'USA', 'Cloth'
EXEC ShowProductInCountry 'USA', 'Computer'
EXEC ShowProductInCountry 'USA', 'Car'
select * from ProductTunings where id_product = 23
------
DECLARE @orders1 OrderPrductsMassive 

INSERT INTO @orders1(id_product, id_country, id_tuning, id_color, price, quantity) VALUES(23, 3, 12, 8, 89000, 1)
INSERT INTO @orders1(id_product, id_country, price, quantity) VALUES(3, 6, 12, 2)
INSERT INTO @orders1(id_product, id_country, id_color, id_size, price, quantity) VALUES(36, 1, 4, 3, 26, 5)

EXEC AddOrder 1, @orders1
------
DECLARE @orders2 OrderPrductsMassive

INSERT INTO @orders2(id_product, id_country, price, quantity) VALUES(9, 1, 12, 3)
INSERT INTO @orders2(id_product, id_country, id_color, id_size, price, quantity) VALUES(39, 1, 5, 1, 20, 5)

EXEC AddOrder 1, @orders2
------
DECLARE @orders3 OrderPrductsMassive

INSERT INTO @orders3(id_product, id_country, price, quantity) VALUES(6, 4, 2, 12)

EXEC AddORder 3, @orders3