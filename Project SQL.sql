Create database RMS;
Use RMS;

-- Create Office Table--
CREATE TABLE Office (
    office_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(60)  NOT NULL,
    phone VARCHAR(20),
    opened_date DATE
);
INSERT INTO Office (office_id, name, city, phone, opened_date) VALUES
(1,'Downtown HQ','Mumbai','022‑4001‑1100','2015-03-01'),
(2,'Andheri Branch','Mumbai','022‑4012‑2200','2018-07-15'),
(3,'Pune Central','Pune','020‑3000‑0101','2019-11-05'),
(4,'Bengaluru North','Bengaluru','080‑4500‑5500','2020-02-20'),
(5,'Hyderabad Hub','Hyderabad','040‑2550‑9898','2021-08-12'),
(6,'Chennai Coast','Chennai','044‑3311‑4411','2022-01-09'),
(7,'Kolkata Heights','Kolkata','033‑6600‑7700','2023-05-03'),
(8,'Delhi NCR','Delhi','011‑7700‑8800','2017-10-25'),
(9,'Jaipur Pink','Jaipur','0141‑2200‑3300','2024-06-18'),
(10,'Ahmedabad West','Ahmedabad','079‑2900‑4500','2024-02-14'),
(11,'Surat City','Surat',NULL,'2024-09-01'),
(12,'Nagpur Central','Nagpur','0712‑2400‑550',NULL);

-- Create Properties Table--
CREATE TABLE Properties (
    property_id    INT AUTO_INCREMENT PRIMARY KEY,
    office_id      INT NOT NULL,
    address        VARCHAR(150) NOT NULL,
    city           VARCHAR(60)  NOT NULL,
    type           ENUM('House','Apartment','Office','Land') NOT NULL,
    bedrooms       TINYINT CHECK (bedrooms >= 0),
    FOREIGN KEY (office_id) REFERENCES Office(office_id)
);
INSERT INTO Properties (property_id, office_id, address, city, type, bedrooms) VALUES
(101,1,'11 Marine Dr','Mumbai','Apartment',2),
(102,1,'22 Apex Tower','Mumbai','Office',NULL),
(103,2,'18/4 Veera Desai Rd','Mumbai','Apartment',1),
(104,3,'5 Koregaon Park','Pune','House',3),
(105,3,'9 Hinjewadi Phase 1','Pune','Office',NULL),
(106,4,'77 Bellandur Lake','Bengaluru','Apartment',2),
(107,4,'46 Whitefield Main','Bengaluru','House',4),
(108,5,'3 Jubilee Hills','Hyderabad','House',3),
(109,6,'12 Besant Nagar','Chennai','Apartment',2),
(110,8,'66 Dwarka Sec‑19','Delhi','Apartment',3),
(111,9,'101 C‑Scheme','Jaipur','House',3),
(112,10,'55 SG Highway','Ahmedabad','Office',NULL);

-- Create Tenant Table--
CREATE TABLE Tenant (
    tenant_id      INT AUTO_INCREMENT PRIMARY KEY,
    full_name      VARCHAR(100) NOT NULL,
    phone          VARCHAR(20),
    email          VARCHAR(100),
    registered_on  DATE
);
INSERT INTO Tenant (tenant_id, full_name, phone, email, registered_on) VALUES
(201,'Rohan Mehta','90011‑11111','rohan@example.com','2023-01-10'),
(202,'Sara Iyer','90022‑22222','sara@example.com','2023-02-12'),
(203,'Akash Gupta','90033‑33333','akash@example.com','2023-02-25'),
(204,'Neha Sharma','90044‑44444','neha@example.com','2023-03-05'),
(205,'Priya Nair','90055‑55555','priya@example.com',NULL),
(206,'Vikram Patel','90066‑66666','vikram@example.com','2023-04-18'),
(207,'Aisha Khan','90077‑77777','aisha@example.com','2023-05-20'),
(208,'Rahul Das','90088‑88888','rahul@example.com','2023-06-01'),
(209,'Kunal Joshi','90099‑99999','kunal@example.com','2023-06-15'),
(210,'Meera Rao','90100‑00001','meera@example.com','2023-07-10'),
(211,'Anil Babu','90111‑11110','anil@example.com','2023-08-04'),
(212,'Divya Sen','90122‑22220','divya@example.com',NULL);

