-- Query for add a new character functionality with colon : character being used to
-- denote the variables that will have data from the backend programming language
-- INSERT INTO bsg_people (fname, lname, homeworld, age)
-- VALUES (:fnameInput, :lnameInput, :homeworld_id_from_dropdown_Input, :ageInput);

-- Query for login functionality. First use SELECT query to see if employee exists.
-- If employee does not exist, then insert into Employees table
-- $ used for variable placeholder of data processed by backend
SELECT id
FROM Employees
WHERE firstName = $firstName
    AND lastName = $lastName
    AND emailAddress = $emailAddress

-- IF above query returns null...
INSERT INTO Employees (firstName, lastName, emailAddress) 
    VALUES ($firstname, $lastName, $emailAddress)

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
    JOIN RestroomsEmployees re on re.restroomID = rr.restroomID
ORDER BY 1 asc;
-- Filtering restrooms based on ID
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address,
    rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID
FROM Restrooms rr
    JOIN Locations l on l.locationID = rr.locationID
    JOIN RestroomsEmployees re on re.restroomID = rr.restroomID
WHERE rr.restroomID = $restroomID
-- Filtering restrooms based on Street
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address,
    rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID
FROM Restrooms rr
    JOIN Locations l on l.locationID = rr.locationID
    JOIN RestroomsEmployees re on re.restroomID = rr.restroomID
WHERE l.street = $Street
-- Filtering restrooms based on City
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address,
    rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID
FROM Restrooms rr
    JOIN Locations l on l.locationID = -rr.locationID
    JOIN RestroomsEmployees re on re.restroomID = rr.restroomID
WHERE l.city = $City
-- Filtering restrooms based on State
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address,
    rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID
FROM Restrooms rr
    JOIN Locations l on l.locationID = rr.locationID
    JOIN RestroomsEmployees re on re.restroomID = rr.restroomID
WHERE l.state = $State
-- Filtering restrooms based on Country
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address,
    rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID
FROM Restrooms rr
    JOIN Locations l on l.locationID = rr.locationID
    JOIN RestroomsEmployees re on re.restroomID = rr.restroomID
WHERE l.country = $Country
-- Filtering restrooms based on Free
SELECT rr.restroomID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address,
    rr.openHour, rr.closeHour, rr.free, re.inspectedAt, re.comments, re.employeeID
FROM Restrooms rr
    JOIN Locations l on l.locationID = rr.locationID
    JOIN RestroomsEmployees re on re.restroomID = rr.restroomID
WHERE rr.free = $Free 


-- Query to delete Restrooms from the employee_index.html page
-- $ used for variable placeholder of data processed by backend
DELETE FROM Restrooms
WHERE restroomID = $restroomID

-- Query to update Restrooms from the employee_index.html page
-- $ used for variable placeholder of data processed by backend
UPDATE Locations, Restrooms, RestroomsEmployees
SET Locations.street = $Street,
    Locations.city = $City,
    Locations.state = $State,
    Locations.country = $Country,
    Restrooms.openHour = $OpenHour,
    Restrooms.closeHour = $CloseHour,
    Restrooms.free = $Free,
    RestroomsEmployees.updatedAt = $Updated,
    RestroomsEmployees.employeeID = $EmployeeID 
WHERE Restrooms.restroomID = $RestroomID 


-- Query to add new Locations, Restrooms from the employee_index.html page
-- $ used for variable placeholder of data processed by backend
INSERT INTO Locations (street, city, state, country)
VALUES ($street, $city, $state, $country);
INSERT INTO Restrooms (locationID, openHour, closeHour, free)
VALUES ((SELECT locationID FROM Locations WHERE street = $street
    AND city = $city AND state = $state AND country = $country),
    openHour = $openHour, closeHour = $closeHour, free = $free);
INSERT INTO RestroomsEmployees (restroomID, employeeID, comments, inspectedAt)
VALUES ((SELECT restroomID FROM Restrooms JOIN Locations ON Locations.locationID = Restrooms.locationID
    WHERE Locations.street = $street AND Locations.city = $city AND Location.state = $state AND 
        Location.country = $country), employeeID = $employeeID, comments = $comments, inspectedAt = CURDATE());


-- Get all reviews table data to populate "view tab" (customer_index.html)
SELECT rv.reviewID, concat(l.street, ', ', l.city, ', ', l.state, ', ', l.country ) as Address, 
    rv.overallRating, rv.cleanliness, rv.comment, rv.createdAt, rv.restroomID, rv.userID
FROM Restrooms rr
    JOIN Locations l ON l.locationID = rr.locationID
    JOIN Reviews rv ON rv.restroomID = rr.restroomID   
 
-- Customer_index.html Delete functionality 
DELETE FROM reviews Where reviewID = $ID_selected_from_customer_index_page
 
-- Customer_index.html Update functionality
UPDATE reviews SET overallRating = $ratingInput, cleanliness = $cleanlinessInput, 
comment = $commentInput
WHERE reviewID = $ID_selected_from_customer_index_page
 
  
-- Customer_index.html Search functionality based on search category
-- Filtering based on reviewID
SELECT reviewID, overallRating, cleanliness, comment, createdAt, restroomID, userID
FROM reviews
WHERE reviewID = $review_ID_from_customer_index_search
 
-- Filtering based on restroomID
SELECT reviewID, overallRating, cleanliness, comment, createdAt, restroomID, userID
FROM reviews
WHERE restroomID = $restroom_ID_from_customer_index_search
 
-- Filtering based on userID
SELECT reviewID, overallRating, cleanliness, comment, createdAt, restroomID, userID
FROM reviews
WHERE userID = $restroom_ID_from_customer_index_search
 
-- Filtering based on cleanliness
SELECT reviewID, overallRating, cleanliness, comment, createdAt, restroomID, userID
FROM reviews
WHERE cleanliness = $cleanliness_from_customer_index_search
 
-- Customer_add.html Submit Review functionality
INSERT INTO reviews (overallRating, cleanliness, comment, createdAt)
VALUES ($ratingInput, $cleanlinessInput, $commentInput, CURDATE());

