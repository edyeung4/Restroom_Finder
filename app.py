from flask import Flask, render_template, request, redirect, jsonify
from database.db_connector import connect_to_database, execute_query
import os

# Configuration

app = Flask(__name__)

# Routes 
@app.route('/index')
def index():
    '''True URL of homepage'''
    print('Welcome to the homepage.')
    return render_template('index.html')

@app.route('/')
def root():
    '''Return the homepage'''
    print('Root index hit. Redirecting to index.html...')
    return redirect('/index')

@app.route('/employee_login')
def emp_login():
    '''Login page for employees'''
    print('Accessing the login portal for employees.')
    return render_template('employee_login.html')

#@app.route('/api/restroom_search', methods=['GET','POST'])
#def rr_search():
#    if request.method == 'POST':
#        print('POST received.')
#        search_data = request.form.get('search')
#        return jsonify(search_data)
#    return "thanks!"

@app.route('/employee_update', methods=['POST'])
def emp_update():
        id = request.form['restroomID']
        address = request.form['address']
        return address

@app.route('/employee_index', methods=['GET','POST'])
def emp_index():
    if request.method == 'POST':
        print('POST received.')
        print()
        print('SEARCH: ' + request.form['search'])
        print('CATEGORY: ' + request.form['restroomSearch'])
        print()
        db_connection = connect_to_database()
	# if request.form['search'] is empty, return all
        if request.form['search'] == '':
            query = "SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address,rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID FROM Restrooms rr JOIN Locations l on l.locationID = rr.locationID JOIN RestroomsEmployees re on re.restroomID = rr.restroomID ORDER BY 1 asc;"
            results = execute_query(db_connection, query).fetchall()
            return render_template('/employee_index.html', results=results)
        # otherwise, use category for WHERE clause filtering on search text   
        search = request.form['search']
        category = request.form['restroomSearch']
        
        if category == 'restroomID':
            query = "SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID FROM Restrooms rr  JOIN Locations l on l.locationID = rr.locationID JOIN RestroomsEmployees re on re.restroomID = rr.restroomID WHERE rr.restroomID = " + search + "  ORDER BY 1 asc;"
            #data = (search)
            results = execute_query(db_connection, query).fetchall()
            return render_template('employee_index.html', results=results) 

        if category == 'street':
            query = "SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID FROM Restrooms rr  JOIN Locations l on l.locationID = rr.locationID JOIN RestroomsEmployees re on re.restroomID = rr.restroomID WHERE l.street like '" + search + "' ORDER BY 1 asc;"
            print(query)
            #data = (search)
            results = execute_query(db_connection, query).fetchall()
            return render_template('employee_index.html', results=results)

        if category == 'city':
            query = "SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID FROM Restrooms rr  JOIN Locations l on l.locationID = rr.locationID JOIN RestroomsEmployees re on re.restroomID = rr.restroomID WHERE l.city like '" + search + "' ORDER BY 1 asc;"
            #data = (search)
            results = execute_query(db_connection, query).fetchall()
            return render_template('employee_index.html', results=results)

        if category == 'state':
            query = "SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID FROM Restrooms rr  JOIN Locations l on l.locationID = rr.locationID JOIN RestroomsEmployees re on re.restroomID = rr.restroomID WHERE l.state like '" + search + "' ORDER BY 1 asc;"
            #data = (search)
            results = execute_query(db_connection, query).fetchall()
            return render_template('employee_index.html', results=results)

        if category == 'country':
            query = "SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID FROM Restrooms rr  JOIN Locations l on l.locationID = rr.locationID JOIN RestroomsEmployees re on re.restroomID = rr.restroomID WHERE l.country like '" + search + "'  ORDER BY 1 asc;"
            #data = (search)
            results = execute_query(db_connection, query).fetchall()
            return render_template('employee_index.html', results=results)

    # GET request returns all rows of Restrooms
    db_connection = connect_to_database()
    query = "SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address,rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID FROM Restrooms rr JOIN Locations l on l.locationID = rr.locationID JOIN RestroomsEmployees re on re.restroomID = rr.restroomID ORDER BY 1 asc;"
    results = execute_query(db_connection, query).fetchall()
    return render_template('employee_index.html', results=results)