-- Create Leases Table--
CREATE TABLE Leases (
    lease_id       INT AUTO_INCREMENT PRIMARY KEY,
    property_id    INT  NOT NULL,
    tenant_id      INT  NOT NULL,
    start_date     DATE NOT NULL,
    end_date       DATE,
    monthly_rent   DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (tenant_id)   REFERENCES Tenant(tenant_id)
);
INSERT INTO Leases (lease_id, property_id, tenant_id, start_date, end_date, monthly_rent) VALUES
(301,101,201,'2023-02-01','2024-01-31',45000.00),
(302,103,202,'2023-03-15','2024-03-14',32000.00),
(303,104,203,'2023-04-01','2024-03-31',55000.00),
(304,105,204,'2023-05-10','2024-05-09',80000.00),
(305,106,205,'2023-06-01','2024-05-31',40000.00),
(306,107,206,'2023-06-20','2024-06-19',60000.00),
(307,108,207,'2023-07-05','2024-07-04',65000.00),
(308,109,208,'2023-08-01','2024-07-31',38000.00),
(309,110,209,'2023-09-01','2025-08-31',70000.00),
(310,111,210,'2023-09-15','2024-09-14',47000.00),
(311,112,211,'2023-10-01',NULL,90000.00),
(312,102,212,'2023-11-01','2024-10-31',120000.00);

-- Create Payment Table--
CREATE TABLE Payment (
    payment_id     INT AUTO_INCREMENT PRIMARY KEY,
    lease_id       INT  NOT NULL,
    paid_on        DATE NOT NULL,
    amount         DECIMAL(10,2) NOT NULL,
    method         ENUM('Cash','Card','Bank‑Transfer','UPI'),
    FOREIGN KEY (lease_id) REFERENCES Leases(lease_id)
);
INSERT INTO Payment (payment_id, lease_id, paid_on, amount, method) VALUES
(401,301,'2023-02-05',45000.00,'Bank‑Transfer'),
(402,301,'2023-03-05',45000.00,'UPI'),
(403,302,'2023-03-18',32000.00,'Cash'),
(404,303,'2023-04-03',55000.00,'Card'),
(405,304,'2023-05-12',80000.00,'Bank‑Transfer'),
(406,305,'2023-06-03',40000.00,'UPI'),
(407,306,'2023-06-22',60000.00,'Cash'),
(408,307,'2023-07-07',65000.00,'Card'),
(409,308,'2023-08-03',38000.00,'UPI'),
(410,309,'2023-09-03',70000.00,'Bank‑Transfer'),
(411,310,'2023-09-18',47000.00,'Cash'),
(412,311,'2023-10-04',90000.00,'Card');

-- Create Service Table--
CREATE TABLE Service (
    service_id     INT AUTO_INCREMENT PRIMARY KEY,
    property_id    INT  NOT NULL,
    requested_on   DATE NOT NULL,
    description    VARCHAR(200),
    cost_estimate  DECIMAL(10,2),
    status         ENUM('Open','In‑Progress','Closed') DEFAULT 'Open',
    FOREIGN KEY (property_id) REFERENCES Properties(property_id)
);
INSERT INTO Service (service_id, property_id, requested_on, description, cost_estimate, status) VALUES
(501,101,'2023-02-10','Plumbing leak',1500.00,'Closed'),
(502,103,'2023-04-01','AC servicing',2500.00,'Closed'),
(503,104,'2023-04-15','Roof repair',12000.00,'In‑Progress'),
(504,106,'2023-06-05','Painting',8000.00,'Open'),
(505,107,'2023-06-25','Garden maintenance',4000.00,'In‑Progress'),
(506,108,'2023-07-10','Termite treatment',7000.00,'Closed'),
(507,109,'2023-08-08','Electrical wiring',5000.00,'Open'),
(508,110,'2023-09-05','Elevator inspection',6000.00,'Closed'),
(509,111,'2023-09-20','Waterproofing',11000.00,'Open'),
(510,112,'2023-10-10','Fire safety audit',9000.00,'In‑Progress'),
(511,105,'2023-05-20','Server room AC',15000.00,'Closed'),
(512,102,'2023-12-01','Lobby renovation',30000.00,'Open');

