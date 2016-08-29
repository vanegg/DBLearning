sqlite3 EssentialSQL.db
.schema 

#Agrega a la tabla de Orders una nueva orden relacionándola con un cliente existente. 
#Adicionalmente para esta nueva orden crea dos registros en la tabla de OrderDetails. 

INSERT INTO Orders (CustomerID, OrderDate, RequiredDate, ShippedDate)
VALUES ('2', '2016-04-13', '2016-05-12', '2016-05-23');

INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity)
Values ('21','5','9.97','20');

INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity)
Values ('21','2','0.25','10');

-- La empresa Floor Co. creará una nueva empresa y te esta pidiendo que las ordenes que hizo en 2013 se las asignes a esta nueva empresa. Para ello deberás:

-- Primero crear un nuevo cliente en la tabla Customers. (Inventa los datos)
-- Has una consulta para saber cuales son las ordenes de la empresa Floor Co.
-- Finalmente deberás cambiar a las ordenes de 2013 su valor de CustomerID

INSERT INTO Customers (CompanyName, ContactName, ContactTitle, Address, City, State)
Values ('Roof Co', 'Jim Wood', 'Installer', '328 Private Lane', 'CDMX', 'MX');

SELECT * FROM Orders 
WHERE (CustomerID = ( SELECT CustomerID FROM Customers WHERE CompanyName = 'Floor Co.'));

UPDATE Orders 
SET CustomerID = (SELECT CustomerID FROM Customers WHERE CompanyName = 'Roof Co') 
WHERE CustomerID = (SELECT CustomerID FROM Customers WHERE CompanyName = 'Floor Co.');

#EJEMPLO
-- A los registros de la tabla OrderDetails que tienen un precio mayor a $5 pesos se les incorporará un impuesto por ser artículos de lujo y se les deberá sumar a la cantidad actual $2 pesos.
select * from OrderDetails where UnitPrice > 5;

-- OrderDetailID  OrderID     ProductID   UnitPrice   Quantity  
-- -------------  ----------  ----------  ----------  ----------
-- 5              2           5           9.97        140       
-- 6              3           6           14.69       160       
-- 11             5           5           9.97        130       
-- 12             5           6           14.69       150       
-- 17             7           5           9.97        120       
-- 18             8           6           14.69       130       
-- 31             14          5           9.97        80        
-- 32             15          6           14.69       90        
-- 37             17          5           9.97        70        
-- 38             17          6           14.69       80        
-- 43             19          5           9.97        60        
-- 44             19          6           14.69       70

update OrderDetails set UnitPrice = UnitPrice + 2 where UnitPrice > 5;
select * from OrderDetails where UnitPrice > 5;
-- OrderDetailID  OrderID     ProductID   UnitPrice   Quantity  
-- -------------  ----------  ----------  ----------  ----------
-- 5              2           5           11.97       140       
-- 6              3           6           16.69       160       
-- 11             5           5           11.97       130       
-- 12             5           6           16.69       150       
-- 17             7           5           11.97       120       
-- 18             8           6           16.69       130       
-- 31             14          5           11.97       80        
-- 32             15          6           16.69       90        
-- 37             17          5           11.97       70        
-- 38             17          6           16.69       80        
-- 43             19          5           11.97       60        
-- 44             19          6           16.69       70

#BORRAR AL CLIENTE SLOTS CARPETS

DELETE FROM OrderDetails
WHERE OrderID IN (
SELECT (OrderID) FROM Orders 
WHERE CustomerID = ( SELECT CustomerID FROM Customers WHERE CompanyName = 'Slots Carpet') ORDER BY OrderID DESC);

DELETE FROM Orders 
WHERE CustomerID = ( SELECT CustomerID FROM Customers WHERE CompanyName = 'Slots Carpet');

DELETE FROM Customers WHERE CompanyName = 'Slots Carpet'

select count(*) from OrderDetails;
select count(*) from Orders;