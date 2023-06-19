import subprocess as sp
import pymysql
import pymysql.cursors
import time
from tabulate import tabulate
# 	execute returns number of rows affected

#-----------------------------------------------------LOGIN-------------------------------------------------------------------------------
def login():
	tmp = sp.call('clear', shell=True)
	print("LOG IN TO THE SQL SERVER");
	global con
	username = input("Username: ")
	password = input("Password: ")
	try:
		con = pymysql.connect(host='localhost',
	                              user=username,
	                              password=password,
	                              db='RealEstate',
	                              cursorclass=pymysql.cursors.DictCursor)
		global cur
		cur = con.cursor()
	except:
		print()
		print("Failed,Please TRY AGAIN!")
		input("Press Enter to continue")
		login()

#----------------------------------------------------ESTATE OUTPUT------------------------------------------------------------------------------

def main_output():
	tmp = sp.call('clear', shell=True);
	print("\t\t------------------------------------------------------------------------------------")
	print("\t\t                             WELCOME TO THE DATABASE OF                             ")
	print("\t\t                                  MAK REAL ESTATE                                     ")
	print("\t\t------------------------------------------------------------------------------------")
	print();print();




#---------------------------------------------------------Propety Deal------------------------------------------------------------------------------

def property_deal():
	main_output()
	print("Enter the requried information")
	buyerid =    int(input("Enter ID of Buyer:       "))
	sellerid =   int(input("Enter ID of Seller:      "))
	propertyid = int(input("Enter ID of Property:    "))
	agentid =    int(input("Enter ID of Agent:       "))
	query = " SELECT * FROM BUYER WHERE BuyerID = '%d'" % (buyerid)
	cur.execute(query)
	if(len(cur.fetchall()) == 0):
		print("Invalid BuyerID")
		input("Press Enter to continue")
		return
	query = " SELECT * FROM SELLER WHERE SellerID = '%d'" % (sellerid)
	cur.execute(query)
	if(len(cur.fetchall()) == 0):
		print("Invalid SellerID")
		input("Press Enter to continue")
		return
	query = " SELECT * FROM AGENT WHERE AgentID = '%d'" % (agentid)
	cur.execute(query)
	if(len(cur.fetchall()) == 0):
		print("Invalid AgentID")
		input("Press Enter to continue")
		return
	query = "SELECT * FROM PROPERTY WHERE PropertyID = '%d'" % (propertyid)
	cur.execute(query)
	tempdict = cur.fetchall()
	if(len(tempdict) == 0):
		print("Invalid PropertyID")
		input("Press Enter to continue")
		return
	if(tempdict[0]["SellerID"] != sellerid):
		print("Property does not belong to this seller")
		input("Press Enter to continue")
		return
	query = "INSERT INTO PROPERTYDEAL(BuyerID,SellerID,PropertyID,AgentID) VALUES('%d','%d','%d','%d')" % (buyerid,sellerid,propertyid,agentid)
	cur.execute(query)
	query = "UPDATE PROPERTY SET SellerID = NULL WHERE PropertyID = '%d'" % (propertyid)
	cur.execute(query)
	Bonus = float(tempdict[0]['Cost'] * 0.02)
	query = "UPDATE AGENT SET Bonus = Bonus + '%f' WHERE AgentID = '%d'" % (Bonus,agentid)
	cur.execute(query)
	print()
	print("Deal made successfully")
	print("Bonus successfully given to the Agent")
	print()
	input("Press Enter to continue")
#-----------------------------------------------------ADMINISTRATOR------------------------------------------------------------------------------


def insert_bank():
	main_output()
	bank = {}
	print("Enter the following Bank details")
	bank["Name"] = input("Enter Name: ")
	bank["BranchAddress"] = input("Enter Branch address: ")
	bank["InterestRate"] = float(input("Enter interest rate offered by Bank: "))
	query = "SELECT * FROM BANKINTEREST WHERE Name = '%s'" % (bank["Name"])
	cur.execute(query)
	tempdict = cur.fetchall()
	if(len(tempdict) == 0):
		query = "INSERT INTO BANKINTEREST(Name,InterestRate) VALUES('%s','%f')" % (bank["Name"],bank["InterestRate"])
		cur.execute(query)
	query = "INSERT INTO BANK(Name,BranchAddress) VALUES('%s','%s')" % (bank["Name"],bank["BranchAddress"])
	cur.execute(query)
	query = "SELECT * FROM BANK WHERE BranchAddress = '%s'" % bank["BranchAddress"]
	cur.execute(query)
	tempdict = cur.fetchall()
	BankID = tempdict[0]["BankID"];
	print("Data successfully inserted with BankID: " + str(BankID))
	input("Press Enter to continue")

