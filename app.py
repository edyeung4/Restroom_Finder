from flask import Flask, render_template, request, redirect
import database.db_connector as db
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

    return render_template('employee_index.html')



# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 56124)) 
    app.run(port=port) 
