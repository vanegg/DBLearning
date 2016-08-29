sqlite3 EssentialSQL.db
.schema 
# 1. Total orders from client 3
# => 6
SELECT COUNT(*) 
FROM Orders 
WHERE (CustomerID = '3');

# 2. Total orders from client Jim Wood
# => 6
SELECT COUNT(*) 
FROM Orders 
WHERE (CustomerID = (SELECT CustomerID FROM Customers WHERE (ContactName = 'Jim Wood')));

# 3. Total orders from company Slots Carpet
# => 2
SELECT COUNT(*) 
FROM Orders 
WHERE (CustomerID = ( SELECT CustomerID FROM Customers WHERE (CompanyName = 'Slots Carpet')));

# 4. El total de ordenes de cada compañía ordenado de manera descendente
-- CompanyName  TotalOrders
-- -----------  ---------------------
-- Floor Co.    6
-- Sagebrush C  5
-- Main Tile a  4
-- Deerfield T  3
-- Slots Carpe  2

SELECT Customers.CompanyName, COUNT(Orders.CustomerID) AS TotalOrders FROM Orders
LEFT JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY CompanyName
ORDER BY TotalOrders DESC;

# 5. Total orders for each company ordered by the company with the least orders
-- CompanyName   ********
-- ------------  ---------------------
-- Slots Carpet  2
-- Deerfield Ti  3
-- Main Tile an  4
-- Sagebrush Ca  5
-- Floor Co.     6

SELECT Customers.CompanyName, COUNT(Orders.CustomerID) AS TotalOrders FROM Orders
LEFT JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY CompanyName
ORDER BY TotalOrders;

# 6. La compañía con el mayor número de ordenes
-- CompanyName  ********
-- -----------  ---------------------
-- Floor Co.    6

SELECT CompanyName, Max(TotalOrders) FROM (
SELECT Customers.CompanyName, COUNT(Orders.CustomerID) 
AS TotalOrders FROM Orders
LEFT JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
GROUP BY CompanyName
ORDER BY TotalOrders DESC);

# 7. Total items ordered by each company ordered by the company with the most items
-- CompanyName         ********
-- ------------------  --------------------------
-- Main Tile and Bath  940
-- Sagebrush Carpet    740
-- Floor Co.           670
-- Deerfield Tile      340
-- Slots Carpet        250

SELECT Customers.CompanyName, SUM(OrderDetails.Quantity) 
AS TotalProducts 
FROM OrderDetails
LEFT JOIN Orders, Customers
ON OrderDetails.OrderID = Orders.OrderID AND Customers.CustomerID = Orders.CustomerID 
GROUP BY CompanyName
ORDER BY TotalProducts DESC;

# 8. El monto total en pesos de la orden con ID 4
-- OrderID     ********
-- ----------  ---------------------------------------------------
-- 4           400.0

SELECT OrderID, UnitPrice * Quantity AS TotalPrice
FROM OrderDetails 
WHERE OrderID = '4';

# 9. El monto total en pesos de cada orden
-- OrderID     ********
-- ----------  ---------------------------------------------------
-- 1           48.0
-- 2           1948.7
-- 3           2395.9
-- 4           400.0
-- 5           3638.6
-- 6           384.5
-- 7           1321.5
-- 8           1941.7
-- 9           300.0
-- 10          133.2
-- 11          421.2
-- 12          32.0
-- 13          250.0
-- 14          881.0
-- 15          1344.1
-- 16          207.5
-- 17          1942.6
-- 18          285.5
-- 19          1626.5
-- 20          166.0

SELECT OrderID, SUM(UnitPrice * Quantity) AS TotalPrice
FROM OrderDetails
GROUP BY OrderID;

# 10. La consulta del inciso anterior pero únicamente mostrando aquellas ordenes que sean mayores a $1,000.00 pesos
-- OrderID     ********
-- ----------  ---------------------------------------------------
-- 2           1948.7
-- 3           2395.9
-- 5           3638.6
-- 7           1321.5
-- 8           1941.7
-- 15          1344.1
-- 17          1942.6
-- 19          1626.5

SELECT OrderID, SUM(UnitPrice * Quantity) AS TotalPrice
FROM OrderDetails
GROUP BY OrderID
HAVING SUM(UnitPrice * Quantity) > 1000

# 11. El total de piezas en cada orden
-- OrderID     ********
-- ----------  --------------------------
-- 1           90
-- 2           330
-- 3           240
-- 4           80
-- 5           380
-- 6           140
-- 7           210
-- 8           190
-- 9           60
-- 10          100
-- 11          180
-- 12          60
-- 13          50
-- 14          140
-- 15          110
-- 16          70
-- 17          200
-- 18          120
-- 19          130
-- 20          60

SELECT OrderID, SUM(Quantity) AS TotalPieces
FROM OrderDetails
GROUP BY OrderID;