def delete_bank():
	main_output()
	bankid = int(input("Enter the BankID u want to delete: "))
	query = "DELETE FROM BANK WHERE BANKID = '%d'" % (bankid)
	if(cur.execute(query) == 0):
		print("No such Bank")
	else:
		print("Successfull")
	input("Press Enter to continue")

def update_bank():
	main_output()
	name = input("Enter the Bank name to update the interest rate: ")
	interest = float(input("Enter new interest rate: "))
	query = "UPDATE BANKINTEREST SET InterestRate = '%f' WHERE Name = '%s'" % (interest, name)
	if(cur.execute(query) == 0):
		print("No such Bank")
	else:
		print("Successfull")
	input("Press Enter to continue")

def bankc_choice(choice):
	if(choice == 1):
		insert_bank()
		return 1
	elif(choice == 2):
		delete_bank()
		return 1
	elif(choice == 3):
		update_bank()
		return 1
	elif choice == 4:
		return 2
	else:
		print("Choice out of range")
		input("Press Enter to continue")
		return 0
def insert_dependent(AgentID):
	print()
	cnt = int(input("Enter number of dependents: "))
	for i in range(cnt):
		print()
		print("Enter information about the Dependent of the Agent")
		depen = {}
		depen["Name"] = input("Enter Name: ")
		depen["Age"] = int(input("Enter Age: "))
		depen["Gender"] = input("Enter Gender(Male,Female): ")
		depen["Relationship"] = input("Enter Relationship: ")
		query = "INSERT INTO DEPENDENT(AgentID, Name, Gender,Age,Relationship) VALUES('%d','%s','%s','%d','%s')" % (AgentID,depen["Name"],depen["Gender"],depen["Age"],depen["Relationship"])
		cur.execute(query)
		con.commit()

def insert_agent():
	main_output()
	agent = {}
	print("Enter details of the Agent")
	agent["Name"] = input("Ente name: ")
	agent["MobileNo"] = input("Enter Mobile Number: ")
	agent["Salary"] = int(input("Enter salary: "))
	agent["SuperID"] = input("Enter id of Supervisor (Leave empty for no supervisor): ")
	if(agent["SuperID"] != ''):
		query = "INSERT INTO AGENT(Name,MobileNo,Salary,SuperID) VALUES('%s','%s','%d','%d')" % (agent["Name"], agent["MobileNo"], agent["Salary"], int(agent["SuperID"]))
	else:
		query = "INSERT INTO AGENT(Name,MobileNo,Salary) VALUES('%s','%s','%d')" % (agent["Name"], agent["MobileNo"], agent["Salary"])
	cur.execute(query)
	con.commit()
	query = "SELECT * FROM AGENT WHERE MobileNo = '%s'" % agent["MobileNo"]
	cur.execute(query)
	tempdict = cur.fetchall()
	AgentID = tempdict[0]["AgentID"]
	print("Data successfully inserted with AgentID: " + str(AgentID))
	insert_dependent(AgentID)
	print("Successfull")
	input("Press Enter to continue")


def delete_agent():
	main_output()
	agentid = int(input("Enter the AgentID u want to delete: "))
	query = "DELETE FROM AGENT WHERE AgentID = '%d'" % (agentid)
	if(cur.execute(query) == 0):
		print("No such Agent")
	else:
		print("Successfull")
	input("Press Enter to continue")

def update_agent():
	main_output()
	agentid = int(input("Enter the AgentID u want to update the salary to: "))
	salary = int(input("Enter the new salary of the salary: "))
	query = "UPDATE AGENT SET Salary = '%d' WHERE AgentID = '%d'" % (salary,agentid)
	if(cur.execute(query) == 0):
		print("No such Agent")
	else:
		print("Successfull")
	input("Press Enter to continue")


