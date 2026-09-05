-- Staging layer for the seller-quality analysis.
-- Run against the DuckDB database after the nine CSVs are loaded as tables.

-- Orders that map to exactly one seller. Reviews are per order, so a review on a
-- multi-seller order (about 1.3% of orders) cannot be assigned to one seller.
CREATE OR REPLACE VIEW single_seller_orders AS
SELECT order_id, any_value(seller_id) AS seller_id
FROM order_items
GROUP BY order_id
HAVING count(DISTINCT seller_id) = 1;

-- One row per seller and order, with the shipping deadline (the latest item
-- limit on the order) next to the actual carrier hand-off date.
CREATE OR REPLACE VIEW seller_order AS
SELECT i.seller_id,
       o.order_id,
       o.order_status,
       max(i.shipping_limit_date)                AS shipping_limit_date,
       any_value(o.order_delivered_carrier_date) AS carrier_date
FROM order_items i
JOIN orders o USING (order_id)
GROUP BY i.seller_id, o.order_id, o.order_status;