-- Create RentalHistory Table--
CREATE TABLE RentalHistory (
    history_id     INT AUTO_INCREMENT PRIMARY KEY,
    tenant_id      INT NOT NULL,
    property_id    INT NOT NULL,
    lease_start    DATE NOT NULL,
    lease_end      DATE,
    rating         TINYINT CHECK (rating BETWEEN 1 AND 5),
    FOREIGN KEY (tenant_id)   REFERENCES Tenant(tenant_id),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id)
);
INSERT INTO RentalHistory (history_id, tenant_id, property_id, lease_start, lease_end, rating) VALUES
(601,201,101,'2021-02-01','2022-01-31',5),
(602,202,103,'2022-03-15','2023-03-14',4),
(603,203,104,'2022-04-01','2023-03-31',5),
(604,204,105,'2022-05-10','2023-05-09',4),
(605,205,106,'2022-06-01','2023-05-31',3),
(606,206,107,'2022-06-20','2023-06-19',5),
(607,207,108,'2022-07-05','2023-07-04',4),
(608,208,109,'2022-08-01','2023-07-31',4),
(609,209,110,'2021-09-01','2023-08-31',5),
(610,210,111,'2022-09-15','2023-09-14',4),
(611,211,112,'2021-10-01','2023-09-30',3),
(612,212,102,'2022-11-01','2023-10-31',4);


Select * from Office;
Select * from Properties;
Select * from Tenant;
Select * from Leases;
Select * from Payment;
Select * from Service;
Select * from RentalHistory;


Find List all offices in Mumbai.

Select * from office where city ='mumbai'
----------------------------------------------
Find the total number of properties listed in each city.

Select city, count(*) AS Total_Properties from properties GROUP BY city;
----------------------------------------------
Update the phone number of the 'Chennai Coast' office.

Update office SET phone ='044‑3311‑4411' where name = 'Chennai coast';
----------------------------------------------
Find the highest monthly rent paid for a property in 'Hyderabad'.

SELECT MAX(monthly_rent) AS highest_rent FROM Leases l
JOIN Properties p ON l.property_id = p.property_id
WHERE p.city = 'Hyderabad';

----------------------------------------------
Find the Total Rent Collected by Each Office.

SELECT o.name AS office_name,
SUM(p.amount) AS total_rent_collected
FROM Office o
JOIN Properties pr ON o.office_id = pr.office_id
JOIN Leases l ON pr.property_id = l.property_id
JOIN Payment p ON l.lease_id = p.lease_id
GROUP BY o.name;
----------------------------------------------
List Tenants Who Have Not Made Any Payments.

SELECT t.full_name
FROM Tenant t
LEFT JOIN Leases l ON t.tenant_id = l.tenant_id
LEFT JOIN Payment p ON l.lease_id = p.lease_id
WHERE p.payment_id IS NULL;
----------------------------------------------
Calculate the Average Rating for Each Property.

SELECT pr.address,
AVG(r.rating) AS average_rating
FROM Properties pr
JOIN RentalHistory r ON pr.property_id = r.property_id
GROUP BY pr.address;
----------------------------------------------
Find Properties with Pending Service Requests.

SELECT pr.address
FROM Properties pr
JOIN Service s ON pr.property_id = s.property_id
WHERE s.status = 'Open';
----------------------------------------------
Get the Most Recent Payment for Each Lease.

SELECT p.lease_id,
       p.paid_on,
       p.amount,
       p.method
FROM Payment p
JOIN (
    SELECT lease_id, MAX(paid_on) AS latest_payment
    FROM Payment
    GROUP BY lease_id
) latest ON p.lease_id = latest.lease_id AND p.paid_on = latest.latest_payment;
----------------------------------------------
List All Tenants Who Have Leased Properties with More Than 2 Bedrooms.

SELECT t.full_name
FROM Tenant t
JOIN Leases l ON t.tenant_id = l.tenant_id
JOIN Properties pr ON l.property_id = pr.property_id
WHERE pr.bedrooms > 2;
----------------------------------------------
Find the Office with the Highest Number of Properties.

SELECT o.name AS office_name,
       COUNT(pr.property_id) AS number_of_properties
FROM Office o
JOIN Properties pr ON o.office_id = pr.office_id
GROUP BY o.name
ORDER BY number_of_properties DESC
LIMIT 1;
----------------------------------------------
Calculate the Total Service Cost for Each Property.

SELECT pr.address,
       SUM(s.cost_estimate) AS total_service_cost
FROM Properties pr
JOIN Service s ON pr.property_id = s.property_id
GROUP BY pr.address;
----------------------------------------------
List Tenants Who Have Leased Properties in the Same City.

SELECT t.full_name
FROM Tenant t
JOIN Leases l ON t.tenant_id = l.tenant_id
JOIN Properties pr ON l.property_id = pr.property_id
GROUP BY t.tenant_id
HAVING COUNT(DISTINCT pr.city) = 1;
----------------------------------------------