def agentc_choice(choice):
	if(choice == 1):
		insert_agent()
		return 1
	elif(choice == 2):
		delete_agent()
		return 1
	elif(choice == 3):
		update_agent()
		return 1
	elif choice == 4:
		return 2
	else:
		print("Choice out of range")
		input("Press Enter to continue")
		return 0

def bank_change():
	main_output()
	print("MENTION THE NUMBER CORRESPONDING TO YOUR CHOICE");	
	print();
	print("1. Insert Bank Entries");
	print("2. Delete Bank Entries");
	print("3. Update Bank Entries");
	print("4. Previous Menu")
	print();
	choice = int(input("Enter choice: "))
	if(bankc_choice(choice) == 2):
		return
	else:
		con.commit()
		bank_change()

def agent_change():
	main_output()
	print("MENTION THE NUMBER CORRESPONDING TO YOUR CHOICE");	
	print();
	print("1. Insert Agent Entries");
	print("2. Delete Agent Entries");
	print("3. Update Agent Entries");
	print("4. Previous Menu")
	print();
	choice = int(input("Enter choice: "))
	if(agentc_choice(choice) == 2):
		return
	else:
		con.commit()
		agent_change()

def admin_choice(choice):
	if(choice == 1):
		bank_change()
		return 1
	elif(choice == 2):
		agent_change()
		return 1
	elif(choice == 3):
		property_deal()
		return 1
	elif(choice == 4):
		return 2
	else:
		print("Choice out of range")
		input("Press Enter to continue")
		return 0

def choice_administrator():
	main_output()
	print("MENTION THE NUMBER CORRESPONDING TO YOUR CHOICE");	
	print();
	print("1. Operations on Bank Entries");
	print("2. Operations on Agent Entries");
	print("3. Register a property deal")
	print("4. Logout");
	print();
	try:
		choice = int(input("Enter choice: "))
		if(admin_choice(choice) == 2):
			return
		else:
			con.commit()
			choice_administrator()
	except Exception as e:
		con.rollback()
		print("Coud not be completed :(")
		print(">>>>>>>",e)
		input("Press Enter to continue")
		choice_administrator()


def administrator():
	main_output()
	id = input("Enter the unique Administrator ID: ")
	if(id == "database are okish"):
		choice_administrator()
	else:
		print("Nope try again! Hint check README")
		input("Press Enter to continue")
		administrator()
#---------------------------------------------------------Queries------------------------------------------------------------------------------

def print_query(query):
	cur.execute(query)
	print()
	list = cur.fetchall()
	if(len(list) == 0):
		print("No Record Found")
		return
	print()
	print(tabulate(list,headers = "keys",tablefmt="psql"))
	print()

def q1():
	main_output()
	subclass = input("Enter the subclass of proprerty(Residential,Plot,Commercial): ");
	query = "";
	if subclass == "Residential":
		query = "SELECT * FROM RESIDENTIAL";
	elif subclass == "Plot":
		query = "SELECT * FROM PLOT";
	elif subclass == "Commercial":
		query = "SELECT * FROM COMMERCIAL";
	else:
		print("Unknown subclass\nTry Again!")
		input("Press Enter to continue")
		q1()
		return
	print_query(query)
	input("Press Enter to continue")

def q2():
	main_output()
	print()
	print("Select a valid option: ")
	print("1. Search by PINCODE")
	print("2. Select by City")
	print("3. Select by State")
	choice = int(input("Enter choice: "))
	if(choice < 1 or choice > 3):
		print("Print choice out of range")
		return
	if(choice == 1):
		pincode = input("Enter PINCODE: ")
		query = "SELECT * FROM STREETTOPINCODE NATURAL JOIN PROPERTY WHERE Pincode = '%s'" % (pincode)
		print_query(query)
	if(choice == 2):
		city = input("Enter City: ")
		query = "SELECT * FROM PINCODETOCITY NATURAL JOIN STREETTOPINCODE NATURAL JOIN PROPERTY WHERE City = '%s'" % (city)
		print_query(query)
	if(choice == 3):
		state = input("Enter State: ")
		query = "SELECT * FROM CITYTOSTATE NATURAL JOIN PINCODETOCITY NATURAL JOIN STREETTOPINCODE NATURAL JOIN PROPERTY WHERE State = '%s'" % (state)
		print_query(query)

	input("Press Enter to continue")

