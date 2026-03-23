-- =========================================
-- E-commerce Data Analysis
-- =========================================

-- 1. Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 2. Total revenue
SELECT SUM(price) AS total_revenue
FROM order_items;

-- 3. Monthly revenue trend
SELECT 
    strftime('%Y-%m', order_purchase_timestamp) AS month,
    SUM(oi.price) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- 4. Unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM customers;

-- 5. Average Order Value (AOV)
SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT 
        order_id,
        SUM(price) AS order_total
    FROM order_items
    GROUP BY order_id
);

-- 6. Top 10 customers by revenue
SELECT 
    o.customer_id,
    SUM(oi.price) AS total_spent
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- 7. Repeat customers
SELECT 
    COUNT(*) AS repeat_customers
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
);
