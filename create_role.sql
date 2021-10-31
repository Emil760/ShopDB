USE Shop

CREATE LOGIN SellerLogin
WITH
PASSWORD = 'seller123',
DEFAULT_DATABASE = Shop

CREATE LOGIN BookkeeperLogin
WITH 
PASSWORD = 'bookkeeper123',
DEFAULT_DATABASE = Shop


CREATE USER SellerUser
FOR LOGIN SellerLogin

CREATE USER BookkeeperUser
FROM LOGIN BookkeeperLogin


CREATE ROLE SellerRole
GRANT EXEC ON [dbo].[AddBook] TO SellerRole
GRANT EXEC ON [dbo].[AddCloth] TO SellerRole
GRANT EXEC ON [dbo].[AddCar] TO SellerRole
GRANT EXEC ON [dbo].[AddComputer] TO SellerRole
GRANT EXEC ON [dbo].[AddCountryProduct] TO SellerRole
GRANT EXEC ON [dbo].[AddProductColor] TO SellerRole
GRANT EXEC ON [dbo].[AddProductSize] TO SellerRole
GRANT EXEC ON [dbo].[AddProductTuning] TO SellerRole

CREATE ROLE BookkeeperRole
GRANT SELECT ON [dbo].[PopularColorByType] TO BookkeeperRole
GRANT SELECT ON [dbo].[PopularColorCar] TO BookkeeperRole
GRANT SELECT ON [dbo].[PopularColorCloth] TO BookkeeperRole
GRANT SELECT ON [dbo].[PopularSizeByType] TO BookkeeperRole
GRANT SELECT ON [dbo].[PopularSizeCloth] TO BookkeeperRole
GRANT EXEC ON CountryProductTypeByMonth TO BookkeeperRole

ALTER ROLE SellerRole
ADD MEMBER SellerUser

ALTER ROLE BookkeeperRole
ADD MEMBER BookkeeperUser
