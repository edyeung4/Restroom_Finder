from flask import Flask, render_template, request, redirect
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

@app.route('/employee_index')
def emp_index():
    '''Employee login landing page. Displays data from Restrooms, RestroomEmployees,
    and Locations'''
    print('Accessing the employee_index landing page.')
    db_connection = connect_to_database()
    query = "SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address,rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID FROM Restrooms rr JOIN Locations l on l.locationID = rr.locationID JOIN RestroomsEmployees re on re.restroomID = rr.restroomID ORDER BY 1 asc;"
    results = execute_query(db_connection, query).fetchall()
    print(results)
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

@app.route('/customer_index')
def cust_index():
    '''Customer landing page, displays data from reviews database table '''
    print('Accessing the customer_index landing page')
    db_connection = connect_to_database()
    query = "SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID FROM Restrooms rr JOIN Locations l ON l.locationID = rr.locationID JOIN Reviews rv ON rv.restroomID = rr.restroomID "
    results = execute_query(db_connection, query).fetchall()
    print(results)
    return render_template('customer_index.html', results=results)

@app.route('/customer_add', methods=['GET','POST'])
def cust_add():
    '''Customer add page. If GET request, returns the page to the user, if POST request, collect data from form and INSERT to database '''
    if request.method == 'POST':
        pass
    return render_template('customer_add.html')

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 56124)) 
    app.run(port=port)

    