def q3():
	main_output()
	cost = int(input("Enter Cost: "))
	query = "SELECT * FROM PROPERTY WHERE COST < '%d'" % (cost);
	print_query(query)
	input("Press Enter to continue")

def q4():
	main_output()
	city = input("Enter City: ")
	query = "SELECT MIN(CostPerSqFt) FROM PLOT NATURAL JOIN PROPERTY NATURAL JOIN STREETTOPINCODE NATURAL JOIN PINCODETOCITY WHERE CITY = '%s'" % (city)
	print_query(query)
	input("Press Enter to continue")

def q5():
	main_output()
	bname = input("Enter Bank Name: ")
	query = "SELECT INTERESTRATE FROM BANKINTEREST WHERE NAME = '%s'" % (bname)
	print_query(query)
	input("Press Enter to continue")

def q6():
	main_output()
	query = "SELECT AVG(CreditScore) FROM BUYER WHERE BankID IS NOT NULL";
	print_query(query)
	input("Press Enter to continue")

def q7():
	main_output()
	agentid = int(input("Enter Agent ID of the agent: "))
	query = " SELECT * FROM AGENT WHERE AgentID = '%d'" % (agentid)
	cur.execute(query)
	if(len(cur.fetchall()) == 0):
		print("Invalid AgentID")
		input("Press Enter to continue")
		return
	q1 = "SELECT IFNULL(COUNT(*),0) AS Residential_Properties FROM PROPERTYDEAL NATURAL JOIN RESIDENTIAL WHERE AgentID = '%d'" % (agentid)
	q2 = "SELECT IFNULL(COUNT(*),0) AS Plot_Properties FROM PROPERTYDEAL NATURAL JOIN PLOT WHERE AgentID = '%d'" % (agentid)
	q3 = "SELECT IFNULL(COUNT(*),0) AS Commercial_Properties FROM PROPERTYDEAL NATURAL JOIN COMMERCIAL WHERE AgentID = '%d'" % (agentid)
	print_query(q1)
	print_query(q2)
	print_query(q3)
	input("Press Enter to continue")

	
def query_choice(choice):
	if(choice == 1):
		q1()
		return 1
	if(choice == 2):
		q2()
		return 1
	if(choice == 3):
		q3()
		return 1
	if(choice == 4):
		q4()
		return 1
	if(choice == 5):
		q5()
		return 1
	if(choice == 6):
		q6()
		return 1
	if(choice == 7):
		q7()
		return 1
	if(choice == 8):
		return 2
	else:
		print("Choice out of range")
		input("Press Enter to continue")
		return 0

def queries():
	main_output()
	print("MENTION THE NUMBER CORRESPONDING TO YOUR CHOICE")
	print()
	print("1.  List properties according to Property Subclass");
	print("2.  Retrieve properties using Pincode,City or State");
	print("3.  Retrieve properties less than some cost");
	print("4.  Get minimum cost per sq feet in a given city for a plot");
	print("5.  Get Interest rate for the bank");
	print("6.  Average Credit Score of the buyers the bank gives Loan too");
	print("7.  Number of Properties of each Subclass the Agent has dealt with till now");
	print("8.  Previous Menu");
	print();
	try:
		choice = int(input("Enter choice: "))
		if(query_choice(choice) == 2):
			return
		else:
			queries()
	except Exception as e:
		print("Could Not Be Completed :'(")
		print(">>>>>",e)
		input("Press Enter to continue")
		queries()



#---------------------------------------------------------SELLER------------------------------------------------------------------------------

def list_property():
	main_output()
	SellerID = int(input("Enter your SellerID: "))
	query = "SELECT * FROM PROPERTY WHERE SellerID = '%d'" % (SellerID)
	print_query(query)
	input("Press Enter to continue")

