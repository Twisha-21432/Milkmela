import mysql.connector
import argparse
from sqlalchemy import create_engine, Table, Column, Integer, String, MetaData, Date, Float

# Define the database connection string
engine = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="12345",
  database="MilkMela"
)

# Define the metadata and table
metadata = MetaData()
product= Table('Product', metadata,
    Column('Product_ID', Integer, primary_key=True),
    Column('Vendor_ID', Integer),
    Column('Product_name', String),
    Column('Product_Price', Integer),
    Column('Product_Stock', Integer),
    Column('Product_Description', String)
)

# vendor= Table('Vendor',metadata,
#             Column('Vendor_ID', primary_key =True),
#             Column('Vendor_Name', String),
#             Column('Vendor_Phone',Integer), 
#             Column('Vendor_Email',String),
#             Column('Vendor_Location',String)
#             )

# Define the CLI commands
parser = argparse.ArgumentParser(description='Manage dairy company inventory')
subparsers = parser.add_subparsers(dest='command')

# Add a command to list all products
list_parser = subparsers.add_parser('list', help='List all products')
list_parser.set_defaults(func=lambda args: print(engine.execute(product.select()).fetchall()))

# Add a command to add a product
add_parser = subparsers.add_parser('add', help='Add a product')
add_parser.add_argument('Product_name', type=str, help='The name of the product')
add_parser.add_argument('Product_Stock', type=int, help='The quantity of the product')
add_parser.add_argument('Product_Price', type=int, help='The price of the product')
add_parser.set_defaults(func=lambda args: engine.execute(product.insert().values(Product_name=args.Product_name, Product_Stock=args.Product_Stock, Product_Price=args.Product_Price)))

# Add a command to update a product
update_parser = subparsers.add_parser('update', help='Update a product')
update_parser.add_argument('Product_ID', type=int, help='The ID of the product to update')
update_parser.add_argument('--Product_name', type=str, help='The new name of the product')
update_parser.add_argument('--Product_Stock', type=int, help='The new quantity of the product')
update_parser.add_argument('--Product_Price', type=int, help='The new price of the product')
update_parser.set_defaults(func=lambda args: engine.execute(product.update().where(product.c.Product_ID == args.Product_ID).values(Product_name=args.Product_name, Product_Stock=args.Product_Stock, Product_Price=args.Product_Price)))

# Add a command to delete a product
delete_parser = subparsers.add_parser('delete', help='Delete a product')
delete_parser.add_argument('id', type=int, help='The ID of the product to delete')
delete_parser.set_defaults(func=lambda args: engine.execute(product.delete().where(product.c.Product_ID == args.Product_ID)))

# Parse the arguments and execute the appropriate command
args = parser.parse_args()
if not args.command:
    parser.print_help()
else:
    args.func(args)