-- Sort scored sellers (10+ orders) into keep / watch / remove and measure how
-- much of the marketplace's 1-star reviews each tier accounts for.
-- Depends on the views in 01_staging_views.sql and 02_seller_scorecard.sql.

WITH scored AS (
    SELECT * FROM seller_scorecard WHERE n_orders >= 10
),
tiered AS (
    SELECT *,
           CASE
               WHEN avg_score IS NULL THEN 'unrated'
               WHEN avg_score >= 4.0 AND coalesce(pct_late_ship, 0) < 15 THEN 'keep'
               WHEN avg_score < 3.0 OR coalesce(pct_late_ship, 0) >= 40
                    OR coalesce(pct_canceled, 0) >= 10 THEN 'remove'
               ELSE 'watch'
           END AS tier
    FROM scored
),
marketplace AS (
    SELECT count(*) FILTER (WHERE review_score = 1) AS all_1star
    FROM single_seller_orders s JOIN order_reviews r USING (order_id)
)
SELECT t.tier,
       count(*)                                                          AS sellers,
       round(100.0 * count(*) / sum(count(*)) OVER (), 1)                 AS pct_sellers,
       sum(t.n_orders)                                                    AS orders,
       round(100.0 * sum(t.n_orders) / sum(sum(t.n_orders)) OVER (), 1)   AS pct_orders,
       round(avg(t.avg_score), 2)                                        AS avg_score,
       round(100.0 * sum(t.n_1star) / any_value(m.all_1star), 1)          AS pct_of_marketplace_1star,
       round(100.0 * sum(t.n_1star) / sum(t.n_reviews), 1)               AS tier_1star_rate
FROM tiered t, marketplace m
GROUP BY t.tier
ORDER BY sellers DESC;
