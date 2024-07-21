Use MilkMela;

 -- pivot
SELECT 
    Godown_Location, 
    SUM(CASE WHEN Godown_Location = "New York" THEN Agent_ID ELSE 0 END) AS Ny,
    SUM(CASE WHEN Godown_Location = "London" THEN Agent_ID ELSE 0 END) AS Lnd,
    SUM(CASE WHEN Godown_Location = "Beijing" THEN Agent_ID ELSE 0 END) AS Bjn,
    SUM(CASE WHEN Godown_Location = "Sydney" THEN Agent_ID ELSE 0 END) AS Syd,
    SUM(CASE WHEN Godown_Location = "Paris" THEN Agent_ID ELSE 0 END) AS Prs,
    SUM(CASE WHEN Godown_Location = "Dubai" THEN Agent_ID ELSE 0 END) AS Dub,
    SUM(CASE WHEN Godown_Location = "New Delhi" THEN Agent_ID ELSE 0 END) AS Ndl,
    SUM(CASE WHEN Godown_Location = "Moscow" THEN Agent_ID ELSE 0 END) AS Msc,
    SUM(CASE WHEN Godown_Location = "Rio de Janeiro" THEN Agent_ID ELSE 0 END) AS Rdj,
    SUM(CASE WHEN Godown_Location = "Cape Town" THEN Agent_ID ELSE 0 END) AS Cpt
FROM Delivery
GROUP BY Godown_Location;

-- rollup
SELECT Category_Name, SUM(Product_Price*Product_Stock) AS Total_Value
FROM Category
JOIN Product ON Product.Product_ID IN (Category.Product1_ID, Category.Product2_ID, Category.Product3_ID, Category.Product4_ID, Category.Product5_ID, Category.Product6_ID, Category.Product7_ID, Category.Product8_ID, Category.Product9_ID, Category.Product10_ID, Category.Product11_ID, Category.Product12_ID)
JOIN Cart ON Cart.Product1_ID=Product.Product_ID OR Cart.Product2_ID=Product.Product_ID OR Cart.Product3_ID=Product.Product_ID OR Cart.Product4_ID=Product.Product_ID OR Cart.Product5_ID=Product.Product_ID OR Cart.Product6_ID=Product.Product_ID OR Cart.Product7_ID=Product.Product_ID OR Cart.Product8_ID=Product.Product_ID OR Cart.Product9_ID=Product.Product_ID OR Cart.Product10_ID=Product.Product_ID OR Cart.Product11_ID=Product.Product_ID OR Cart.Product12_ID=Product.Product_ID
JOIN Payment ON Payment.Cart_ID = Cart.Cart_ID
GROUP BY Category_Name WITH ROLLUP;

-- slicing
SELECT * FROM Product WHERE Product_Price < 10;

-- drilldown
SELECT c.Category_Name, v.Vendor_Name, SUM(p.Product_Price) as Sales
FROM Category c
JOIN Product p ON c.Product1_ID = p.Product_ID OR c.Product2_ID = p.Product_ID OR c.Product3_ID = p.Product_ID OR c.Product4_ID = p.Product_ID OR c.Product5_ID = p.Product_ID OR c.Product6_ID = p.Product_ID OR c.Product7_ID = p.Product_ID OR c.Product8_ID = p.Product_ID OR c.Product9_ID = p.Product_ID OR c.Product10_ID = p.Product_ID OR c.Product11_ID = p.Product_ID OR c.Product12_ID = p.Product_ID
JOIN Vendor v ON p.Vendor_ID = v.Vendor_ID
GROUP BY c.Category_Name, v.Vendor_Name WITH ROLLUP;
