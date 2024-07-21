import mysql.connector

connection = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="",
  database="MilkMela"
)

cursorobj = connection.cursor()
  
query = """INSERT INTO PRODUCT(Product_ID, Vendor_ID, Product_Name, Product_Price, Product_Desription, Product_Stock) VALUES(101, 12, "New Dairy Product", 10.99, "A new dairy product in the market", "2014");"""
query2 = "SELECT * FROM Product WHERE Vendor_ID =  5"


cursorobj.execute(query)
   
myresult = cursorobj.fetchall()
   
for o in myresult:
    print(o)


cursorobj.execute(query2)
myresult = cursorobj.fetchall()
for z in myresult:
    print(z)
    

connection.close()