-- Query for add a new character functionality with colon : character being used to
-- denote the variables that will have data from the backend programming language
-- INSERT INTO bsg_people (fname, lname, homeworld, age)
-- VALUES (:fnameInput, :lnameInput, :homeworld_id_from_dropdown_Input, :ageInput);

-- Query for login functionality. First use SELECT query to see if employee exists.
-- If employee does not exist, then insert into Employees table
-- If employee does exist, update last login
INSERT INTO Employees (firstName, lastName, emailAddress) 
    VALUES ($firstname, $lastName, $emailAddress)

UPDATE Employees SET lastLogin = current_timestamp() 
    WHERE employeeID = 
    (SELECT employeeID FROM Employees WHERE firstName = %s AND lastName = %s AND emailAddress = %s)

-- Query for login functionality. First use SELECT query to see if user exists.
-- If user does not exist, then insert into Users table
-- $ used for variable placeholder of data processed by backend
SELECT id
FROM Users
WHERE firstName = $firstName
    AND lastName = $lastName
    AND emailAddress = $emailAddress

INSERT INTO Users (firstName, lastName, emailAddress) VALUES
    ($firstname, $lastName, $emailAddress)

-- Query to view Restrooms based on provided search category
-- $ used for variable placeholder of data processed by backend
-- Initial view of employee_index.html after logging in
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address,
    rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID 
FROM Restrooms rr 
JOIN Locations l on l.locationID = rr.locationID 
JOIN RestroomsEmployees re on re.restroomID = rr.restroomID ORDER BY 1 asc;

-- Filtering restrooms based on ID
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, 
    rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID 
FROM Restrooms rr  
JOIN Locations l on l.locationID = rr.locationID 
JOIN RestroomsEmployees re on re.restroomID = rr.restroomID 
WHERE rr.restroomID = " + search + "  
ORDER BY 1 asc;

-- Filtering restrooms based on Street
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, 
    rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID 
FROM Restrooms rr 
JOIN Locations l on l.locationID = rr.locationID 
JOIN RestroomsEmployees re on re.restroomID = rr.restroomID 
WHERE l.street like '" + search + "' 
ORDER BY 1 asc;

-- Filtering restrooms based on City
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, 
    rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID 
FROM Restrooms rr  
JOIN Locations l on l.locationID = rr.locationID 
JOIN RestroomsEmployees re on re.restroomID = rr.restroomID 
WHERE l.city like '" + search + "' 
ORDER BY 1 asc;

-- Filtering restrooms based on State
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, 
rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID 
FROM Restrooms rr  
JOIN Locations l on l.locationID = rr.locationID 
JOIN RestroomsEmployees re on re.restroomID = rr.restroomID 
WHERE l.state like '" + search + "' 
ORDER BY 1 asc;

-- Filtering restrooms based on Country
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, 
rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID 
FROM Restrooms rr  JOIN Locations l on l.locationID = rr.locationID 
JOIN RestroomsEmployees re on re.restroomID = rr.restroomID 
WHERE l.country like '" + search + "'  
ORDER BY 1 asc;


-- Query to delete Restrooms from the employee_index.html page
-- $ used for variable placeholder of data processed by backend
DELETE FROM Restrooms WHERE restroomID = %s

-- Query to update Restrooms from the employee_index.html page
-- $ used for variable placeholder of data processed by backend
UPDATE Locations, Restrooms, RestroomsEmployees 
SET Locations.street = %s, Locations.city = %s, Locations.state = %s, 
    Locations.country = %s, Restrooms.openHour = %s, Restrooms.closeHour = %s, 
    Restrooms.free = %s, RestroomsEmployees.inspectedAt = %s, RestroomsEmployees.comments = %s 
WHERE Restrooms.restroomID = %s AND Locations.locationID = 
    (SELECT locationID FROM Restrooms WHERE restroomID = %s) AND RestroomsEmployees.restroomID = %s


-- Query to add new Locations, Restrooms from the employee_index.html page
-- $ used for variable placeholder of data processed by backend
INSERT INTO Locations (street, city, state, country) VALUES (%s, %s, %s, %s)

INSERT INTO Restrooms (locationID, openHour, closeHour, free) VALUES 
    ((SELECT locationID FROM Locations WHERE street = %s AND city = %s AND state = %s AND country = %s), %s, %s, %s)

INSERT INTO RestroomsEmployees (restroomID, employeeID, comments, inspectedAt) VALUES 
    ((SELECT max(restroomID) FROM Restrooms), (SELECT employeeID FROM Employees ORDER BY lastLogin DESC LIMIT 1), %s, CURRENT_TIMESTAMP())


-- Get all reviews table data to populate "view tab" (customer_index.html)
SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, 
    v.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID 
FROM Restrooms rr 
JOIN Locations l ON l.locationID = rr.locationID 
JOIN Reviews rv ON rv.restroomID = rr.restroomID 
 
-- Get Restroom ID, location as selectable reviews that have not been reviewed for customer_add.html
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address
FROM Restrooms rr
    JOIN Locations l ON l.locationID = rr.locationID
    

--Filter reviews based on reviewID
SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, 
    rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID 
FROM Restrooms rr 
JOIN Locations l ON l.locationID = rr.locationID 
JOIN Reviews rv ON rv.restroomID = rr.restroomID 
WHERE rv.reviewID = %s;

--Filter reviews based on restroomID
SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, 
    rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID 
FROM Restrooms rr 
JOIN Locations l ON l.locationID = rr.locationID 
JOIN Reviews rv ON rv.restroomID = rr.restroomID 
WHERE rr.restroomID = %s;

--Filter reviews based on userID
SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, 
    rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID 
FROM Restrooms rr 
JOIN Locations l ON l.locationID = rr.locationID 
JOIN Reviews rv ON rv.restroomID = rr.restroomID 
WHERE rv.userID = %s;

--Filter reviewed based on cleanliness
SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, 
    rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID 
FROM Restrooms rr 
JOIN Locations l ON l.locationID = rr.locationID 
JOIN Reviews rv ON rv.restroomID = rr.restroomID 
WHERE rv.cleanliness = %s;

-- Customer_index.html Delete functionality 
DELETE FROM Reviews WHERE reviewID = %s;
 
-- Customer_index.html Update functionality
UPDATE Reviews SET overallRating = %s, cleanliness = %s, comment = %s WHERE reviewID = %s
 
-- Customer_add.html Submit Review functionality
INSERT INTO Reviews (overallRating, cleanliness, comment, createdAt, restroomID, userID) 
VALUES (%s, %s, %s, CURDATE(), %s, 1)