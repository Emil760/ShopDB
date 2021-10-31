USE Shop


CREATE TYPE OrderPrductsMassive AS TABLE(
id_country INT,
id_product INT,
id_color INT,
id_size INT,
id_tuning INT,
id_gift INT,
price MONEY,
quantity SMALLINT
);


CREATE TYPE IntegerMassive AS TABLE(
id INT
);

CREATE TYPE StringMassive AS TABLE(
[name] NVARCHAR(100)
);