def delete_property():
	main_output()
	sellerid = int(input("Enter your SellerID: "))
	propertyid = int(input("Enter Property ID of the property u want to delete: "))
	query = "SELECT * FROM PROPERTY WHERE PropertyID = '%d'" % (propertyid)
	cur.execute(query)
	tempdict = cur.fetchall()
	if(len(tempdict) == 0):
		print("Invalid PropertyID")
		input("Press Enter to continue")
		return
	if(tempdict[0]["SellerID"] != sellerid):
		print("Property does not belong to you")
		input("Press Enter to continue")
		return
	query = "DELETE FROM PROPERTY WHERE PropertyID = '%d'" % (propertyid)
	cur.execute(query)
	print("Successfully Deleted the Property from the Database")
	input("Press Enter to continue")

def delete_seller():
	main_output()
	sellerid = int(input("Enter your SellerID: "))
	query = "DELETE FROM SELLER WHERE SellerID = '%d'" % (sellerid)
	if(cur.execute(query) == 0):
		print("No such Seller is listed")
	else:
		print("Successfull")
	input("Press Enter to continue")

def update_mobile():
	main_output()
	sellerid = int(input("Enter your SellerID: "))
	mobileno = int(input("Enter new mobile number: "))
	query = "UPDATE SELLER SET MobileNo = '%s' WHERE SellerID = '%d'" % (mobileno,sellerid)
	if(cur.execute(query) == 0):
		print("No such seller is listed")
	else:
		print("Successfull")
	input("Press Enter to continue")

def list_seller():
	main_output()
	sellerid = int(input("Enter your SellerID: "))
	query = "SELECT * FROM SELLER WHERE SellerID = '%d'" % (sellerid)
	if(cur.execute(query) == 0):
		print("No such seller is listed")
	else:
		print_query(query)
		print("Successfull")
	input("Press Enter to continue")

def seller_choice(choice):
	if choice == 1:
		list_property()
		return 1
	elif choice == 2:
		delete_property()
		return 1
	elif choice == 3:
		delete_seller()
	elif choice == 4:
		update_mobile()
	elif choice == 5:
		list_seller()
	elif choice == 6:
		return 2
	else:
		print("Choice out of range")
		input("Press Enter to continue")
		return 0

def seller():
	main_output()
	print("MENTION THE NUMBER CORRESPONDING TO YOUR CHOICE");	
	print();
	print("1. Get details about the Proeperties You own");
	print("2. Remove a property from the database");
	print("3. Remove urself from the database");
	print("4. Update your Mobile number")
	print("5. See yout information")
	print("6. Previous Menu")
	print();
	try:
		choice = int(input("Enter choice: "))
		if(seller_choice(choice) == 2):
			return
		else:
			con.commit()
			seller()
	except Exception as e:
		con.rollback()
		print("Could Not Be Completed :'(")
		print(">>>>>",e)
		input("Press Enter to continue")
		seller()

#---------------------------------------------------------BUYER------------------------------------------------------------------------------

def delete_buyer():
	main_output()
	buyerid = int(input("Enter your BuyerID: "))
	query = "DELETE FROM BUYER WHERE BuyerID = '%d'" % (buyerid)
	if(cur.execute(query) == 0):
		print("No such Buyer is listed")
	else:
		print("Successfull")
	input("Press Enter to continue")

def update_mobile_buyer():
	main_output()
	buyerid = int(input("Enter your BuyerID: "))
	mobileno = int(input("Enter new mobile number: "))
	query = "UPDATE BUYER SET MobileNo = '%s' WHERE BuyerID = '%d'" % (mobileno,buyerid)
	if(cur.execute(query) == 0):
		print("No such buyer is listed")
	else:
		print("Successfull")
	input("Press Enter to continue")

def list_buyer():
	main_output()
	buyerid = int(input("Enter your BuyerID: "))
	query = "SELECT * FROM BUYER WHERE BuyerID = '%d'" % (buyerid)
	if(cur.execute(query) == 0):
		print("No such buyer is listed")
	else:
		print_query(query)
		print("Successfull")
	input("Press Enter to continue")

def buyer_choice(choice):
	if choice == 1:
		delete_buyer()
	elif choice == 2:
		update_mobile_buyer()
	elif choice == 3:
		list_buyer()
	elif choice == 4:
		return 2
	else:
		print("Choice out of range")
		input("Press Enter to continue")
		return 0

