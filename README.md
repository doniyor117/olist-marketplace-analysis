<img src="assets/olist-logo.svg" width="225" />

# **Marketplace Analysis**

Olist is a Brazilian e-commerce platform that operates as a marketplace aggregator, allowing small businesses to sell their products directly through the 'Olist Store' on major e-commerce channels. This project provides a marketplace analysis on delivery estimates and seller quality

## Scope

While this dataset could explore several other questions, I narrowed my focus on two criteria: can these nine tables actually answer the question and would the answer help someone at Olist to make a better decision?

The candidates were repeat purchase, category performance, seller quality and freight economics. Repeat purchase failed the first one as only ~3% of customers made >1 orders, while category performance failed the second as Olist acts as marketplace where it doesn't choose it's catalog. "Furniture sells well" is actionable for a store that picks its own stock, but for Olist it isn't the same.

While freight pricing could support some analysis, the dataset has no cost data, so we can't tell if Olist makes or loses money on shipping. Seller quality and delivery estimates optimization pass both.



## **01 - Delivery Promise Optimization**

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/doniyor117/olist-marketplace-analysis/blob/main/01-delivery-estimates/analysis.ipynb)
[![Notebook](https://img.shields.io/badge/notebook-view%20on%20GitHub-181717?logo=jupyter)](01-delivery-estimates/analysis.ipynb)

Estimated delivery date is one of the features Olist controls directly. Sellers ship the product and Olist sets the promise at checkout. *It shows customers a delivery date that is typically 23 days across the full dataset, while orders arrive in around 10.* A large buffer protects against breaking the promise, but it also makes the offer look slower than it is, which may hurt Olist against competitors showing tighter dates. That trade-off is what this analysis explores.

This analysis asks:

- **Does the gap between estimated and actual delivered dates vary a lot based on factors like distance or season?**
- **What does a broken promise cost in review score, and what does extra padding bring?**
- **What should the promised date actually be, and what does Olist gain and give up by keeping the current one?**

## Analysis Overview:

I started by measuring the gap directly. For all ~96k orders delivered between 2016 and 2018, I took the promised date and the actual delivery date, calculated their mean and median, and subtracted them to see the padding (days between delivered and estimated dates).

![observed_vs_estimated](01-delivery-estimates/figures/observed_vs_estimated_delivery_time_histplot.png)

> The left figure shows the distribution of days it took for order deliveries, and we can see right-skewed data, so I used median for my main measures as mean is affected by outliers and the long tail. The right figure is the distribution of paddings. For most orders the delivery takes around 10 days, while the promise sits 12 days beyond that. What stands out is that even with a buffer that large, 7.6% of orders still arrive late.

To know about customer satisfaction and behaviour for the delivery arrival, I examined customer review scores segmented by different delivery bins of paddings below. I used percentiles to find the edges of the bins. (+) when orders arrive early, (-) when it's late.


| Buffer bucket | Days early (+) / late (−) |
| :--- | :--- |
| **very late** | below −5 |
| **late** | −5 to −2 |
| **slightly late** | −2 to −1 |
| **on-time** | −1 to 0 |
| **slightly early** | 0 to 7 |
| **early** | 7 to 16 |
| **very early** | 16 to 26 |
| **extremely early** | above 26 |


![score_delivery_perform](01-delivery-estimates/figures/review_scores_by_delivery_performance.png)

> It's obvious from here that late deliveries lower the scores dramatically. Even 2/3 of the very late orders have received the review score 1. Another interesting finding is that early deliveries scored even higher than on time deliveries, and the scores flatten after the early bin no matter how big it is. The score figures were almost the same even when they were checked with distance buckets. This means extending the estimated date doesn't buy extra scores after that point, but lateness hurts a lot.

Since being late costs much more than being early, the promise shouldn't be a best guess of the delivery time. Predicting the average would mean arriving late on half the orders. Say a route's delivery times are 5, 8, 9, 12, 22 days. The average is about 11. Promise 11 days and the 12 and the 22 both miss. Two out of five orders are late.

So instead I trained a LightGBM model to predict a high percentile of delivery time, so the promised date is one the order beats most of the time. The percentile chosen sets the late rate directly.

I also calculated a simple baseline that just finds the 90th percentile delivery time for each seller-state and customer-state pair, to see if a simple state-pair calculation could do the same job.

| Method | Late Rate (%) | Mean Promise (Days) | Median Promise (Days) |
| :--- | :---: | :---: | :---: |
| **olist_native_estimates** | 4.50 | 20.94 | 20.0 |
| **baseline_estimates** | 2.18 | 21.32 | 20.0 |
| **model_estimates** | 3.44 | 17.91 | 17.0 |

Here we have a comparison table for each method. On test dataset Olist predicted ~21 days on average at 4.5% late rate, while our model had ~18 days at 3.44% - noticeably lower on both measures. Baseline method halved the late rate but also increased the delivery estimates beyond Olist's estimates.


![promise_reliability](01-delivery-estimates/figures/promise_vs_reliability.png)

> Different alpha levels trade off one gain against another. On p70 we gain the shortest delivery estimates among others (11 days on average) but we increase late rate a lot, over 10%. The reverse happens at p95.

## Main Findings

- Late delivery is very costly. 2/3 of the very late orders (5+ days) were rated 1 star, while extra padding plateaued the scores after the 7-16 day range.
- A LightGBM quantile regression model at p90 gives typical promises of ~18 days at 3.44% late, against Olist's ~21 days at 4.5% on the test data. Shorter and more reliable at the same time.
- Delivery got faster over 2018 while promises didn't follow. The late rate falls to 4.5% in the June-October test window, so the padding was calibrated for how slow Olist used to be.
- Destination state, distance and purchase month drove the model most. A state-pair lookup can't see the last two, which is where the shorter promises come from.

## **Recommendation:**

I recommend using the model with p90 settings as it improves both measures at the same time: ~18 days at 3.44% late, against Olist's ~21 days at 4.5%. Going higher than p90 buys a little more reliability but gives back the shorter promise, and the choice of alpha is a business decision about risk appetite.

---

## Project Details

> * **Data:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
> * **Tools:** *Python* - pandas, numpy, matplotlib, seaborn, LightGBM, optuna, scikit-learn


## Repo Structure

```text
├── 01-delivery-estimates/
│   ├── figures/                # charts exported from the analysis
│   ├── models/
│   │   ├── delivery_p90.txt        # trained LightGBM quantile model
│   │   └── delivery_p90_meta.json  # essential configs for the model
│   ├── analysis.ipynb          # the deliverable: findings, model, recommendation
│   └── lab.ipynb               # exploratory work, dead ends included
├── .gitignore
├── README.md
└── requirements.txt
```

---

## Roadmap
> finished:

- Delivery estimates optimization - Aug 2026

> next:

- Seller quality
