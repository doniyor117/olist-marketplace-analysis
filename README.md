<img src="https://api.platform.softwareone.com/public/v1/public-catalog/vendor-profiles/VND-5970-8835/icon" width="225" />

# **Marketplace Analysis**

[One line on what the repo is and what dataset it uses.]

## **01 - Delivery Promise Optimization**

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/doniyor117/olist-marketplace-analysis/blob/main/01-delivery-estimates/analysis.ipynb)
[![Notebook](https://img.shields.io/badge/notebook-view%20on%20GitHub-181717?logo=jupyter)](01-delivery-estimates/analysis.ipynb)

*Olist shows customers a delivery date at checkout that is typically 23 days, while orders arrive in around 10.*

This analysis asks:

- **Does the gap between estimated and delivered dates vary a lot based on distance or season?**
- **What does a broken promise cost in review score, and what does extra padding days bring?**
- **What should the promised date actually be, and what does Olist gain and give up by keeping the current one?**

## Analysis Overview:

discussion

![observed_vs_estimated](01-delivery-estimates/figures/observed_vs_estimated_delivery_time_histplot.png)

comment

![score_delivery_perform](01-delivery-estimates/figures/review_scores_by_delivery_performance.png)

comment

![promise_reliability](01-delivery-estimates/figures/promise_vs_reliability.png)

discussion

...

## Main Findings:

- Delivery got faster over 2018 while promises didn't follow: the late rate falls to 4.5% in the June-October test window, so the padding was calibrated for how slow Olist used to be.
- Late delivery is very costly - 2/3 of the very late orders (+5 days) were rated with 1 review score, while having more padding plateaued the scores after 7-16 days interval.
- LightGBM quantile regression model with settings alpha=0.9 achieves typical promises of ~18 days at 3.4% late rate vs Olist's 21 days at 4.5% on the test dataset.
- The most important features were destination state, distance and purchase month.

## **Recommendation:**

Use the model with p90 settings as it improves both measures at the same time, or we can prioritize less lateness or shorter paddings.

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
- Freight economics
