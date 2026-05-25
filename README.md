# Pet-Shop-Sales-Pareto-Analysis
pareto-analysis/
├── README.md                      # Project overview & instructions
├── sql/
│   ├── pareto_cte_analysis.sql    # CTE-based Pareto calculation
│   ├── pareto_view.sql            # Reusable database view
│   └── window_functions.sql       # Window function approach
├── python/
│   ├── bigquery_connector.py      # GCP BigQuery integration
│   ├── pareto_analysis.py         # Core analysis logic
│   ├── visualizations.py          # Charting & plotting
│   └── config.py                  # Configuration & credentials
├── notebooks/
│   └── pareto_example.ipynb       # Jupyter notebook with walkthrough
├── data/
│   └── sample_data.csv            # Example dataset
├── results/
│   ├── pareto_chart.png           # Output visualization
│   └── analysis_report.md         # Summary report
└── tests/
    └── test_pareto_calc.py        # Unit tests
