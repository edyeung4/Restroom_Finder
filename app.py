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
    if request.method == 'POST':
        pass
    return render_template('employee_add.html')

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

    

