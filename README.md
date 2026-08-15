# Olist Marketplace Analytics

One line on what the repo is and what dataset it uses.

---

## 01 — Delivery Promise Optimization
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/doniyor117/olist-store-analysis/blob/main/01-delivery-estimates/analysis.ipynb) · [Notebook](01-delivery-estimates/analysis.ipynb)

**Olist promises 23 days and delivers in 10.** [2-3 sentences: what you found, what you recommend, the numbers.]

### Questions
[your three]

### Findings
[your four bullets]

![figure 1](01-delivery-estimates/figures/...)
![figure 2](...)

### Recommendation
[one paragraph]

### Limitations
[your list]

---

## Data & Tools

**Data:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — ~100k orders placed between 2016 and 2018, across nine relational tables. Downloaded at runtime, not committed to the repo.

**Tools:** Python, pandas, NumPy, matplotlib, seaborn, LightGBM, Optuna, scikit-learn.

## Repo structure
├── 01-delivery-estimates/
│   ├── figures/           charts exported from the analysis
│   └── analysis.ipynb     the deliverable: question, findings, model, recommendation
├── lab/
│   └── lab.ipynb          exploratory work, dead ends included
├── models/
│   ├── delivery_p90.txt        trained LightGBM quantile model
│   └── delivery_p90_meta.json  features, category levels and params needed to use it
├── .gitignore
├── README.md
└── requirements.txt

## How to run
Colab badge, or clone + requirements.

## Planned
- 02 — Seller quality
- 03 — Freight economics
