DROP DATABASE IF EXISTS MilkMela;
CREATE DATABASE MilkMela;
USE MilkMela;

Set Foreign_Key_Checks = 0;
Drop Table if Exists Vendor;
Drop Table if Exists Customer;
Drop Table if Exists Product;
Drop Table if Exists Combo;
Drop Table if Exists Category;
Drop Table if Exists Agent;
Drop Table if Exists Cart;
Drop Table if Exists Payment;
Drop Table if Exists Purchases;
Drop Table if Exists Delivery;
Set Foreign_Key_Checks = 1;



Create Table Vendor (Vendor_ID int(7) primary key, Vendor_Name varchar(50) Not Null unique, Vendor_Phone int(255) Not Null, Vendor_Email varchar(50) Not Null, Vendor_Location varchar(256) not null);
Create Table Customer (User_ID int(7) primary key, User_Name varchar(50) Not Null, User_Phone int(255) Not Null, User_Email varchar(50) Not Null, User_Address varchar(256) not null);
Create Table Product (Product_ID int (7) primary key, Vendor_ID int(7), Foreign Key (Vendor_ID) REFERENCES Vendor(Vendor_ID), Product_Name varchar(256) not null, Product_Price float(20) not null, Product_Desription varchar(256), Product_Stock int(3) not null);
Create Table Combo (Combo_ID int (7) primary key, Product1_ID int(7) not null, Foreign Key (Product1_ID) REFERENCES Product(Product_ID), Product2_ID int(7) not null, Foreign Key (Product2_ID) REFERENCES Product(Product_ID), Combo_Price float(20) not null, Combo_Stock int(3) not null);
Create Table Category (Category_ID int (7) primary key, Category_Name varchar (50) not null, Product1_ID int (7) not null, Product2_ID int (7), Product3_ID int (7), Product4_ID int (7), Product5_ID int (7), Product6_ID int (7), Product7_ID int (7), Product8_ID int (7), Product9_ID int (7), Product10_ID int (7), Product11_ID int (7), Product12_ID int (7), Foreign Key (Product1_ID) REFERENCES Product(Product_ID), Foreign Key (Product2_ID) REFERENCES Product(Product_ID), Foreign Key (Product3_ID) REFERENCES Product(Product_ID), Foreign Key (Product4_ID) REFERENCES Product(Product_ID), Foreign Key (Product5_ID) REFERENCES Product(Product_ID), Foreign Key (Product6_ID) REFERENCES Product(Product_ID), Foreign Key (Product7_ID) REFERENCES Product(Product_ID), Foreign Key (Product8_ID) REFERENCES Product(Product_ID), Foreign Key (Product9_ID) REFERENCES Product(Product_ID), Foreign Key (Product10_ID) REFERENCES Product(Product_ID), Foreign Key (Product11_ID) REFERENCES Product(Product_ID), Foreign Key (Product12_ID) REFERENCES Product(Product_ID));
Create Table Agent (Agent_ID int(7) primary key, Agent_Name varchar(50) Not Null, Agent_Phone int(10) Not Null, Agent_Email varchar(50) Not Null, Agent_Location varchar(256) not null);
Create Table Cart (Cart_ID int(7) primary key, User_ID int(7) Not Null, Foreign Key (User_ID) REFERENCES Customer(User_ID), Product1_ID int (7) not null, Product2_ID int (7), Product3_ID int (7), Product4_ID int (7), Product5_ID int (7), Foreign Key (Product1_ID) REFERENCES Product(Product_ID), Foreign Key (Product2_ID) REFERENCES Product(Product_ID), Foreign Key (Product3_ID) REFERENCES Product(Product_ID), Foreign Key (Product4_ID) REFERENCES Product(Product_ID), Foreign Key (Product5_ID) REFERENCES Product(Product_ID), Combo1_ID int(7), Combo2_ID int (7), Combo3_ID int(7), Foreign Key (Combo1_ID) REFERENCES Combo (Combo_ID), Foreign Key (Combo2_ID) REFERENCES Combo (Combo_ID), Foreign Key (Combo3_ID) REFERENCES Combo (Combo_ID));
Create Table Payment (Payment_ID int (7) primary key, Cart_ID int(7), Foreign Key (Cart_ID) references Cart(Cart_ID), Order_Price int(20), Discount int(3), Payment_Status int(1) not null);
Create Table Purchases (Order_ID int (7) primary key, Payment_ID int(7), Foreign Key (Payment_ID) references Payment(Payment_ID), Order_Status int(1) not null);
Create Table Delivery (Agent_ID int (7), Foreign Key (Agent_ID) references Agent(Agent_ID), Order_ID int (7), Foreign Key (Order_ID) references Purchases(Order_ID), Godown_Location varchar(256));







DELIMITER //
CREATE TRIGGER prevent_negative_price
BEFORE INSERT ON Product
FOR EACH ROW
BEGIN
  IF NEW.Product_Price < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price cannot be negative';
  END IF;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER enforce_quantity_limit
AFTER INSERT ON Product
FOR EACH ROW
BEGIN
  DECLARE Max_Quantity INT;
  SET Max_Quantity = 1000;
  IF NEW.Product_Stock > Max_Quantity THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity exceeds maximum product quantity';
  END IF;
END//
DELIMITER ;





insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (1, "John's Dairy", 10011, "john@dairy.com", "123 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (2, "Sara's Dairy", 20022, "sara@dairy.com", "456 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (3, "Mike's Dairy", 30033, "mike@dairy.com", "789 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (4, "Amy's Dairy", 40044, "amy@dairy.com", "246 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (5, "Tom's Dairy", 50055, "tom@dairy.com", "369 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (6, "Jane's Dairy", 60066, "jane@dairy.com", "159 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (7, "Bob's Dairy", 70077, "bob@dairy.com", "753 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (8, "Nate's Dairy", 80088, "nate@dairy.com", "951 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (9, "Kim's Dairy", 90099, "kim@dairy.com", "147 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (10, "Dan's Dairy", 10001, "dan@dairy.com", "258 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (11, "Liam's Dairy", 11111, "liam@dairy.com", "121 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (12, "Emma's Dairy", 11112, "emma@dairy.com", "122 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (13, "Olivia's Dairy", 11113, "olivia@dairy.com", "123 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (14, "Noah's Dairy", 11114, "noah@dairy.com", "124 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (15, "Ava's Dairy", 11115, "ava@dairy.com", "125 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (16, "Isabella's Dairy", 11116, "isabella@dairy.com", "126 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (17, "Elijah's Dairy", 11117, "elijah@dairy.com", "127 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (18, "Mia's Dairy", 11118, "mia@dairy.com", "128 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (19, "William's Dairy", 11119, "william@dairy.com", "129 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (20, "Sophia's Dairy", 11120, "sophia@dairy.com", "130 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (21, "Mason's Dairy", 11121, "mason@dairy.com", "131 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (22, "Charlotte's Dairy", 11122, "charlotte@dairy.com", "132 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (23, "James's Dairy", 11123, "james@dairy.com", "133 Main St., Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (24, "Sam's Dairy", 11123, "sam@dairy.com", "134 Main St., Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (25, "Oprah's Dairy", 11123, "oprah@dairy.com", "135 Main St., Anytown USA 12345");

insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (26, "John's Dairy1", 10011, "john@dairy.com", "123 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (27, "Sara's Dairy1", 20022, "sara@dairy.com", "456 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (28, "Mike's Dairy1", 30033, "mike@dairy.com", "789 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (29, "Amy's Dairy1", 40044, "amy@dairy.com", "246 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (30, "Tom's Dairy1", 50055, "tom@dairy.com", "369 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (31, "Jane's Dairy1", 60066, "jane@dairy.com", "159 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (32, "Bob's Dairy1", 70077, "bob@dairy.com", "753 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (33, "Nate's Dairy1", 80088, "nate@dairy.com", "951 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (34, "Kim's Dairy1", 90099, "kim@dairy.com", "147 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (35, "Dan's Dairy1", 10001, "dan@dairy.com", "258 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (36, "Liam's Dairy1", 11111, "liam@dairy.com", "121 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (37, "Emma's Dairy1", 11112, "emma@dairy.com", "122 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (38, "Olivia's Dairy1", 11113, "olivia@dairy.com", "123 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (39, "Noah's Dairy1", 11114, "noah@dairy.com", "124 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (40, "Ava's Dairy1", 11115, "ava@dairy.com", "125 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (41, "Isabella's Dairy1", 11116, "isabella@dairy.com", "126 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (42, "Elijah's Dairy1", 11117, "elijah@dairy.com", "127 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (43, "Mia's Dairy1", 11118, "mia@dairy.com", "128 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (44, "William's Dairy1", 11119, "william@dairy.com", "129 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (45, "Sophia's Dairy1", 11120, "sophia@dairy.com", "130 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (46, "Mason's Dairy1", 11121, "mason@dairy.com", "131 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (47, "Charlotte's Dairy1", 11122, "charlotte@dairy.com", "132 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (48, "James's Dairy1", 11123, "james@dairy.com", "133 Main St., Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (49, "Sam's Dairy1", 11123, "sam@dairy.com", "134 Main St., Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (50, "Oprah's Dairy1", 11123, "oprah@dairy.com", "135 Main St., Anytown USA 12345");

insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (51, "John's Dairy2", 10011, "john@dairy.com", "123 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (52, "Sara's Dairy2", 20022, "sara@dairy.com", "456 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (53, "Mike's Dairy2", 30033, "mike@dairy.com", "789 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (54, "Amy's Dairy2", 40044, "amy@dairy.com", "246 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (55, "Tom's Dairy2", 50055, "tom@dairy.com", "369 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (56, "Jane's Dairy2", 60066, "jane@dairy.com", "159 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (57, "Bob's Dairy2", 70077, "bob@dairy.com", "753 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (58, "Nate's Dairy2", 80088, "nate@dairy.com", "951 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (59, "Kim's Dairy2", 90099, "kim@dairy.com", "147 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (60, "Dan's Dairy2", 10001, "dan@dairy.com", "258 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (61, "Liam's Dairy2", 11111, "liam@dairy.com", "121 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (62, "Emma's Dairy2", 11112, "emma@dairy.com", "122 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (63, "Olivia's Dairy2", 11113, "olivia@dairy.com", "123 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (64, "Noah's Dairy2", 11114, "noah@dairy.com", "124 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (65, "Ava's Dairy2", 11115, "ava@dairy.com", "125 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (66, "Isabella's Dairy2", 11116, "isabella@dairy.com", "126 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (67, "Elijah's Dairy2", 11117, "elijah@dairy.com", "127 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (68, "Mia's Dairy2", 11118, "mia@dairy.com", "128 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (69, "William's Dairy2", 11119, "william@dairy.com", "129 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (70, "Sophia's Dairy2", 11120, "sophia@dairy.com", "130 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (71, "Mason's Dairy2", 11121, "mason@dairy.com", "131 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (72, "Charlotte's Dairy2", 11122, "charlotte@dairy.com", "132 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (73, "James's Dairy2", 11123, "james@dairy.com", "133 Main St., Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (74, "Sam's Dairy2", 11123, "sam@dairy.com", "134 Main St., Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (75, "Oprah's Dairy2", 11123, "oprah@dairy.com", "135 Main St., Anytown USA 12345");

insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (76, "John's Dair", 10011, "john@dairy.com", "123 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (77, "Sara's Daiy", 20022, "sara@dairy.com", "456 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (78, "Mike's Dary", 30033, "mike@dairy.com", "789 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (79, "Amy's Daiy", 40044, "amy@dairy.com", "246 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (80, "Tom's Daiy", 50055, "tom@dairy.com", "369 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (81, "Jane's Dary", 60066, "jane@dairy.com", "159 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (82, "Bob's Daiy", 70077, "bob@dairy.com", "753 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (83, "Nate's Daiy", 80088, "nate@dairy.com", "951 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (84, "Kim's Dair", 90099, "kim@dairy.com", "147 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (85, "Dan's Daiy", 10001, "dan@dairy.com", "258 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (86, "Liam's Dary", 11111, "liam@dairy.com", "121 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (87, "Emma's Diry", 11112, "emma@dairy.com", "122 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (88, "Olivia' Dairy", 11113, "olivia@dairy.com", "123 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (89, "Noah's airy", 11114, "noah@dairy.com", "124 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (90, "Ava's airy", 11115, "ava@dairy.com", "125 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (91, "Isabela's Dairy", 11116, "isabella@dairy.com", "126 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (92, "Elijh's Dairy", 11117, "elijah@dairy.com", "127 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (93, "Mias Dairy", 11118, "mia@dairy.com", "128 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (94, "Wiliam's Dairy", 11119, "william@dairy.com", "129 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (95, "Sphia's Dairy", 11120, "sophia@dairy.com", "130 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (96, "Masons Dairy", 11121, "mason@dairy.com", "131 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (97, "Charotte's Dairy", 11122, "charlotte@dairy.com", "132 Main St, Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (98, "Jams's Dairy", 11123, "james@dairy.com", "133 Main St., Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (99, "Sa's Dairy", 11123, "sam@dairy.com", "134 Main St., Anytown USA 12345");
insert into Vendor (Vendor_ID, Vendor_Name, Vendor_Phone, Vendor_Email, Vendor_Location) values (100, "Orah's Dairy", 11123, "oprah@dairy.com", "135 Main St., Anytown USA 12345");











insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (1, "James Doe", 11111, "james.doe@email.com", "123 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (2, "John Doe", 11112, "john.doe@email.com", "124 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (3, "Jane Smith", 11113, "jane.smith@email.com", "125 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (4, "John Smith", 11114, "john.smith@email.com", "126 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (5, "Rob Johnson", 11115, "rob.johnson@email.com", "127 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (6, "Sally Johnson", 11116, "sally.johnson@email.com", "128 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (7, "Tom Wilson", 11117, "tom.wilson@email.com", "129 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (8, "Emily Wilson", 11118, "emily.wilson@email.com", "130 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (9, "Michael Davis", 11119, "michael.davis@email.com", "131 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (10, "Emily Davis", 11120, "emily.davis@email.com", "132 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (11, "William Anderson", 11121, "william.anderson@email.com", "133 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (12, "Sophia Anderson", 11122, "sophia.anderson@email.com", "134 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (13, "Amy Smith", 11111, "amy@example.com", "456 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (14, "Bob Johnson", 11112, "bob@example.com", "457 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (15, "Charlie Brown", 11113, "charlie@example.com", "458 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (16, "Diana Wilson", 11114, "diana@example.com", "459 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (17, "Ethan Davis", 11115, "ethan@example.com", "460 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (18, "Felicity Jones", 11116, "felicity@example.com", "461 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (19, "George Thompson", 11117, "george@example.com", "462 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (20, "Hanna Baker", 11118, "hanna@example.com", "463 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (21, "Isaac Taylor", 11119, "isaac@example.com", "464 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (22, "Jane Doe", 11120, "jane@example.com", "465 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (23, "Keith Anderson", 11121, "keith@example.com", "466 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (24, "Laura Robinson", 11122, "laura@example.com", "467 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (25, "Michael Clark", 11123, "michael@example.com", "468 Main St, Anytown USA 12345");

insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (26, "James Doe", 11111, "james.doe@email.com", "123 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (27, "John Doe", 11112, "john.doe@email.com", "124 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (28, "Jane Smith", 11113, "jane.smith@email.com", "125 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (29, "John Smith", 11114, "john.smith@email.com", "126 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (30, "Rob Johnson", 11115, "rob.johnson@email.com", "127 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (31, "Sally Johnson", 11116, "sally.johnson@email.com", "128 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (32, "Tom Wilson", 11117, "tom.wilson@email.com", "129 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (33, "Emily Wilson", 11118, "emily.wilson@email.com", "130 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (34, "Michael Davis", 11119, "michael.davis@email.com", "131 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (35, "Emily Davis", 11120, "emily.davis@email.com", "132 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (36, "William Anderson", 11121, "william.anderson@email.com", "133 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (37, "Sophia Anderson", 11122, "sophia.anderson@email.com", "134 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (38, "Amy Smith", 11111, "amy@example.com", "456 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (39, "Bob Johnson", 11112, "bob@example.com", "457 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (40, "Charlie Brown", 11113, "charlie@example.com", "458 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (41, "Diana Wilson", 11114, "diana@example.com", "459 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (42, "Ethan Davis", 11115, "ethan@example.com", "460 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (43, "Felicity Jones", 11116, "felicity@example.com", "461 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (44, "George Thompson", 11117, "george@example.com", "462 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (45, "Hanna Baker", 11118, "hanna@example.com", "463 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (46, "Isaac Taylor", 11119, "isaac@example.com", "464 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (47, "Jane Doe", 11120, "jane@example.com", "465 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (48, "Keith Anderson", 11121, "keith@example.com", "466 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (49, "Laura Robinson", 11122, "laura@example.com", "467 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (50, "Michael Clark", 11123, "michael@example.com", "468 Main St, Anytown USA 12345");

insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (51, "James Doe", 11111, "james.doe@email.com", "123 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (52, "John Doe", 11112, "john.doe@email.com", "124 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (53, "Jane Smith", 11113, "jane.smith@email.com", "125 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (54, "John Smith", 11114, "john.smith@email.com", "126 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (55, "Rob Johnson", 11115, "rob.johnson@email.com", "127 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (56, "Sally Johnson", 11116, "sally.johnson@email.com", "128 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (57, "Tom Wilson", 11117, "tom.wilson@email.com", "129 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (58, "Emily Wilson", 11118, "emily.wilson@email.com", "130 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (59, "Michael Davis", 11119, "michael.davis@email.com", "131 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (60, "Emily Davis", 11120, "emily.davis@email.com", "132 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (61, "William Anderson", 11121, "william.anderson@email.com", "133 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (62, "Sophia Anderson", 11122, "sophia.anderson@email.com", "134 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (63, "Amy Smith", 11111, "amy@example.com", "456 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (64, "Bob Johnson", 11112, "bob@example.com", "457 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (65, "Charlie Brown", 11113, "charlie@example.com", "458 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (66, "Diana Wilson", 11114, "diana@example.com", "459 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (67, "Ethan Davis", 11115, "ethan@example.com", "460 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (68, "Felicity Jones", 11116, "felicity@example.com", "461 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (69, "George Thompson", 11117, "george@example.com", "462 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (70, "Hanna Baker", 11118, "hanna@example.com", "463 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (71, "Isaac Taylor", 11119, "isaac@example.com", "464 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (72, "Jane Doe", 11120, "jane@example.com", "465 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (73, "Keith Anderson", 11121, "keith@example.com", "466 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (74, "Laura Robinson", 11122, "laura@example.com", "467 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (75, "Michael Clark", 11123, "michael@example.com", "468 Main St, Anytown USA 12345");

insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (76, "James Doe", 11111, "james.doe@email.com", "123 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (77, "John Doe", 11112, "john.doe@email.com", "124 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (78, "Jane Smith", 11113, "jane.smith@email.com", "125 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (79, "John Smith", 11114, "john.smith@email.com", "126 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (80, "Rob Johnson", 11115, "rob.johnson@email.com", "127 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (81, "Sally Johnson", 11116, "sally.johnson@email.com", "128 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (82, "Tom Wilson", 11117, "tom.wilson@email.com", "129 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (83, "Emily Wilson", 11118, "emily.wilson@email.com", "130 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (84, "Michael Davis", 11119, "michael.davis@email.com", "131 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (85, "Emily Davis", 11120, "emily.davis@email.com", "132 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (86, "William Anderson", 11121, "william.anderson@email.com", "133 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (87, "Sophia Anderson", 11122, "sophia.anderson@email.com", "134 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (88, "Amy Smith", 11111, "amy@example.com", "456 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (89, "Bob Johnson", 11112, "bob@example.com", "457 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (90, "Charlie Brown", 11113, "charlie@example.com", "458 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (91, "Diana Wilson", 11114, "diana@example.com", "459 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (92, "Ethan Davis", 11115, "ethan@example.com", "460 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (93, "Felicity Jones", 11116, "felicity@example.com", "461 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (94, "George Thompson", 11117, "george@example.com", "462 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (95, "Hanna Baker", 11118, "hanna@example.com", "463 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (96, "Isaac Taylor", 11119, "isaac@example.com", "464 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (97, "Jane Doe", 11120, "jane@example.com", "465 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (98, "Keith Anderson", 11121, "keith@example.com", "466 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (99, "Laura Robinson", 11122, "laura@example.com", "467 Main St, Anytown USA 12345");
insert into Customer (User_ID, User_Name, User_Phone, User_Email, User_Address) values (100, "Michael Clark", 11123, "michael@example.com", "468 Main St, Anytown USA 12345");








insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (201, 1, "Whole Milk", 3.99, "A gallon of fresh whole milk.", 100);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (202, 2, "2% Milk", 4.99, "A gallon of fresh 2% milk.", 200);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (203, 3, "Skim Milk", 5.99, "A gallon of fresh skim milk.", 150);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (204, 4, "Chocolate Milk", 4.99, "A gallon of delicious chocolate milk.", 75);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (205, 5, "Butter", 4.99, "A pound of fresh unsalted butter.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (206, 6, "Cheese", 6.99, "A pound of sharp cheddar cheese.", 30);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (207, 7, "Ice Cream", 7.99, "A half gallon of vanilla ice cream.", 25);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (208, 8, "Yogurt", 3.99, "A carton of plain Greek yogurt.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (209, 9, "Cream Cheese", 3.99, "A 8oz block of cream cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (210, 10, "Sour Cream", 2.99, "A cup of sour cream.", 60);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (211, 1, "Heavy Cream", 5.99, "A pint of heavy cream.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (212, 2, "Half and Half", 3.99, "A pint of half and half.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (213, 3, "Cottage Cheese", 3.99, "A carton of low fat cottage cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (214, 4, "Ricotta Cheese", 4.99, "A carton of fresh ricotta cheese.", 30);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (215, 5, "Goat Cheese", 7.99, "A 4oz log of goat cheese.", 25);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (216, 6, "Feta Cheese", 6.99, "A 4oz block of feta cheese.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (217, 7, "Mozzarella Cheese", 5.99, "A 8oz block of mozzarella cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (218, 8, "Blue Cheese", 7.99, "A 4oz block of blue cheese.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (219, 9, "Brie Cheese", 6.99, "A 4oz wheel of brie cheese.", 20);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (310, 10, "Swiss Cheese", 5.99, "A 8oz block of Swiss cheese.", 15);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (311, 1, "Heavy Cream", 5.99, "A pint of heavy cream.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (312, 2, "Half and Half", 3.99, "A pint of half and half.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (313, 3, "Cottage Cheese", 3.99, "A carton of low fat cottage cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (314, 4, "Ricotta Cheese", 4.99, "A carton of fresh ricotta cheese.", 30);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (315, 5, "Goat Cheese", 7.99, "A 4oz log of goat cheese.", 25);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (316, 6, "Feta Cheese", 6.99, "A 4oz block of feta cheese.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (317, 7, "Mozzarella Cheese", 5.99, "A 8oz block of mozzarella cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (318, 8, "Blue Cheese", 7.99, "A 4oz block of blue cheese.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (3+19, 9, "Brie Cheese", 6.99, "A 4oz wheel of brie cheese.", 20);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (220, 10, "Swiss Cheese", 5.99, "A 8oz block of Swiss cheese.", 15);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (221, 1, "Heavy Cream", 5.99, "A pint of heavy cream.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (222, 2, "Half and Half", 3.99, "A pint of half and half.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (223, 3, "Cottage Cheese", 3.99, "A carton of low fat cottage cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (224, 4, "Ricotta Cheese", 4.99, "A carton of fresh ricotta cheese.", 30);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (225, 5, "Goat Cheese", 7.99, "A 4oz log of goat cheese.", 25);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (226, 6, "Feta Cheese", 6.99, "A 4oz block of feta cheese.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (227, 7, "Mozzarella Cheese", 5.99, "A 8oz block of mozzarella cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (228, 8, "Blue Cheese", 7.99, "A 4oz block of blue cheese.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (229, 9, "Brie Cheese", 6.99, "A 4oz wheel of brie cheese.", 20);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (230, 10, "Swiss Cheese", 5.99, "A 8oz block of Swiss cheese.", 15);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (231, 1, "Heavy Cream", 5.99, "A pint of heavy cream.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (232, 2, "Half and Half", 3.99, "A pint of half and half.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (233, 3, "Cottage Cheese", 3.99, "A carton of low fat cottage cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (234, 4, "Ricotta Cheese", 4.99, "A carton of fresh ricotta cheese.", 30);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (235, 5, "Goat Cheese", 7.99, "A 4oz log of goat cheese.", 25);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (236, 6, "Feta Cheese", 6.99, "A 4oz block of feta cheese.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (237, 7, "Mozzarella Cheese", 5.99, "A 8oz block of mozzarella cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (238, 8, "Blue Cheese", 7.99, "A 4oz block of blue cheese.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (239, 9, "Brie Cheese", 6.99, "A 4oz wheel of brie cheese.", 20);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (240, 10, "Swiss Cheese", 5.99, "A 8oz block of Swiss cheese.", 15);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (241, 1, "Heavy Cream", 5.99, "A pint of heavy cream.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (242, 2, "Half and Half", 3.99, "A pint of half and half.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (243, 3, "Cottage Cheese", 3.99, "A carton of low fat cottage cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (244, 4, "Ricotta Cheese", 4.99, "A carton of fresh ricotta cheese.", 30);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (245, 5, "Goat Cheese", 7.99, "A 4oz log of goat cheese.", 25);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (246, 6, "Feta Cheese", 6.99, "A 4oz block of feta cheese.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (247, 7, "Mozzarella Cheese", 5.99, "A 8oz block of mozzarella cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (248, 8, "Blue Cheese", 7.99, "A 4oz block of blue cheese.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (249, 9, "Brie Cheese", 6.99, "A 4oz wheel of brie cheese.", 20);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (250, 10, "Swiss Cheese", 5.99, "A 8oz block of Swiss cheese.", 15);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (251, 1, "Heavy Cream", 5.99, "A pint of heavy cream.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (252, 2, "Half and Half", 3.99, "A pint of half and half.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (253, 3, "Cottage Cheese", 3.99, "A carton of low fat cottage cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (254, 4, "Ricotta Cheese", 4.99, "A carton of fresh ricotta cheese.", 30);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (255, 5, "Goat Cheese", 7.99, "A 4oz log of goat cheese.", 25);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (256, 6, "Feta Cheese", 6.99, "A 4oz block of feta cheese.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (257, 7, "Mozzarella Cheese", 5.99, "A 8oz block of mozzarella cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (258, 8, "Blue Cheese", 7.99, "A 4oz block of blue cheese.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (259, 9, "Brie Cheese", 6.99, "A 4oz wheel of brie cheese.", 20);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (260, 10, "Swiss Cheese", 5.99, "A 8oz block of Swiss cheese.", 15);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (261, 1, "Heavy Cream", 5.99, "A pint of heavy cream.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (262, 2, "Half and Half", 3.99, "A pint of half and half.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (263, 3, "Cottage Cheese", 3.99, "A carton of low fat cottage cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (264, 4, "Ricotta Cheese", 4.99, "A carton of fresh ricotta cheese.", 30);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (265, 5, "Goat Cheese", 7.99, "A 4oz log of goat cheese.", 25);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (266, 6, "Feta Cheese", 6.99, "A 4oz block of feta cheese.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (267, 7, "Mozzarella Cheese", 5.99, "A 8oz block of mozzarella cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (268, 8, "Blue Cheese", 7.99, "A 4oz block of blue cheese.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (269, 9, "Brie Cheese", 6.99, "A 4oz wheel of brie cheese.", 20);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (270, 10, "Swiss Cheese", 5.99, "A 8oz block of Swiss cheese.", 15);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (271, 1, "Heavy Cream", 5.99, "A pint of heavy cream.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (272, 2, "Half and Half", 3.99, "A pint of half and half.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (273, 3, "Cottage Cheese", 3.99, "A carton of low fat cottage cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (274, 4, "Ricotta Cheese", 4.99, "A carton of fresh ricotta cheese.", 30);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (275, 5, "Goat Cheese", 7.99, "A 4oz log of goat cheese.", 25);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (276, 6, "Feta Cheese", 6.99, "A 4oz block of feta cheese.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (277, 7, "Mozzarella Cheese", 5.99, "A 8oz block of mozzarella cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (278, 8, "Blue Cheese", 7.99, "A 4oz block of blue cheese.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (279, 9, "Brie Cheese", 6.99, "A 4oz wheel of brie cheese.", 20);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (280, 10, "Swiss Cheese", 5.99, "A 8oz block of Swiss cheese.", 15);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (281, 1, "Heavy Cream", 5.99, "A pint of heavy cream.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (282, 2, "Half and Half", 3.99, "A pint of half and half.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (283, 3, "Cottage Cheese", 3.99, "A carton of low fat cottage cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (284, 4, "Ricotta Cheese", 4.99, "A carton of fresh ricotta cheese.", 30);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (285, 5, "Goat Cheese", 7.99, "A 4oz log of goat cheese.", 25);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (286, 6, "Feta Cheese", 6.99, "A 4oz block of feta cheese.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (287, 7, "Mozzarella Cheese", 5.99, "A 8oz block of mozzarella cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (288, 8, "Blue Cheese", 7.99, "A 4oz block of blue cheese.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (289, 9, "Brie Cheese", 6.99, "A 4oz wheel of brie cheese.", 20);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (290, 10, "Swiss Cheese", 5.99, "A 8oz block of Swiss cheese.", 15);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (291, 1, "Heavy Cream", 5.99, "A pint of heavy cream.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (292, 2, "Half and Half", 3.99, "A pint of half and half.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (293, 3, "Cottage Cheese", 3.99, "A carton of low fat cottage cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (294, 4, "Ricotta Cheese", 4.99, "A carton of fresh ricotta cheese.", 30);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (295, 5, "Goat Cheese", 7.99, "A 4oz log of goat cheese.", 25);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (296, 6, "Feta Cheese", 6.99, "A 4oz block of feta cheese.", 40);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (297, 7, "Mozzarella Cheese", 5.99, "A 8oz block of mozzarella cheese.", 50);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (298, 8, "Blue Cheese", 7.99, "A 4oz block of blue cheese.", 35);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (299, 9, "Brie Cheese", 6.99, "A 4oz wheel of brie cheese.", 20);
insert into Product (Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) values (300, 10, "Swiss Cheese", 5.99, "A 8oz block of Swiss cheese.", 15);





















insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1000, 201, 202, 11.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1001, 203, 204, 12.99, 20);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1002, 205, 206, 14.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1003, 207, 208, 12.49, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1004, 209, 210, 14.49, 35);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1005, 211, 212, 11.99, 15);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1006, 213, 214, 13.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1007, 215, 216, 16.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1008, 217, 218, 17.99, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1009, 219, 220, 16.49, 50);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1010, 201, 202, 11.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1011, 203, 204, 12.99, 20);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1012, 205, 206, 14.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1013, 207, 208, 12.49, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1014, 209, 210, 14.49, 35);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1015, 211, 212, 11.99, 15);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1016, 213, 214, 13.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1017, 215, 216, 16.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1018, 217, 218, 17.99, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1019, 219, 220, 16.49, 50);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1020, 201, 202, 11.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1021, 203, 204, 12.99, 20);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1022, 205, 206, 14.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1023, 207, 208, 12.49, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1024, 209, 210, 14.49, 35);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1025, 211, 212, 11.99, 15);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1026, 213, 214, 13.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1027, 215, 216, 16.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1028, 217, 218, 17.99, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1029, 219, 220, 16.49, 50);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1030, 201, 202, 11.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1031, 203, 204, 12.99, 20);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1032, 205, 206, 14.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1033, 207, 208, 12.49, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1034, 209, 210, 14.49, 35);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1035, 211, 212, 11.99, 15);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1036, 213, 214, 13.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1037, 215, 216, 16.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1038, 217, 218, 17.99, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1039, 219, 220, 16.49, 50);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1040, 201, 202, 11.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1041, 203, 204, 12.99, 20);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1042, 205, 206, 14.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1043, 207, 208, 12.49, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1044, 209, 210, 14.49, 35);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1045, 211, 212, 11.99, 15);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1046, 213, 214, 13.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1047, 215, 216, 16.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1048, 217, 218, 17.99, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1049, 219, 220, 16.49, 50);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1050, 201, 202, 11.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1051, 203, 204, 12.99, 20);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1052, 205, 206, 14.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1053, 207, 208, 12.49, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1054, 209, 210, 14.49, 35);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1055, 211, 212, 11.99, 15);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1056, 213, 214, 13.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1057, 215, 216, 16.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1058, 217, 218, 17.99, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1059, 219, 220, 16.49, 50);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1060, 201, 202, 11.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1061, 203, 204, 12.99, 20);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1062, 205, 206, 14.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1063, 207, 208, 12.49, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1064, 209, 210, 14.49, 35);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1065, 211, 212, 11.99, 15);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1066, 213, 214, 13.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1067, 215, 216, 16.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1068, 217, 218, 17.99, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1069, 219, 220, 16.49, 50);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1070, 201, 202, 11.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1071, 203, 204, 12.99, 20);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1072, 205, 206, 14.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1073, 207, 208, 12.49, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1074, 209, 210, 14.49, 35);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1075, 211, 212, 11.99, 15);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1076, 213, 214, 13.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1077, 215, 216, 16.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1078, 217, 218, 17.99, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1079, 219, 220, 16.49, 50);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1080, 201, 202, 11.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1081, 203, 204, 12.99, 20);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1082, 205, 206, 14.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1083, 207, 208, 12.49, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1084, 209, 210, 14.49, 35);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1085, 211, 212, 11.99, 15);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1086, 213, 214, 13.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1087, 215, 216, 16.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1088, 217, 218, 17.99, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1089, 219, 220, 16.49, 50);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1090, 201, 202, 11.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1091, 203, 204, 12.99, 20);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1092, 205, 206, 14.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1093, 207, 208, 12.49, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1094, 209, 210, 14.49, 35);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1095, 211, 212, 11.99, 15);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1096, 213, 214, 13.99, 25);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1097, 215, 216, 16.99, 30);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1098, 217, 218, 17.99, 40);
insert into Combo (Combo_ID, Product1_ID, Product2_ID, Combo_Price, Combo_Stock) values (1099, 219, 220, 16.49, 50);





















insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (1, "Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (2, "Cheese", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (3, "Butter", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (4, "Yogurt", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (5, "Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (6, "Ice Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (7, "Combo", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (8, "Skim Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (9, "Fat Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (10, "Almond Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (11, "Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (12, "Cheese", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (13, "Butter", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (14, "Yogurt", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (15, "Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (16, "Ice Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (17, "Combo", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (18, "Skim Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (19, "Fat Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (20, "Almond Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (21, "Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (22, "Cheese", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (23, "Butter", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (24, "Yogurt", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (25, "Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (26, "Ice Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (27, "Combo", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (28, "Skim Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (29, "Fat Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (30, "Almond Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (31, "Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (32, "Cheese", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (33, "Butter", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (34, "Yogurt", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (35, "Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (36, "Ice Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (37, "Combo", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (38, "Skim Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (39, "Fat Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (40, "Almond Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (41, "Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (42, "Cheese", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (43, "Butter", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (44, "Yogurt", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (45, "Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (46, "Ice Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (47, "Combo", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (48, "Skim Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (49, "Fat Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (50, "Almond Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (51, "Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (52, "Cheese", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (53, "Butter", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (54, "Yogurt", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (55, "Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (56, "Ice Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (57, "Combo", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (58, "Skim Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (59, "Fat Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (60, "Almond Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (61, "Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (62, "Cheese", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (63, "Butter", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (64, "Yogurt", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (65, "Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (66, "Ice Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (67, "Combo", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (68, "Skim Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (69, "Fat Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (70, "Almond Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (71, "Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (72, "Cheese", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (73, "Butter", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (74, "Yogurt", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (75, "Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (76, "Ice Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (77, "Combo", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (78, "Skim Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (79, "Fat Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (80, "Almond Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (81, "Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (82, "Cheese", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (83, "Butter", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (84, "Yogurt", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (85, "Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (86, "Ice Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (87, "Combo", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (88, "Skim Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (89, "Fat Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (90, "Almond Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (91, "Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (92, "Cheese", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (93, "Butter", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (94, "Yogurt", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (95, "Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (96, "Ice Cream", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (97, "Combo", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (98, "Skim Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (99, "Fat Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);
insert into Category (Category_ID, Category_Name, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Product6_ID, Product7_ID, Product8_ID, Product9_ID, Product10_ID, Product11_ID, Product12_ID) values (100, "Almond Milk", 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222);























insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (1, "Jenny Smith", 11111, "jenny.smith@email.com", "100 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (2, "Ryan Davis", 22222, "ryan.davis@email.com", "200 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (3, "Sophia Wilson", 33333, "sophia.wilson@email.com", "300 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (4, "Jacob Turner", 44444, "jacob.turner@email.com", "400 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (5, "Emily Brown", 55555, "emily.brown@email.com", "500 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (6, "Michael Johnson", 66666, "michael.johnson@email.com", "600 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (7, "Madison Davis", 77777, "madison.davis@email.com", "700 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (8, "Olivia Wilson", 88888, "olivia.wilson@email.com", "800 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (9, "William Turner", 99999, "william.turner@email.com", "900 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (10, "Ava Brown", 10101, "ava.brown@email.com", "1000 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (11, "Jenny Smith", 11111, "jenny.smith@email.com", "100 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (12, "Ryan Davis", 22222, "ryan.davis@email.com", "200 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (13, "Sophia Wilson", 33333, "sophia.wilson@email.com", "300 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (14, "Jacob Turner", 44444, "jacob.turner@email.com", "400 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (15, "Emily Brown", 55555, "emily.brown@email.com", "500 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (16, "Michael Johnson", 66666, "michael.johnson@email.com", "600 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (17, "Madison Davis", 77777, "madison.davis@email.com", "700 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (18, "Olivia Wilson", 88888, "olivia.wilson@email.com", "800 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (19, "William Turner", 99999, "william.turner@email.com", "900 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (20, "Ava Brown", 10101, "ava.brown@email.com", "1000 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (21, "Jenny Smith", 11111, "jenny.smith@email.com", "100 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (22, "Ryan Davis", 22222, "ryan.davis@email.com", "200 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (23, "Sophia Wilson", 33333, "sophia.wilson@email.com", "300 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (24, "Jacob Turner", 44444, "jacob.turner@email.com", "400 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (25, "Emily Brown", 55555, "emily.brown@email.com", "500 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (26, "Michael Johnson", 66666, "michael.johnson@email.com", "600 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (27, "Madison Davis", 77777, "madison.davis@email.com", "700 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (28, "Olivia Wilson", 88888, "olivia.wilson@email.com", "800 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (29, "William Turner", 99999, "william.turner@email.com", "900 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (30, "Ava Brown", 10101, "ava.brown@email.com", "1000 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (31, "Jenny Smith", 11111, "jenny.smith@email.com", "100 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (32, "Ryan Davis", 22222, "ryan.davis@email.com", "200 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (33, "Sophia Wilson", 33333, "sophia.wilson@email.com", "300 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (34, "Jacob Turner", 44444, "jacob.turner@email.com", "400 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (35, "Emily Brown", 55555, "emily.brown@email.com", "500 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (36, "Michael Johnson", 66666, "michael.johnson@email.com", "600 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (37, "Madison Davis", 77777, "madison.davis@email.com", "700 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (38, "Olivia Wilson", 88888, "olivia.wilson@email.com", "800 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (39, "William Turner", 99999, "william.turner@email.com", "900 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (40, "Ava Brown", 10101, "ava.brown@email.com", "1000 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (41, "Jenny Smith", 11111, "jenny.smith@email.com", "100 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (42, "Ryan Davis", 22222, "ryan.davis@email.com", "200 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (43, "Sophia Wilson", 33333, "sophia.wilson@email.com", "300 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (44, "Jacob Turner", 44444, "jacob.turner@email.com", "400 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (45, "Emily Brown", 55555, "emily.brown@email.com", "500 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (46, "Michael Johnson", 66666, "michael.johnson@email.com", "600 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (47, "Madison Davis", 77777, "madison.davis@email.com", "700 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (48, "Olivia Wilson", 88888, "olivia.wilson@email.com", "800 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (49, "William Turner", 99999, "william.turner@email.com", "900 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (50, "Ava Brown", 10101, "ava.brown@email.com", "1000 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (51, "Jenny Smith", 11111, "jenny.smith@email.com", "100 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (52, "Ryan Davis", 22222, "ryan.davis@email.com", "200 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (53, "Sophia Wilson", 33333, "sophia.wilson@email.com", "300 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (54, "Jacob Turner", 44444, "jacob.turner@email.com", "400 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (55, "Emily Brown", 55555, "emily.brown@email.com", "500 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (56, "Michael Johnson", 66666, "michael.johnson@email.com", "600 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (57, "Madison Davis", 77777, "madison.davis@email.com", "700 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (58, "Olivia Wilson", 88888, "olivia.wilson@email.com", "800 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (59, "William Turner", 99999, "william.turner@email.com", "900 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (60, "Ava Brown", 10101, "ava.brown@email.com", "1000 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (61, "Jenny Smith", 11111, "jenny.smith@email.com", "100 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (62, "Ryan Davis", 22222, "ryan.davis@email.com", "200 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (63, "Sophia Wilson", 33333, "sophia.wilson@email.com", "300 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (64, "Jacob Turner", 44444, "jacob.turner@email.com", "400 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (65, "Emily Brown", 55555, "emily.brown@email.com", "500 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (66, "Michael Johnson", 66666, "michael.johnson@email.com", "600 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (67, "Madison Davis", 77777, "madison.davis@email.com", "700 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (68, "Olivia Wilson", 88888, "olivia.wilson@email.com", "800 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (69, "William Turner", 99999, "william.turner@email.com", "900 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (70, "Ava Brown", 10101, "ava.brown@email.com", "1000 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (71, "Jenny Smith", 11111, "jenny.smith@email.com", "100 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (72, "Ryan Davis", 22222, "ryan.davis@email.com", "200 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (73, "Sophia Wilson", 33333, "sophia.wilson@email.com", "300 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (74, "Jacob Turner", 44444, "jacob.turner@email.com", "400 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (75, "Emily Brown", 55555, "emily.brown@email.com", "500 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (76, "Michael Johnson", 66666, "michael.johnson@email.com", "600 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (77, "Madison Davis", 77777, "madison.davis@email.com", "700 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (78, "Olivia Wilson", 88888, "olivia.wilson@email.com", "800 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (79, "William Turner", 99999, "william.turner@email.com", "900 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (80, "Ava Brown", 10101, "ava.brown@email.com", "1000 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (81, "Jenny Smith", 11111, "jenny.smith@email.com", "100 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (82, "Ryan Davis", 22222, "ryan.davis@email.com", "200 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (83, "Sophia Wilson", 33333, "sophia.wilson@email.com", "300 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (84, "Jacob Turner", 44444, "jacob.turner@email.com", "400 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (85, "Emily Brown", 55555, "emily.brown@email.com", "500 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (86, "Michael Johnson", 66666, "michael.johnson@email.com", "600 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (87, "Madison Davis", 77777, "madison.davis@email.com", "700 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (88, "Olivia Wilson", 88888, "olivia.wilson@email.com", "800 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (89, "William Turner", 99999, "william.turner@email.com", "900 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (90, "Ava Brown", 10101, "ava.brown@email.com", "1000 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (91, "Jenny Smith", 11111, "jenny.smith@email.com", "100 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (92, "Ryan Davis", 22222, "ryan.davis@email.com", "200 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (93, "Sophia Wilson", 33333, "sophia.wilson@email.com", "300 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (94, "Jacob Turner", 44444, "jacob.turner@email.com", "400 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (95, "Emily Brown", 55555, "emily.brown@email.com", "500 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (96, "Michael Johnson", 66666, "michael.johnson@email.com", "600 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (97, "Madison Davis", 77777, "madison.davis@email.com", "700 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (98, "Olivia Wilson", 88888, "olivia.wilson@email.com", "800 Main St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (99, "William Turner", 99999, "william.turner@email.com", "900 Market St, Anytown USA 12345");
insert into Agent (Agent_ID, Agent_Name, Agent_Phone, Agent_Email, Agent_Location) values (100, "Ava Brown", 10101, "ava.brown@email.com", "1000 Main St, Anytown USA 12345");










































INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (1, 21, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (2, 22, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (3, 23, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (4, 24, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (5, 25, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (6, 26, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (7, 27, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (8, 28, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (9, 29, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (10, 30, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (11, 21, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (12, 22, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (13, 23, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (14, 24, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (15, 25, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (16, 26, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (17, 27, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (18, 28, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (19, 29, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (20, 30, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (21, 21, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (22, 22, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (23, 23, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (24, 24, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (25, 25, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (26, 26, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (27, 27, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (28, 28, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (29, 29, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (30, 30, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (31, 21, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (32, 22, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (33, 23, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (34, 24, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (35, 25, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (36, 26, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (37, 27, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (38, 28, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (39, 29, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (40, 30, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (41, 21, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (42, 22, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (43, 23, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (44, 24, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (45, 25, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (46, 26, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (47, 27, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (48, 28, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (49, 29, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (50, 30, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (51, 21, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (52, 22, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (53, 23, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (54, 24, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (55, 25, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (56, 26, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (57, 27, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (58, 28, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (59, 29, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (60, 30, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (61, 21, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (62, 22, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (63, 23, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (64, 24, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (65, 25, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (66, 26, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (67, 27, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (68, 28, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (69, 29, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (70, 30, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (71, 21, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (72, 22, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (73, 23, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (74, 24, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (75, 25, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (76, 26, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (77, 27, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (78, 28, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (79, 29, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (80, 30, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (81, 21, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (82, 22, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (83, 23, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (84, 24, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (85, 25, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (86, 26, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (87, 27, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (88, 28, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (89, 29, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (90, 30, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (91, 21, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (92, 22, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (93, 23, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (94, 24, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (95, 25, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (96, 26, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (97, 27, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (98, 28, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (99, 29, 211, 212, 213, 214, 215, 1011, 1012, 1013);
INSERT INTO Cart (Cart_ID, User_ID, Product1_ID, Product2_ID, Product3_ID, Product4_ID, Product5_ID, Combo1_ID, Combo2_ID, Combo3_ID) VALUES (100, 30, 211, 212, 213, 214, 215, 1011, 1012, 1013);































INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10001, 1, 1, 10, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10002, 2, 2000, 20, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10003, 3, 500, 5, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10004, 4, 5000, 50, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10005, 5, 1500, 15, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10006, 6, 700, 7, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10007, 7, 7500, 75, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10008, 8, 800, 8, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10009, 9, 9000, 90, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10010, 10, 1200, 12, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10011, 1, 1, 10, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10012, 2, 2000, 20, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10013, 3, 500, 5, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10014, 4, 5000, 50, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10015, 5, 1500, 15, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10016, 6, 700, 7, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10017, 7, 7500, 75, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10018, 8, 800, 8, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10019, 9, 9000, 90, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10020, 10, 1200, 12, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10021, 1, 1, 10, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10022, 2, 2000, 20, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10023, 3, 500, 5, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10024, 4, 5000, 50, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10025, 5, 1500, 15, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10026, 6, 700, 7, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10027, 7, 7500, 75, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10028, 8, 800, 8, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10029, 9, 9000, 90, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10030, 10, 1200, 12, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10031, 1, 1, 10, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10032, 2, 2000, 20, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10033, 3, 500, 5, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10034, 4, 5000, 50, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10035, 5, 1500, 15, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10036, 6, 700, 7, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10037, 7, 7500, 75, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10038, 8, 800, 8, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10039, 9, 9000, 90, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10040, 10, 1200, 12, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10041, 1, 1, 10, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10042, 2, 2000, 20, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10043, 3, 500, 5, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10044, 4, 5000, 50, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10045, 5, 1500, 15, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10046, 6, 700, 7, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10047, 7, 7500, 75, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10048, 8, 800, 8, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10049, 9, 9000, 90, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10050, 10, 1200, 12, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10051, 1, 1, 10, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10052, 2, 2000, 20, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10053, 3, 500, 5, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10054, 4, 5000, 50, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10055, 5, 1500, 15, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10056, 6, 700, 7, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10057, 7, 7500, 75, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10058, 8, 800, 8, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10059, 9, 9000, 90, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10060, 10, 1200, 12, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10061, 1, 1, 10, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10062, 2, 2000, 20, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10063, 3, 500, 5, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10064, 4, 5000, 50, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10065, 5, 1500, 15, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10066, 6, 700, 7, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10067, 7, 7500, 75, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10068, 8, 800, 8, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10069, 9, 9000, 90, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10070, 10, 1200, 12, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10071, 1, 1, 10, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10072, 2, 2000, 20, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10073, 3, 500, 5, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10074, 4, 5000, 50, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10075, 5, 1500, 15, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10076, 6, 700, 7, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10077, 7, 7500, 75, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10078, 8, 800, 8, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10079, 9, 9000, 90, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10080, 10, 1200, 12, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10081, 1, 1, 10, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10082, 2, 2000, 20, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10083, 3, 500, 5, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10084, 4, 5000, 50, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10085, 5, 1500, 15, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10086, 6, 700, 7, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10087, 7, 7500, 75, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10088, 8, 800, 8, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10089, 9, 9000, 90, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10090, 10, 1200, 12, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10091, 1, 1, 10, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10092, 2, 2000, 20, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10093, 3, 500, 5, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10094, 4, 5000, 50, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10095, 5, 1500, 15, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10096, 6, 700, 7, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10097, 7, 7500, 75, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10098, 8, 800, 8, 0);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10099, 9, 9000, 90, 1);
INSERT INTO Payment (Payment_ID, Cart_ID, Order_Price, Discount, Payment_Status) VALUES (10100, 10, 1200, 12, 0);
















INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (1, 10001, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (2, 10002, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (3, 10003, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (4, 10004, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (5, 10005, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (6, 10006, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (7, 10007, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (8, 10008, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (9, 10009, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (10, 10010, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (11, 10001, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (12, 10002, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (13, 10003, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (14, 10004, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (15, 10005, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (16, 10006, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (17, 10007, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (18, 10008, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (19, 10009, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (20, 10010, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (21, 10001, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (22, 10002, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (23, 10003, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (24, 10004, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (25, 10005, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (26, 10006, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (27, 10007, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (28, 10008, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (29, 10009, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (30, 10010, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (31, 10001, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (32, 10002, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (33, 10003, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (34, 10004, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (35, 10005, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (36, 10006, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (37, 10007, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (38, 10008, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (39, 10009, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (40, 10010, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (41, 10001, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (42, 10002, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (43, 10003, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (44, 10004, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (45, 10005, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (46, 10006, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (47, 10007, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (48, 10008, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (49, 10009, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (50, 10010, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (51, 10001, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (52, 10002, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (53, 10003, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (54, 10004, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (55, 10005, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (56, 10006, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (57, 10007, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (58, 10008, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (59, 10009, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (60, 10010, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (61, 10001, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (62, 10002, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (63, 10003, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (64, 10004, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (65, 10005, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (66, 10006, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (67, 10007, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (68, 10008, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (69, 10009, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (70, 10010, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (71, 10001, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (72, 10002, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (73, 10003, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (74, 10004, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (75, 10005, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (76, 10006, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (77, 10007, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (78, 10008, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (79, 10009, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (80, 10010, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (81, 10001, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (82, 10002, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (83, 10003, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (84, 10004, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (85, 10005, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (86, 10006, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (87, 10007, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (88, 10008, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (89, 10009, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (90, 10010, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (91, 10001, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (92, 10002, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (93, 10003, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (94, 10004, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (95, 10005, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (96, 10006, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (97, 10007, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (98, 10008, 0);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (99, 10009, 1);
INSERT INTO Purchases (Order_ID, Payment_ID, Order_Status) VALUES (100, 10010, 1);

















INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (1, 1, 'New York');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (2, 2, 'London');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (3, 3, 'Beijing');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (4, 4, 'Sydney');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (5, 5, 'Paris');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (6, 6, 'Dubai');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (7, 7, 'New Delhi');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (8, 8, 'Moscow');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (9, 9, 'Rio de Janeiro');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (10, 10, 'Cape Town');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (11, 1, 'New York');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (12, 2, 'London');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (13, 3, 'Beijing');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (14, 4, 'Sydney');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (15, 5, 'Paris');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (16, 6, 'Dubai');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (17, 7, 'New Delhi');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (18, 8, 'Moscow');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (19, 9, 'Rio de Janeiro');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (20, 10, 'Cape Town');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (21, 1, 'New York');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (22, 2, 'London');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (23, 3, 'Beijing');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (24, 4, 'Sydney');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (25, 5, 'Paris');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (26, 6, 'Dubai');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (27, 7, 'New Delhi');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (28, 8, 'Moscow');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (29, 9, 'Rio de Janeiro');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (30, 10, 'Cape Town');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (31, 1, 'New York');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (32, 2, 'London');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (33, 3, 'Beijing');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (34, 4, 'Sydney');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (35, 5, 'Paris');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (36, 6, 'Dubai');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (37, 7, 'New Delhi');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (38, 8, 'Moscow');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (39, 9, 'Rio de Janeiro');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (40, 10, 'Cape Town');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (41, 1, 'New York');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (42, 2, 'London');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (43, 3, 'Beijing');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (44, 4, 'Sydney');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (45, 5, 'Paris');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (46, 6, 'Dubai');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (47, 7, 'New Delhi');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (48, 8, 'Moscow');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (49, 9, 'Rio de Janeiro');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (50, 10, 'Cape Town');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (51, 1, 'New York');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (52, 2, 'London');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (53, 3, 'Beijing');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (54, 4, 'Sydney');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (55, 5, 'Paris');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (56, 6, 'Dubai');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (57, 7, 'New Delhi');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (58, 8, 'Moscow');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (59, 9, 'Rio de Janeiro');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (60, 10, 'Cape Town');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (61, 1, 'New York');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (62, 2, 'London');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (63, 3, 'Beijing');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (64, 4, 'Sydney');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (65, 5, 'Paris');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (66, 6, 'Dubai');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (67, 7, 'New Delhi');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (68, 8, 'Moscow');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (69, 9, 'Rio de Janeiro');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (70, 10, 'Cape Town');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (71, 1, 'New York');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (72, 2, 'London');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (73, 3, 'Beijing');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (74, 4, 'Sydney');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (75, 5, 'Paris');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (76, 6, 'Dubai');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (77, 7, 'New Delhi');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (78, 8, 'Moscow');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (79, 9, 'Rio de Janeiro');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (80, 10, 'Cape Town');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (81, 1, 'New York');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (82, 2, 'London');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (83, 3, 'Beijing');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (84, 4, 'Sydney');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (85, 5, 'Paris');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (86, 6, 'Dubai');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (87, 7, 'New Delhi');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (88, 8, 'Moscow');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (89, 9, 'Rio de Janeiro');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (90, 10, 'Cape Town');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (91, 1, 'New York');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (92, 2, 'London');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (93, 3, 'Beijing');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (94, 4, 'Sydney');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (95, 5, 'Paris');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (96, 6, 'Dubai');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (97, 7, 'New Delhi');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (98, 8, 'Moscow');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (99, 9, 'Rio de Janeiro');
INSERT INTO Delivery (Agent_ID, Order_ID, Godown_Location) VALUES (100, 10, 'Cape Town');




