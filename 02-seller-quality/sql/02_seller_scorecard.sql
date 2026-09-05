-- One row per seller with every metric used in the analysis.
-- Depends on the views in 01_staging_views.sql.

CREATE OR REPLACE VIEW seller_scorecard AS
WITH reviews AS (
    SELECT s.seller_id,
           count(*)                                       AS n_reviews,
           avg(r.review_score)                            AS avg_score,
           count(*) FILTER (WHERE r.review_score = 1)      AS n_1star,
           100.0 * count(*) FILTER (WHERE r.review_score = 1) / count(*) AS pct_1star
    FROM single_seller_orders s
    JOIN order_reviews r USING (order_id)
    GROUP BY s.seller_id
),
delivery AS (
    SELECT seller_id,
           count(*)                                                              AS n_orders,
           100.0 * count(*) FILTER (WHERE order_status = 'canceled') / count(*)   AS pct_canceled,
           100.0 * count(*) FILTER (WHERE carrier_date > shipping_limit_date)
                 / nullif(count(*) FILTER (WHERE carrier_date IS NOT NULL), 0)    AS pct_late_ship
    FROM seller_order
    GROUP BY seller_id
)
SELECT d.seller_id,
       se.seller_state,
       d.n_orders,
       d.pct_canceled,
       d.pct_late_ship,
       r.n_reviews,
       r.avg_score,
       r.pct_1star,
       r.n_1star
FROM delivery d
LEFT JOIN reviews r USING (seller_id)
LEFT JOIN sellers se USING (seller_id);
