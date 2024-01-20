select * from user;
select * from crop;
select * from feedback;
select * from order_table;
select * from supplies;

-- (simple query)
SELECT F_Name FROM user
WHERE F_Name LIKE 'J%';

SELECT Crop_Name, Available_Quantity
FROM CROP
WHERE Available_Quantity BETWEEN 10 AND 50;

-- Retrieve the orders placed between a specific date range. For example, orders placed between January 1, 2023, and March 31, 2023.
SELECT Order_ID, C_User_ID, Order_Date
FROM ORDER_TABLE
WHERE Order_Date BETWEEN '2021-10-31' AND '2022-04-29';
select * from order_table;


-- (aggregate)
-- Find the common tools supplied by different suppliers.(groupby)
SELECT Tools
FROM SUPPLIES
GROUP BY Tools
HAVING COUNT(DISTINCT Supplier_ID) > 1;


 -- Find the username of the customer who made the top 3 highest payment. (using joins)
SELECT u.F_Name, u.L_Name
FROM USER u
JOIN (
    SELECT C_User_ID
    FROM PAYMENT
    ORDER BY Amount DESC
    LIMIT 3
) p ON u.User_ID = p.C_User_ID;

-- Q: Retrieve the shipments along with the corresponding order details and the customer's first name for each shipment.
SELECT S.Tracking_ID, S.Destination_Address, S.City , S.Zip ,
       S.Estimated_Delivery, O.Order_ID, O.Order_Date,u.F_NAME
FROM SHIPMENT S
INNER JOIN ORDER_TABLE O ON S.Order_ID = O.Order_ID
INNER JOIN CUSTOMER C ON O.C_User_ID = C.C_User_ID
inner join user u on u.User_ID=c.C_User_ID;


-- Identify the crops with quantities greater than the average quantity.(nested query)
SELECT Crop_Name
FROM CROP
WHERE Available_Quantity > (SELECT AVG(Available_Quantity) FROM CROP);

-- find the total quantity of crops in the cart for each customer. Here's a correlated query for that:
SELECT C_User_ID,
       (SELECT SUM(Quantity)
        FROM CART c
        WHERE c.C_User_ID = Cu.C_User_ID) AS Total_Quantity_In_Cart
FROM CUSTOMER Cu;

-- List the unique crop names for which feedback exists.(exists)
SELECT DISTINCT c.Crop_Name
FROM CROP c
WHERE EXISTS (
    SELECT Crop_ID
    FROM FEEDBACK f
    WHERE f.Crop_ID = c.Crop_ID
);

-- union
SELECT City FROM FARMER UNION SELECT City FROM CUSTOMER;


-- Get the total quantity and the average price of crops for each farmer:
SELECT F.F_User_ID, F.Farm_Address, F.City, F.State, F.Zipcode,
       (SELECT SUM(C.Available_Quantity) FROM CROP C WHERE C.F_User_ID = F.F_User_ID) AS Total_Quantity,
       (SELECT AVG(C.Price) FROM CROP C WHERE C.F_User_ID = F.F_User_ID) AS Avg_Price
FROM FARMER F;









use project;
select * from cart;
select * from crop;
select * from crop_added_to_cart;
select * from customer;
select * from farmer;
select * from order_contains_crop;
select * from order_table;
alter table order_table
drop column Total_Price;
select * from payment;
select * from shipment;
select * from supplier;



