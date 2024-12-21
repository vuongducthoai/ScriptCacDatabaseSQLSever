CREATE DATABASE ToChucSuKien

USE ToChucSuKien

CREATE TABLE Venue (
    VenueID INT PRIMARY KEY,
    VenueName VARCHAR(100) NOT NULL CHECK(VenueName <> ''),
    Location VARCHAR(100) NOT NULL CHECK(LOCATION <> ''),
    Capacity INT NOT NULL CHECK(Capacity > 0),
    Type VARCHAR(50) NOT NULL CHECK(Type <> '')
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(100) NOT NULL CHECK(EventName <> ''),
    EventDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    Description TEXT,
    VenueID INT NOT NULL,
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID)
);


CREATE TABLE Attendee (
    AttendeeID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL CHECK(FullName <> ''),
    Email VARCHAR(100) NOT NULL CHECK(Email LIKE '%@%'),
    Phone VARCHAR(15) NOT NULL CHECK (Phone LIKE '[0-9]+'),
    RegistrationDate DATE NOT NULL
);


CREATE TABLE Registration (
    RegistrationID INT PRIMARY KEY,
    EventID INT NOT NULL,
    AttendeeID INT NOT NULL,
    RegistrationDate DATE NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (AttendeeID) REFERENCES Attendee(AttendeeID)
);

CREATE TABLE EventPlanner (
    PlannerID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL CHECK(FullName <> ''),
    ContactNumber VARCHAR(15) NOT NULL CHECK(ContactNumber LIKE '[0-9]+'),
    Email VARCHAR(100) NOT NULL CHECK(Email LIKE '%@%')
);



CREATE TABLE Logistics (
    LogisticsID INT PRIMARY KEY,
    EventID INT NOT NULL,
    PlannerID INT NOT NULL,
    EquipmentDetails TEXT,
    TransportationDetails TEXT,
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (PlannerID) REFERENCES EventPlanner(PlannerID)
);

INSERT INTO Venue VALUES (1, 'Main Hall', 'Kuala Lumpur', 500, 'Auditorium');
INSERT INTO Venue VALUES (2, 'Conference Room', 'Kuala Lumpur', 200, 'Room');
INSERT INTO Venue VALUES (3, 'Exhibition Center', 'Kuala Lumpur', 1000, 'Exhibition');
INSERT INTO Venue VALUES (4, 'Meeting Room A', 'Kuala Lumpur', 50, 'Room');
INSERT INTO Venue VALUES (5, 'Garden Area', 'Kuala Lumpur', 300, 'Outdoor');




INSERT INTO Event VALUES (1, 'Tech Conference', '2024-11-05', '09:00', '17:00', 'Annual technology conference', 1);
INSERT INTO Event VALUES (2, 'Art Expo', '2024-11-12', '10:00', '18:00', 'Exhibition of local art', 3);
INSERT INTO Event VALUES (3, 'Business Seminar', '2024-11-20', '09:30', '16:00', 'Business networking seminar', 2);
INSERT INTO Event VALUES (4, 'Outdoor Festival', '2024-12-01', '11:00', '20:00', 'Annual outdoor music festival', 5);
INSERT INTO Event VALUES (5, 'Workshop on AI', '2024-12-15', '09:00', '12:00', 'Hands-on workshop on AI technologies', 4);


INSERT INTO Attendee VALUES (1, 'Alice Smith', 'alice@example.com', '0123456789', '2024-11-01');
INSERT INTO Attendee VALUES (2, 'Bob Johnson', 'bob@example.com', '0123456788', '2024-11-02');
INSERT INTO Attendee VALUES (3, 'Charlie Brown', 'charlie@example.com', '0123456787', '2024-11-03');
INSERT INTO Attendee VALUES (4, 'Diana Prince', 'diana@example.com', '0123456786', '2024-11-04');
INSERT INTO Attendee VALUES (5, 'Eve Adams', 'eve@example.com', '0123456785', '2024-11-05');


INSERT INTO Registration VALUES (1, 1, 1, '2024-11-01');
INSERT INTO Registration VALUES (2, 1, 2, '2024-11-02');
INSERT INTO Registration VALUES (3, 2, 3, '2024-11-03');
INSERT INTO Registration VALUES (4, 3, 4, '2024-11-04');
INSERT INTO Registration VALUES (5, 4, 5, '2024-12-01');



INSERT INTO EventPlanner VALUES (1, 'Sarah Connor', '0123456780', 'sarah@example.com');
INSERT INTO EventPlanner VALUES (2, 'John Doe', '0123456781', 'john@example.com');
INSERT INTO EventPlanner VALUES (3, 'Jane Doe', '0123456782', 'jane@example.com');
INSERT INTO EventPlanner VALUES (4, 'Tom Hanks', '0123456783', 'tom@example.com');
INSERT INTO EventPlanner VALUES (5, 'Emma Watson', '0123456784', 'emma@example.com');


INSERT INTO Logistics VALUES (1, 1, 1, 'Projector, Chairs', 'Van');
INSERT INTO Logistics VALUES (2, 2, 2, 'Tables, Microphone', 'Bus');
INSERT INTO Logistics VALUES (3, 3, 3, 'Laptop, Projector', 'Car');
INSERT INTO Logistics VALUES (4, 4, 4, 'Speakers, Stage', 'Truck');
INSERT INTO Logistics VALUES (5, 5, 5, 'Tents, Chairs', 'Van');


 -- Simple Query: Retrieve all events
SELECT * FROM Event;

-- Query for Sorting Results: Get all attendees sorted by registration date.
SELECT * FROM Attendee ORDER BY RegistrationDate;



-- Aggregate Function: Count the number of attendees registered for each event.
SELECT EventID, COUNT(AttendeeID) AS NumberOfAttendees
FROM Registration
GROUP BY EventID;


--Sub-query: Find all events with more than 3 attendees.
SELECT EventName FROM Event
WHERE EventID IN (
    SELECT EventID FROM Registration
    GROUP BY EventID
    HAVING COUNT(AttendeeID) > 1
);


-- Query to Alter Existing Tables: Add a column for the event location.

SELECT * FROM Event;
ALTER TABLE Event ADD  Location VARCHAR(100);
