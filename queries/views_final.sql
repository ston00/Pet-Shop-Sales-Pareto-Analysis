--declare variable
DECLARE target_sales_pct FLOAT64 DEFAULT 0.80;

--number_of_customers, cum_revenue, total_revenue, target_sales_percent
--target_sales, cum_sales_share, target_sales_pct
SELECT 
  MIN(cum_customer) AS num_of_customers,
  MIN(cum_revenue) AS cum_revenue,
  MIN(total_revenue) AS total_revenue,
  target_sales_pct * 100 AS target_sales_pct,
  MIN(total_revenue * target_sales_pct) AS target_sales,
  MIN(cum_sales_share) AS cum_sales_share,
  MIN(cum_pct_customer) AS cum_pct_customers
FROM `pet-shop-sales.salesdataset.sales_v4`
WHERE cum_sales_share >= target_sales_pct;