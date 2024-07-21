Use MilkMela;

SELECT *
FROM Delivery
WHERE Godown_Location = "London"
AND Agent_ID > 40;

UPDATE Product
SET Product_Stock = 50
WHERE Vendor_ID = 3;
SELECT * FROM Product WHERE Vendor_ID = 3;

SELECT User_Name, User_Phone
FROM Customer
WHERE User_Email LIKE '%@email.com';

SELECT c.User_Name, c.User_Phone
FROM Customer c
JOIN Cart ca ON c.User_ID = ca.User_ID
JOIN Payment pa ON ca.Cart_ID = pa.Cart_ID
JOIN Purchases pu ON pa.Payment_ID = pu.Payment_ID;

SELECT Vendor_Name, Vendor_Email
FROM Vendor
WHERE NOT EXISTS (
  SELECT *
  FROM Product
  WHERE Product.Vendor_ID = Vendor.Vendor_ID
);

SELECT Product_Name
FROM Product
WHERE Product_ID IN (
  SELECT Product1_ID
  FROM Combo
  UNION
  SELECT Product2_ID
  FROM Combo
);

SELECT Vendor_Name, COUNT(Product_ID) AS Num_Products
FROM Vendor
JOIN Product ON Vendor.Vendor_ID = Product.Vendor_ID
GROUP BY Vendor.Vendor_Name
ORDER BY Num_Products DESC;

SELECT SUM(Product_Price * Product_Stock) AS Total_Value
FROM Product;

SELECT User_Name, IF(User_Address LIKE '%123 Main St%', 'Yes', 'No') AS Lives_on_Main
FROM Customer;

SELECT p.Order_ID, py.Payment_Status, py.Order_Price, py.Discount, c.User_Name
FROM Purchases p
INNER JOIN Payment py ON p.Payment_ID = py.Payment_ID
INNER JOIN Cart cart ON py.Cart_ID = cart.Cart_ID
INNER JOIN Customer c ON cart.User_ID = c.User_ID;

SELECT Distinct User_ID 
FROM Cart 
WHERE ( SELECT Distinct Product1_ID
FROM Category
WHERE Category.Product1_ID =  Cart.Product1_ID);