def buyer():
	main_output()
	print("MENTION THE NUMBER CORRESPONDING TO YOUR CHOICE");	
	print();
	print("1. Remove urself from the database");
	print("2. Update your Mobile number")
	print("3. See yout information")
	print("4. Previous Menu")
	print();
	try:
		choice = int(input("Enter choice: "))
		if(buyer_choice(choice) == 2):
			return
		else:
			con.commit()
			buyer()
	except Exception as e:
		con.rollback()
		print("Could Not Be Completed :'(")
		print(">>>>>",e)
		input("Press Enter to continue")
		buyer()

#---------------------------------------------------------REGISTER------------------------------------------------------------------------------

def register_residential(PropertyID):
	print()
	res = {}
	res["ElectricityTime"] = int(input("Enter Electricity Time(in Hours): "))
	res["WaterTime"] = int(input("Enter Water Time(in Hours): "))
	res["Type"] = input("Enter Type (Villa, Flat, Penthouse): ")
	res["LiftAvailibility"] = input("Enter Lift Availability (Yes, No): ")
	res["CarpetAreaInSqFt"] = int(input("Enter Carpet Area(In SqFeet): "))
	res["BedRooms"] = int(input("Enter number of bedrooms: "))
	res["ReservedParking"] = int(input("Enter number of reserved parking spots: "))
	query = "INSERT INTO RESIDENTIAL(PropertyID,ElectricityTime,WaterTime,Type,LiftAvailibility,CarpetAreaInSqFt,BedRooms,ReservedParking) VALUES('%d','%d','%d','%s','%s','%d','%d','%d')" % (PropertyID,res["ElectricityTime"],res["WaterTime"],res["Type"],res["LiftAvailibility"],res["CarpetAreaInSqFt"],res["BedRooms"],res["ReservedParking"])
	cur.execute(query)
	con.commit()

def services(PropertyID):
	print()
	cnt = int(input("Enter number of services offered: "))
	for i in range(cnt):
		desc = input("Enter service description: ")
		query = "INSERT INTO SERVICES(PropertyID,ServiceDesc) VALUES('%d','%s')" % (PropertyID,desc)
		cur.execute(query)
		con.commit()


def register_commercial(PropertyID):
	print()
	comm = {}
	comm["Floors"] = int(input("Enter number of floors: "))
	comm["Type"] = input("Enter Type (Office, Godown, Shop): ")
	comm["ParkingSpace"] = int(input("Enter number of reserved parking spots: "))
	comm["YearBuilt"] = int(input("Enter Year in which the proeperty was built: "))
	query = "INSERT INTO COMMERCIAL(PropertyID,Floors,Type,ParkingSpace,YearBuilt) VALUES ('%d','%d','%s','%d','%d')" % (PropertyID,comm["Floors"],comm["Type"],comm["ParkingSpace"],comm["YearBuilt"])
	cur.execute(query)
	con.commit()
	services(PropertyID)

def register_plot(PropertyID,Cost):
	print()
	plot = {}
	plot["AreaInAcres"] = int(input("Enter area in Acres: "))
	plot["BoundaryWall"] = input("Presence of Boundary Wall (Yes,No): ")
	plot["FloorsAllowed"] = int(input("Enter maximum number of floors that can be built: "))
	AreaInSqFt = float(plot["AreaInAcres"] * 43560 )
	query = "SELECT * FROM AREACONVERSION WHERE AreaInAcres = '%d'" % (plot["AreaInAcres"])
	cur.execute(query)
	tempdict = cur.fetchall()
	if(len(tempdict) == 0):
		query = "INSERT INTO AREACONVERSION(AreaInAcres,AreaInSqFt) VALUES('%d','%f')" % (plot["AreaInAcres"],AreaInSqFt)
		cur.execute(query)
	plot["CostPerSqFt"] = AreaInSqFt / Cost
	query = "INSERT INTO PLOT(PropertyID,AreaInAcres,BoundaryWall,FloorsAllowed,CostPerSqFt) VALUES('%d','%d','%s','%d','%f')" % (PropertyID,plot["AreaInAcres"],plot["BoundaryWall"],plot["FloorsAllowed"],plot["CostPerSqFt"])
	cur.execute(query)
	con.commit()

