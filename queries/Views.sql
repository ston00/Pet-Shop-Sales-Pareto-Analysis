-- Sales = Quantity * Unit Price
-- CustomerID, sales
CREATE OR REPLACE VIEW `pet-shop-sales.salesdataset.sales_v1`
AS
SELECT
  CustomerID,
  (Quantity * UnitPrice) AS sales
FROM `pet-shop-sales.salesdataset.sales`;

--Group By customers, sales for each customer in one row of data
CREATE OR REPLACE VIEW `pet-shop-sales.salesdataset.sales_v2`
AS
SELECT
    CustomerID,
    SUM(sales) AS customer_revenue
  FROM `pet-shop-sales.salesdataset.sales_v1`
  GROUP BY CustomerID;

-- Rank Customers by highest total sales in descending order
-- Calculates culmalative revenue
CREATE OR REPLACE VIEW `pet-shop-sales.salesdataset.sales_v3`
AS 
SELECT
  CustomerID,
  customer_revenue,
  ROW_NUMBER() OVER(ORDER BY customer_revenue DESC) AS cum_customer,
  COUNT(*) OVER() AS total_customers,
  SUM(customer_revenue) OVER(ORDER BY customer_revenue DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cum_revenue,
  SUM(customer_revenue) OVER() AS total_revenue
FROM `pet-shop-sales.salesdataset.sales_v2`;

--Calculates what percentage of customers hit a certain threshold
CREATE OR REPLACE VIEW `pet-shop-sales.salesdataset.sales_v3`
AS 
SELECT
  CustomerID,
  customer_revenue,
  cum_customer,  
  total_customers,
  cum_revenue,
  total_revenue,
  cum_revenue / total_revenue AS cum_sales_share,
  cum_customer / total_customers AS cum_pct_customer,
FROM `pet-shop-sales.salesdataset.sales_v3`;
