--declare variable
DECLARE target_sales_pct FLOAT64 DEFAULT 0.80;

WITH base_sales AS (
  SELECT
  CustomerID,
  (Quantity * UnitPrice) AS sales
  FROM `pet-shop-sales.salesdataset.sales`
),
customer_sales AS (
  SELECT
    CustomerID,
    SUM(sales) AS customer_revenue
  FROM base_sales
  GROUP BY CustomerID
),
ranked AS (
  SELECT
    CustomerID,
    customer_revenue,
    ROW_NUMBER() OVER(ORDER BY customer_revenue DESC) AS cum_customer,
    COUNT(*) OVER() AS total_customers,
    SUM(customer_revenue) OVER(ORDER BY customer_revenue DESC
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cum_revenue,
    SUM(customer_revenue) OVER() AS total_revenue
  FROM customer_sales
),
with_pct AS (
  SELECT 
    CustomerID,
    customer_revenue,
    cum_customer,  
    total_customers,
    cum_revenue,
    total_revenue,
    cum_revenue / total_revenue AS cum_sales_share,
    cum_customer / total_customers AS cum_pct_customer,
  FROM ranked
)
SELECT 
  MIN(cum_customer) AS num_of_customers,
  MIN(cum_revenue) AS cum_revenue,
  MIN(total_revenue) AS total_revenue,
  target_sales_pct * 100 AS target_sales_pct,
  MIN(total_revenue * target_sales_pct) AS target_sales,
  MIN(cum_sales_share) AS cum_sales_share,
  MIN(cum_pct_customer) AS cum_pct_customers
FROM with_pct
WHERE cum_sales_share >= target_sales_pct;