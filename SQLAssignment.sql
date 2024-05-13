Select * from customers;

-- day 3 (1) ----------------------------------------------------------------------------------
select customerNumber, customerName,state,creditLimit from customers
Where state is not null 
And creditLimit >=50000 and creditLimit <= 100000 
order by creditLimit desc;

-- day 3 (2)
-- 
select productLine from productlines where productLine like '%Cars';
select productLine from productlines;
-- ---------------------------------------------------------------------------
-- Day 4 (1) ------------------------------------------------------
select orderNumber,
status, coalesce(comments, '-') as comments
from orders
where status = 'shipped';
-- ------------------------------------------------------------------------------
-- Day 4 (2) ---------------------------------------------------------------
select employeeNumber, firstName, jobTitle,
case 
	when jobTitle = "President" then 'P'
    when jobTitle in (
    'sales Manager (APAC)', 'Sales Manager (NA)', 'sale Manager (EMEA)'
    ) then 'SM'
    when jobTitle = "sales Rep" then 'SR'
    when instr(jobTitle, 'VP')>0 then 'VP'
    Else jobTitle
    end as JobTitle_abb
    from employees;
-- ------------------------------------------------------------------------
-- Day 5 (1)
select year(paymentDate) as `year`,
min(amount) from payments
group by `year`;
-- -------------------------------------------------------------------------
-- Day 5 (2)
   select * from orders; 
   SELECT
  YEAR(orderdate) AS Year,
  CASE
    WHEN MONTH(orderdate) BETWEEN 1 AND 3 THEN 'Q1'
    WHEN MONTH(orderdate) BETWEEN 4 AND 6 THEN 'Q2'
    WHEN MONTH(orderdate) BETWEEN 7 AND 9 THEN 'Q3'
    ELSE 'Q4'
  END AS Quarter,
  COUNT(DISTINCT customernumber) AS Unique_Customers,
  COUNT(*) AS Total_Orders
FROM orders
GROUP BY YEAR(orderdate), 
  CASE
    WHEN MONTH(orderdate) BETWEEN 1 AND 3 THEN 'Q1'
    WHEN MONTH(orderdate) BETWEEN 4 AND 6 THEN 'Q2'
    WHEN MONTH(orderdate) BETWEEN 7 AND 9 THEN 'Q3'
    ELSE 'Q4'
  END
ORDER BY YEAR(orderdate), 
  CASE
    WHEN MONTH(orderdate) BETWEEN 1 AND 3 THEN 'Q1'
    WHEN MONTH(orderdate) BETWEEN 4 AND 6 THEN 'Q2'
    WHEN MONTH(orderdate) BETWEEN 7 AND 9 THEN 'Q3'
    ELSE 'Q4'
  END;
  -- -------------------------------------------------------------
  -- Day 5 (3)
  select * from payments;
select 
date_format(paymentDate, '%b') as Months,
concat(format(sum(amount)/1000, 0), 'k') As formatted_Amount 
from payments
group by Months
having sum(amount) between 500000 And 1000000
order by sum(amount) desc;
-- -----------------------------------------------------------------
-- Day 6 (1)
create table journey (
Bus_id int not null,
Bus_Name varchar(20) not null,
Source_Station varchar(20) not null,
Destination varchar(20) not null,
Email varchar(20) unique 
);
desc journey;
-- -----------------------------------------------------------
-- Day 6 (2) 
create table vendor(
Vendor_ID int primary key,
`Name` varchar(20) not null,
Email varchar(20) unique,
Country varchar(20) default 'N/A'
);
 desc vendor;
 -- ---------------------------------------------------
 -- Day 6 (3)
 create table Movies(
 Movie_ID int primary key,
 `Name` varchar(20),
 Release_Year Varchar(20) default "-",
 Cast varchar(20) not null,
 Gender Enum('Male', 'Female'),
 No_of_Shows int check(No_of_shows > 0)
 );
 -- ---------------------------------------------------
 -- Day 6 (4)
 
 create table Suppliers (
Supplier_id int primary key,
Supplier_Name varchar(20),
Location varchar(20)
);


create table Product(
Product_id int primary key,
Product_Name varchar(20) not null unique,
Description varchar(50),
Supplier_id int, foreign key (Supplier_id)
references Suppliers(Supplier_id)
on update cascade
on delete cascade
);


create table stock (
Id int primary key,
Product_Id int, foreign key (Product_Id) 
References Product(Product_id)
on update cascade
on delete cascade,
Balance_Stock int
); 
desc suppliers;
desc product;
desc Stock;
-- ----------------------------------------------------------
-- Day 7 (1)

select employeeNumber, concat(FirstName,' ',lastName) as 'Sales_Person',
count(distinct customerNumber) as unique_customers 
from employees left join customers
on employeeNumber = salesRepEmployeeNumber
group by employeeNumber, 'sales_Person'
order by unique_customers desc;
-- -------------------------------------------------------------------
-- Day 7 (2)
select customers.customerNumber,
customers.customerName,
products.productCode,
products.productName,
sum(orderdetails.quantityOrdered) as 'order_Qty',
sum(products.quantityInstock) as 'total_Inventory',
sum(products.quantityInStock - orderdetails.quantityOrdered) as 'Left_qty'
from customers Inner Join Orders 
on customers.customerNumber = orders.customerNumber
Inner Join orderdetails
on orders.orderNumber = orderdetails.orderNumber
Inner Join products
on orderdetails.productCode = products.productCode
group by customers.customerNumber,
products.productCode 
order by customers.customerNumber asc;
-- ------------------------------------------------------------
-- Day 7 (3)
create table Laptop (
Laptop_Name varchar(20) not null );

Insert into Laptop values(
'HP'),('Dell');

create table color (
color_Name varchar(20) not null);

Insert into Color values 
('White'), ('Black'), ('Silver');

select * from Laptop cross join color
order by Laptop.laptop_name;
-- --------------------------------------------------------
-- Day 7 (4)
create table Project (
EmployeeId int primary key,
FullName varchar(20) not null,
Gender enum('Male', 'Female'),
MangaerID int 
);

INSERT INTO Project VALUES(1, 'Pranaya', 'Male', 3);
INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);

select P.FullName as M_Name, R.FullName as EMP_Name from
 Project as P join Project as R 
 on P.EmployeeID = R.MangaerId
 order by M_Name;
 -- ------------------------------------------------------------
 -- Day 8 (1) 
 create table Facility (
 Facility_ID int,
 F_Name varchar(20),
 state varchar(20),
 country varchar(20)
 );
 Alter table facility
 modify Facility_ID int primary key auto_increment;
 
 ALTER TABLE facility
 ADD COLUMN City VARCHAR(20) NOT NULL After F_Name;

desc facility;
-- ----------------------------------------------------------------------------
-- Day 9 
CREATE TABLE university (
id int, 
name varchar(50)
);
INSERT INTO University
VALUES (1, "       Pune          University     "), 
               (2, "  Mumbai          University     "),
              (3, "     Delhi   University     "),
              (4, "Madras University"),
              (5, "Nagpur University");

update university
set name = trim(both " " from regexp_replace(
name, ' {1,}', ' '))
where id is not null;

set sql_safe_updates = 0;

select * from university;
-- ---------------------------------------------------------------------------------
-- Day 10 






select * from orderdetails;