def register_person(PropertyID):
	cnt = int(input("Enter number of references for this property: "))
	for i in range(cnt):
		person = {}
		print()
		print("Enter details of someone who has used this property before")
		person["Name"] = input("Enter name: ")
		person["Gender"] = input("Enter gender(Male,Female): ")
		person["Occupation"] = input("Enter occupation: ")
		person["Remarks"] = input("Enter remarks about the property: ")
		query = "INSERT INTO PERSON(PropertyID,Name,Gender,Occupation,Remarks) VALUES('%d','%s','%s','%s','%s')" % (PropertyID,person["Name"],person["Gender"],person["Occupation"],person["Remarks"])
		cur.execute(query)
		con.commit()

def register_property(SellerID):
	print()
	print("Enter the Details for the Property")
	prop = {}
	prop["PropertyNo"] = input("Enter Propety number: ")
	prop["StreetAddress"] = input("Enter Street Address: ")
	prop["Pincode"] = input("Enter PINCODE: ")
	prop["City"] = input("Enter City: ")
	prop["State"] = input("Enter State: ")
	prop["AvailableFrom"] = input("Enter the DATE from which the Propety will be available(YYYY-MM-DD): ")
	prop["FacingDirection"] = input("Enter the direction the main gate of the propety is facing(North,South,East,West): ")
	prop["Cost"] = int(input("Enter the expected cost for the propety: "))
	query = "INSERT INTO STREETTOPINCODE(StreetAddress,Pincode) VALUES ('%s','%s')" % (prop["StreetAddress"],prop["Pincode"])
	cur.execute(query)
	query = "SELECT * FROM PINCODETOCITY WHERE Pincode = '%s'" % (prop["Pincode"])
	cur.execute(query)
	tempdict = cur.fetchall()
	if(len(tempdict) == 0):
		query = "INSERT INTO PINCODETOCITY(Pincode,City) VALUES ('%s','%s')" % (prop["Pincode"],prop["City"])
		cur.execute(query)
	query = "SELECT * FROM CITYTOSTATE WHERE City = '%s'" % (prop["City"])
	cur.execute(query)
	tempdict = cur.fetchall()
	if(len(tempdict) == 0):
		query = "INSERT INTO CITYTOSTATE(City,State) VALUES('%s','%s')" % (prop["City"],prop["State"])
		cur.execute(query)
	query = "INSERT INTO PROPERTY(PropertyNo,StreetAddress,AvailableFrom,Cost,FacingDirection,SellerID) VALUES('%s','%s','%s','%d','%s','%d')" % (prop["PropertyNo"],prop["StreetAddress"],prop["AvailableFrom"],prop["Cost"],prop["FacingDirection"],SellerID)
	cur.execute(query)
	query = "SELECT * FROM PROPERTY WHERE StreetAddress = '%s'" % (prop["StreetAddress"])
	cur.execute(query);
	tempdict = cur.fetchall()
	PropertyID = tempdict[0]['PropertyID']
	print()
	subclass = input("Enter Type of Property (Residential, Commercial, Plot): ")
	if subclass == "Residential":
		register_residential(PropertyID)
	elif subclass == "Commercial":
		register_commercial(PropertyID)
	elif subclass == "Plot":
		register_plot(PropertyID,prop["Cost"])
	else:
		print("Invalid entry in Property Class")
	print("Data is successfully inserted with PropertyID: " + str(PropertyID));
	register_person(PropertyID)
	print("Successfull")


def register_seller():
	main_output()
	sell = {}
	try:
		print("Enter the following details")
		sell["Name"]  = input("Enter name: ")
		sell["Email"] = input("Enter email: ")
		sell["MobileNo"]   = input("Enter MobileNo:  ")
		sell["Address"] = input("Enter Address: ")
		query = "INSERT INTO SELLER(Name,Email,MobileNo,Address) VALUES ('%s', '%s', '%s','%s')" % (sell["Name"], sell["Email"], sell["MobileNo"],sell["Address"])
		cur.execute(query)
		query = "SELECT * FROM SELLER WHERE Email = '%s'" % (sell["Email"])
		cur.execute(query);
		tempdict = cur.fetchall()
		con.commit()
		print("Data is successfully inserted with SellerID: " + str(tempdict[0]["SellerID"]));
		cnt = int(input("Enter number of properties u want to list: "))
		for i in range(cnt):
			register_property(tempdict[0]["SellerID"])
		input("Press Enter to continue")
	except Exception as e:
		con.rollback()
		print("Failed to insert into database")
		print(">>>>>>>>",e)
		input("Press Enter to continue")