@app.route('/employee_add', methods=['GET','POST'])
def emp_add():
    '''Employee add page. If a GET request, then simply return the page to the user. If the page is reached via an HTTP POST, then collect the data provided and INSERT the new Restroom and appropriate data.'''
    db_connection = connect_to_database()

    if request.method == 'POST':
        open_hour = request.form["openTime"]
        close_hour = request.form["closeTime"]
        free = request.form["free"]
        comments = request.form["comments"]
        if request.form["address2"] != '':
            street = request.form["address"] + ' ' + request.form["address2"]
        else:
            street = request.form["address"]
        city = request.form["city"]
        state = request.form["state"]
        country = request.form["country"]
        first_name = request.form["firstName"]
        last_name = request.form["lastName"]
        email = request.form["email"]
        # Need to insert into Locations first
        query = 'INSERT INTO Locations (street, city, state, country) VALUES (%s, %s, %s, %s)'
        data = (street, city, state, country)
        execute_query(db_connection, query, data)
        
        # Next insert into Restrooms
        query = 'INSERT INTO Restrooms (locationID, openHour, closeHour, free) VALUES ((SELECT locationID FROM Locations WHERE street = %s AND city = %s AND state = %s AND country = %s), %s, %s, %s)'
        data = (street, city, state, country, open_hour, close_hour, free)
        execute_query(db_connection, query, data)
    
        # Finally insert into RestroomsEmployees
        query = 'INSERT INTO RestroomsEmployees (restroomID, employeeID, comments, inspectedAt) VALUES ((SELECT max(restroomID) FROM Restrooms), (SELECT employeeID FROM Employees where firstName = %s AND lastName = %s AND emailAddress = %s), %s, CURRENT_TIMESTAMP())'
        data = (first_name, last_name, email, comments)
        execute_query(db_connection, query,data)    

        return redirect('/employee_index', code=302)
    else:
        return render_template('/employee_add.html')

@app.route('/customer_login')
def cust_login():
    '''Login page for customers'''
    print('Accessing the login portal for customers') 
    return render_template('customer_login.html')   

@app.route('/customer_index', methods=['GET', 'POST'])
def cust_index():
    '''Customer landing page, displays data from reviews database table '''
    print('Accessing the customer_index landing page')
    
    if request.method == 'POST':
        print('POST received.')
        print()
        print('SEARCH: ' + request.form['search'])
        print('CATEGORY: ' + request.form['restroomSearch'])
        print()
        db_connection = connect_to_database()
	    # if request.form['search'] is empty, return all
        if request.form['search'] == '':
            query = "SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID FROM Restrooms rr JOIN Locations l ON l.locationID = rr.locationID JOIN Reviews rv ON rv.restroomID = rr.restroomID "
            results = execute_query(db_connection, query).fetchall()
            # print("blank search field")
            return render_template('/customer_index.html', results=results)
        # otherwise, use category for WHERE clause filtering on search text   
        search = request.form['search']
        category = request.form['restroomSearch']
        
        if category == 'reviewID':
            query = "SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID FROM Restrooms rr JOIN Locations l ON l.locationID = rr.locationID JOIN Reviews rv ON rv.restroomID = rr.restroomID WHERE rv.reviewID = " + search;
            results = execute_query(db_connection, query).fetchall()
            return render_template('customer_index.html', results=results) 

        if category == 'restroomID':
            query = "SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID FROM Restrooms rr JOIN Locations l ON l.locationID = rr.locationID JOIN Reviews rv ON rv.restroomID = rr.restroomID WHERE rr.restroomID = " + search;
            # print(query)
            #data = (search)
            results = execute_query(db_connection, query).fetchall()
            return render_template('customer_index.html', results=results)

        if category == 'userID':
            query = "SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID FROM Restrooms rr JOIN Locations l ON l.locationID = rr.locationID JOIN Reviews rv ON rv.restroomID = rr.restroomID WHERE rv.userID = " + search;
            #data = (search)
            results = execute_query(db_connection, query).fetchall()
            return render_template('customer_index.html', results=results)

        if category == 'cleanliness':
            query = "SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID FROM Restrooms rr JOIN Locations l ON l.locationID = rr.locationID JOIN Reviews rv ON rv.restroomID = rr.restroomID WHERE rv.cleanliness = '" + search + "';"
            #data = (search)
            results = execute_query(db_connection, query).fetchall()
            # print(results)
            return render_template('customer_index.html', results=results)

    db_connection = connect_to_database()
    query = "SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID FROM Restrooms rr JOIN Locations l ON l.locationID = rr.locationID JOIN Reviews rv ON rv.restroomID = rr.restroomID "
    results = execute_query(db_connection, query).fetchall()
    # print(results)
    return render_template('customer_index.html', results=results)

@app.route('/customer_add', methods=['GET','POST'])
def cust_add():
    '''Customer add page. If GET request, returns the page to the user, if POST request, collect data from form and INSERT to database '''
    db_connection = connect_to_database()
    if request.method == 'POST':
        print('Customer-add.html POST request')
        restroom_id = request.form["restroomID"]
        overall_rating = request.form["overallRating"]
        cleanliness = request.form["cleanliness"]
        comments = request.form["comments"]
        print("restroomID =", restroom_id)
        print("overallRating =", overall_rating)
        print("cleanliness =", cleanliness)
        print("comments =", comments)

        query = 'INSERT INTO Reviews (overallRating, cleanliness, comment, createdAt, restroomID, userID) VALUES (%s, %s, %s, CURDATE(), %s, 1)'
        data =(overall_rating, cleanliness, comments, restroom_id)
        execute_query(db_connection, query, data)
        # return render_template('customer_add.html')
        return render_template('customer_add_confirm.html')
    else:
        print('Customer_add.html GET request')
        query = "SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address FROM Restrooms rr JOIN Locations l ON l.locationID = rr.locationID "
        results = execute_query(db_connection, query).fetchall()
        # print(results)
        return render_template('customer_add.html', results=results)

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 56124)) 
    app.run(port=port)

    

