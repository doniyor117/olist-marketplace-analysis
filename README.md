# Olist Marketplace Analytics

[One line on what the repo is and what dataset it uses.]

---

## 01 — Delivery Promise Optimization

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/doniyor117/olist-store-analysis/blob/main/01-delivery-estimates/analysis.ipynb)

**Olist promises 23 days and delivers in 10.** [2-3 sentences: what you found, what you recommend, the numbers.]

### Analysis Overview

* **Questions:** [your three]
* **Findings:** [your four bullets]
* **Recommendation:** [one paragraph]
* **Limitations:** [your list]

### Figures

![Figure 1 description](01-delivery-estimates/figures/figure1.png)
![Figure 2 description](01-delivery-estimates/figures/figure2.png)

---

## Project Details

### Data & Tools
* **Data:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — ~100k orders placed between 2016 and 2018. Downloaded at runtime, not committed to the repo.
* **Tools:** Python, pandas, NumPy, matplotlib, seaborn, LightGBM, Optuna, scikit-learn

### How to Run
1. **Colab:** Click the badge in the project section above.
2. **Local:** Clone this repository and install dependencies:
   ```bash
   git clone [https://github.com/doniyor117/olist-store-analysis.git](https://github.com/doniyor117/olist-store-analysis.git)
   pip install -r requirements.txt
   ```

---

## Repo Structure

```text
├── 01-delivery-estimates/
│   ├── figures/                # charts exported from the analysis
│   └── analysis.ipynb          # the deliverable: question, findings, model, recommendation
├── lab/
│   └── lab.ipynb               # exploratory work, dead ends included
├── models/
│   ├── delivery_p90.txt        # trained LightGBM quantile model
│   └── delivery_p90_meta.json  # features, category levels and params needed to use it
├── .gitignore
├── README.md
└── requirements.txt
```

---

## Roadmap
- [ ] 02 — Seller quality
- [ ] 03 — Freight economics