def register_buyer():
	main_output()
	buy = {}
	try:
		print("Enter the following details")
		buy["Name"]  = input("Enter name: ")
		buy["Email"] = input("Enter email: ")
		buy["MobileNo"] = input("Enter MobileNo:  ")
		buy["Address"] = input("Enter Address: ")	
		buy["CreditScore"] = int(input("Enter Credit Score(300 - 800): "))
		buy["BankID"] = input("Enter BankID of the Bank if the  Buyer has taken a loan(Leave empty if not): ")
		query = "";
		if(buy["BankID"] == ''):
			query = "INSERT INTO BUYER(Name,Email,MobileNo,Address,CreditScore) VALUES('%s', '%s', '%s', '%s','%d')" % (buy["Name"],buy["Email"],buy["MobileNo"],buy["Address"],buy["CreditScore"])
		else:
			query = "INSERT INTO BUYER(Name,Email,MobileNo,Address,CreditScore,BankID) VALUES('%s', '%s', '%s', '%s','%d','%d')" % (buy["Name"],buy["Email"],buy["MobileNo"],buy["Address"],buy["CreditScore"],int(buy["BankID"]))
		cur.execute(query)
		con.commit()
		query = "SELECT * FROM BUYER WHERE Email = '%s'" % (buy["Email"])
		cur.execute(query);
		tempdict = cur.fetchall()
		print("Data is successfully inserted with BuyerID: " + str(tempdict[0]["BuyerID"]));
		input("Press Enter to continue")
	except Exception as e:
		con.rollback()
		print("Failed to insert into database")
		print(">>>>>>>>",e)
		input("Press Enter to continue")

def register_choice(choice):
	if(choice == 1):
		register_seller()
		return 1
	elif(choice == 2):
		register_buyer()
		return 1
	elif(choice == 3):
		return 2
	else:
		print("Choice out of range")
		input("Press Enter to continue")
		return 0

def register():
	main_output()
	print("MENTION THE NUMBER CORRESPONDING TO YOUR CHOICE");	
	print();
	print("1. Signup as Seller");
	print("2. Signup as Buyer");
	print("3. Previous Menu");
	print();
	try:
		choice = int(input("Enter choice: "))
		if(register_choice(choice) == 2):
			return
		else:
			register()
	except Exception as e:
		print("Could Not Be Completed :'(")
		print(">>>>>",e)
		input("Press Enter to continue")
		register()





#-----------------------------------------------------MAIN CHOICE CHECK------------------------------------------------------------------------------

def main_choice(choice):
	if(choice == 1):
		administrator()
	elif (choice == 2):
		queries()
	elif(choice == 3):
		seller()
	elif (choice == 4):
		buyer()
	elif (choice == 5):
		register()
	elif(choice == 6):
		print("BYE!!")
		global running
		running = False
	else:
		print("Please choose from the above mentioned choices")
		input("Press Enter to continue")


#-----------------------------------------------------MAIN PROMPT-------------------------------------------------------------------------------

def main_prompt():
	print("MENTION THE NUMBER CORRESPONDING TO YOUR CHOICE");	
	print();
	print("1. Login as Administrator");
	print("2. Funtionalities of the database");
	print("3. Login as Seller");
	print("4. Login as Buyer")
	print("5. New User Signup for Seller/Buyer");
	print("6. Quit");
	print();
	try:
		choice = int(input("Enter choice: "));
		main_choice(choice);
	except:
		print("\nINVALID CHOICE!!\nTRY AGAIN");
		input("Press Enter to continue");


#-----------------------------------------------------MAIN-------------------------------------------------------------------------------

if __name__ == "__main__":
	login();
	global running
	running = True;
	while(running == True):
		main_output();
		main_prompt();

