
DROP TABLE IF EXISTS dbo.BanggoodProducts;
GO

SELECT COUNT(*) FROM dbo.BanggoodProducts;


-- Total Products per Category
SELECT 
    category_name,
    COUNT(*) AS total_products
FROM dbo.BanggoodProducts
GROUP BY category_name
ORDER BY total_products DESC;

-- Average Price per Category (USD)
SELECT
    category_name,
    AVG(PRICE_USD) AS avg_price_usd,
    MIN(PRICE_USD) AS min_price_usd,
    MAX(PRICE_USD) AS max_price_usd,
    COUNT(*) AS total_products
FROM dbo.BanggoodProducts
WHERE PRICE_USD IS NOT NULL
GROUP BY category_name
ORDER BY avg_price_usd DESC;

-- Average Rating per Category

SELECT
    category_name,
    AVG(rating) AS avg_rating,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    COUNT(*) AS total_products
FROM dbo.BanggoodProducts
WHERE rating IS NOT NULL
GROUP BY category_name
ORDER BY avg_rating DESC;

--Review Coverage per Category

SELECT
    category_name,
    COUNT(*) AS total_products,
    SUM(CASE WHEN reviews_count > 0 THEN 1 ELSE 0 END) AS products_with_reviews,
    CAST(
        SUM(CASE WHEN reviews_count > 0 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*) AS NUMERIC(5,2)
    ) AS review_coverage_percent
FROM dbo.BanggoodProducts
GROUP BY category_name
ORDER BY review_coverage_percent DESC;

-- Top 10 Most Reviewed Products
SELECT TOP 10
    category_name,
    product_name,
    product_url,
    reviews_count,
    rating,
    PRICE_USD
FROM dbo.BanggoodProducts
WHERE reviews_count IS NOT NULL
ORDER BY reviews_count DESC;

-- Best Value Products (Rating × Reviews / Price)
SELECT TOP 10
    category_name,
    product_name,
    PRICE_USD,
    rating,
    reviews_count,
    (rating * LOG(1 + reviews_count) / PRICE_USD) AS value_score
FROM dbo.BanggoodProducts
WHERE PRICE_USD > 0 AND rating IS NOT NULL AND reviews_count IS NOT NULL
ORDER BY value_score DESC;






