



--  SECTION 1: SCHEMA DESIGN



CREATE DATABASE IF NOT EXISTS FreshMart;
USE FreshMart;


DROP TABLE IF EXISTS SalesTransactions;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;



CREATE TABLE Categories (
    CategoryID   INT           PRIMARY KEY,
    CategoryName VARCHAR(100)  NOT NULL,
    Description  VARCHAR(255)
);


CREATE TABLE Products (
    ProductID    INT             PRIMARY KEY,
    ProductName  VARCHAR(150)    NOT NULL,
    CategoryID   INT             NOT NULL,
    StockCount   INT             NOT NULL DEFAULT 0,
    CostPrice    DECIMAL(10,2)   NOT NULL,
    SellingPrice DECIMAL(10,2)   NOT NULL,
    ExpiryDate   DATE,                        
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);



CREATE TABLE SalesTransactions (
    TransactionID  INT             PRIMARY KEY,
    ProductID      INT             NOT NULL,
    QuantitySold   INT             NOT NULL,
    SaleDate       DATE            NOT NULL,
    TotalAmount    DECIMAL(10,2)   NOT NULL,    -- QuantitySold x SellingPrice
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

--  SECTION 2: DUMMY DATA


INSERT INTO Categories VALUES
(1, 'Fresh Produce',    'Fruits, vegetables, and salads'),
(2, 'Dairy & Eggs',     'Milk, cheese, butter, and eggs'),
(3, 'Bakery',           'Breads, cakes, and pastries'),
(4, 'Beverages',        'Juices, sodas, and water'),
(5, 'Snacks & Sweets',  'Chips, chocolates, and candy'),
(6, 'Frozen Foods',     'Frozen meals and ice cream'),
(7, 'Household',        'Cleaning and household supplies');


-- Products
-- Dead stock products (205, 303, 404, 504) have no rows in SalesTransactions.
INSERT INTO Products VALUES
-- Fresh Produce (expiring soon, high stock → appears in Report 1)
(101, 'Baby Spinach 200g',       1,  85,  1.20, 2.49, CURDATE() + INTERVAL 3 DAY),
(102, 'Strawberries 400g',       1, 120,  1.80, 3.99, CURDATE() + INTERVAL 5 DAY),
(103, 'Rocket Salad 100g',       1,  60,  0.90, 1.99, CURDATE() + INTERVAL 2 DAY),
(104, 'Cherry Tomatoes 250g',    1, 200,  1.10, 2.29, CURDATE() + INTERVAL 6 DAY),
-- Fresh Produce (expiring soon, LOW stock → does NOT appear in Report 1)
(105, 'Avocado 4-pack',          1,  30,  2.50, 4.99, CURDATE() + INTERVAL 4 DAY),
-- Fresh Produce (not expiring soon)
(106, 'Broccoli 500g',           1,  45,  0.80, 1.79, CURDATE() + INTERVAL 30 DAY),
(107, 'Carrots 1kg',             1,  90,  0.60, 1.29, CURDATE() + INTERVAL 45 DAY),

-- Dairy & Eggs
(201, 'Full-Fat Milk 2L',        2, 150,  1.40, 2.49, CURDATE() + INTERVAL 7 DAY),
(202, 'Cheddar Block 400g',      2,  80,  2.60, 4.29, CURDATE() + INTERVAL 60 DAY),
(203, 'Free-Range Eggs 12pk',    2,  95,  2.20, 3.79, CURDATE() + INTERVAL 21 DAY),
(204, 'Greek Yoghurt 500g',      2,  70,  1.30, 2.19, CURDATE() + INTERVAL 14 DAY),
-- Dead stock candidate (no sales at all)
(205, 'Oat Milk 1L',             2,  55,  1.50, 2.79, CURDATE() + INTERVAL 90 DAY),

-- Bakery
(301, 'Sourdough Loaf',          3,  40,  1.80, 3.49, CURDATE() + INTERVAL 3 DAY),
(302, 'Croissants 4pk',          3,  65,  2.00, 3.99, CURDATE() + INTERVAL 2 DAY),
-- Dead stock candidate
(303, 'Gluten-Free Bread',       3,  75,  2.40, 4.49, CURDATE() + INTERVAL 7 DAY),

-- Beverages
(401, 'Orange Juice 1L',         4, 200,  1.10, 2.29, CURDATE() + INTERVAL 180 DAY),
(402, 'Sparkling Water 6pk',     4, 180,  1.50, 2.99, NULL),
(403, 'Cola 2L',                 4, 220,  0.90, 1.89, NULL),
-- Dead stock candidate
(404, 'Coconut Water 330ml',     4,  90,  0.80, 1.79, CURDATE() + INTERVAL 120 DAY),

-- Snacks & Sweets
(501, 'Salted Crisps 150g',      5, 300,  0.70, 1.49, NULL),
(502, 'Milk Chocolate Bar 100g', 5, 250,  0.60, 1.29, CURDATE() + INTERVAL 365 DAY),
(503, 'Mixed Nuts 200g',         5, 100,  1.80, 3.49, CURDATE() + INTERVAL 180 DAY),
-- Dead stock candidate
(504, 'Rice Cakes 130g',         5,  80,  0.90, 1.79, CURDATE() + INTERVAL 150 DAY),

-- Frozen Foods
(601, 'Frozen Peas 1kg',         6, 120,  1.00, 1.99, CURDATE() + INTERVAL 365 DAY),
(602, 'Beef Lasagne 400g',       6,  70,  2.80, 4.99, CURDATE() + INTERVAL 180 DAY),

-- Household (non-perishable)
(701, 'Dishwasher Tablets 40pk', 7,  60,  3.50, 6.99, NULL),
(702, 'Laundry Powder 2kg',      7,  45,  4.00, 7.49, NULL);


-- SalesTransactions
-- Dead stock products (205, 303, 404, 504) have NO rows here intentionally.
INSERT INTO SalesTransactions VALUES
-- Baby Spinach (101)
(1001, 101, 12, CURDATE() - INTERVAL 5  DAY,  29.88),
(1002, 101,  8, CURDATE() - INTERVAL 12 DAY,  19.92),
(1003, 101, 20, CURDATE() - INTERVAL 25 DAY,  49.80),
-- Strawberries (102)
(1004, 102, 15, CURDATE() - INTERVAL 3  DAY,  59.85),
(1005, 102, 10, CURDATE() - INTERVAL 18 DAY,  39.90),
-- Rocket Salad (103)
(1006, 103, 25, CURDATE() - INTERVAL 7  DAY,  49.75),
(1007, 103, 18, CURDATE() - INTERVAL 40 DAY,  35.82),
-- Cherry Tomatoes (104)
(1008, 104, 30, CURDATE() - INTERVAL 2  DAY,  68.70),
(1009, 104, 22, CURDATE() - INTERVAL 30 DAY,  50.38),
-- Avocado (105)
(1010, 105, 10, CURDATE() - INTERVAL 10 DAY,  49.90),
-- Broccoli (106)
(1011, 106, 20, CURDATE() - INTERVAL 8  DAY,  35.80),
-- Carrots (107)
(1012, 107, 35, CURDATE() - INTERVAL 15 DAY,  45.15),
-- Full-Fat Milk (201)
(1013, 201, 40, CURDATE() - INTERVAL 1  DAY,  99.60),
(1014, 201, 38, CURDATE() - INTERVAL 8  DAY,  94.62),
(1015, 201, 45, CURDATE() - INTERVAL 35 DAY, 112.05),
-- Cheddar (202)
(1016, 202, 18, CURDATE() - INTERVAL 6  DAY,  77.22),
(1017, 202, 14, CURDATE() - INTERVAL 50 DAY,  60.06),
-- Eggs (203)
(1018, 203, 22, CURDATE() - INTERVAL 4  DAY,  83.38),
(1019, 203, 30, CURDATE() - INTERVAL 20 DAY, 113.70),
-- Greek Yoghurt (204)
(1020, 204, 16, CURDATE() - INTERVAL 9  DAY,  35.04),
-- Sourdough (301)
(1021, 301, 12, CURDATE() - INTERVAL 2  DAY,  41.88),
(1022, 301, 10, CURDATE() - INTERVAL 14 DAY,  34.90),
-- Croissants (302)
(1023, 302, 20, CURDATE() - INTERVAL 3  DAY,  79.80),
(1024, 302, 15, CURDATE() - INTERVAL 22 DAY,  59.85),
-- Orange Juice (401)
(1025, 401, 50, CURDATE() - INTERVAL 7  DAY, 114.50),
(1026, 401, 60, CURDATE() - INTERVAL 28 DAY, 137.40),
(1027, 401, 45, CURDATE() - INTERVAL 55 DAY, 103.05),
-- Sparkling Water (402)
(1028, 402, 80, CURDATE() - INTERVAL 5  DAY, 239.20),
(1029, 402, 65, CURDATE() - INTERVAL 30 DAY, 194.35),
-- Cola (403)
(1030, 403, 90, CURDATE() - INTERVAL 4  DAY, 170.10),
(1031, 403, 75, CURDATE() - INTERVAL 20 DAY, 141.75),
(1032, 403,100, CURDATE() - INTERVAL 45 DAY, 189.00),
-- Salted Crisps (501)
(1033, 501,100, CURDATE() - INTERVAL 3  DAY, 149.00),
(1034, 501, 80, CURDATE() - INTERVAL 18 DAY, 119.20),
(1035, 501,120, CURDATE() - INTERVAL 50 DAY, 178.80),
-- Chocolate Bar (502)
(1036, 502, 60, CURDATE() - INTERVAL 6  DAY,  77.40),
(1037, 502, 55, CURDATE() - INTERVAL 25 DAY,  70.95),
-- Mixed Nuts (503)
(1038, 503, 25, CURDATE() - INTERVAL 11 DAY,  87.25),
-- Frozen Peas (601)
(1039, 601, 30, CURDATE() - INTERVAL 9  DAY,  59.70),
(1040, 601, 25, CURDATE() - INTERVAL 40 DAY,  49.75),
-- Beef Lasagne (602)
(1041, 602, 20, CURDATE() - INTERVAL 7  DAY,  99.80),
(1042, 602, 18, CURDATE() - INTERVAL 35 DAY,  89.82),
-- Dishwasher Tablets (701)
(1043, 701, 10, CURDATE() - INTERVAL 14 DAY,  69.90),
-- Laundry Powder (702)
(1044, 702,  8, CURDATE() - INTERVAL 20 DAY,  59.92);



--  SECTION 3: REPORT 1 — "EXPIRING SOON"
--  Products expiring within 7 days with stock > 50.

SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.StockCount,
    p.ExpiryDate,
    DATEDIFF(p.ExpiryDate, CURDATE())        AS DaysUntilExpiry,
    p.SellingPrice,
    ROUND(p.StockCount * p.CostPrice, 2)     AS PotentialWriteOffValue
FROM
    Products    p
    JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE
    p.ExpiryDate IS NOT NULL
    AND p.ExpiryDate <= CURDATE() + INTERVAL 7 DAY
    AND p.ExpiryDate >= CURDATE()
    AND p.StockCount > 50
ORDER BY
    p.ExpiryDate ASC,
    p.StockCount DESC;



--  SECTION 4: REPORT 2 — "DEAD STOCK" ANALYSIS
--  Products with zero sales in the last 60 days.


SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.StockCount,
    p.ExpiryDate,
    CASE
        WHEN p.ExpiryDate IS NOT NULL
             AND p.ExpiryDate <= CURDATE() + INTERVAL 30 DAY
        THEN 'URGENT – Perishable'
        WHEN p.ExpiryDate IS NOT NULL
        THEN 'Perishable'
        ELSE 'Non-Perishable'
    END                                       AS PerishableStatus,
    ROUND(p.StockCount * p.CostPrice, 2)      AS TiedUpInventoryValue
FROM
    Products    p
    JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE
    p.ProductID NOT IN (
        SELECT DISTINCT ProductID
        FROM   SalesTransactions
        WHERE  SaleDate >= CURDATE() - INTERVAL 60 DAY
    )
ORDER BY
    TiedUpInventoryValue DESC;


--  SECTION 5: REPORT 3 — REVENUE CONTRIBUTION BY CATEGORY
--  Total revenue per category for the last calendar month.

SELECT
    c.CategoryName,
    COUNT(DISTINCT st.TransactionID)          AS TotalTransactions,
    SUM(st.QuantitySold)                      AS TotalUnitsSold,
    ROUND(SUM(st.TotalAmount), 2)             AS TotalRevenue,
    ROUND(
        SUM(st.TotalAmount) * 100.0
        / SUM(SUM(st.TotalAmount)) OVER (),
        2
    )                                         AS RevenueSharePct
FROM
    SalesTransactions st
    JOIN Products     p ON st.ProductID  = p.ProductID
    JOIN Categories   c ON p.CategoryID = c.CategoryID
WHERE
    st.SaleDate >= DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, '%Y-%m-01')
    AND st.SaleDate <  DATE_FORMAT(CURDATE(), '%Y-%m-01')
GROUP BY
    c.CategoryID,
    c.CategoryName
ORDER BY
    TotalRevenue DESC;



