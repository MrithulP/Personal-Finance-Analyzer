# 💰 Personal Expense Analysis System

A lightweight R program that reads your personal expense data from a CSV file and generates insightful visualizations and summaries to help you understand your spending habits.

---

## ✨ Features

- 📂 Reads expense data from a user-selected CSV file
- 🧹 Cleans and validates input data automatically
- 📊 Generates four types of visualizations:
  - **Category-wise** spending breakdown
  - **Monthly** spending trends
  - **Daily** spending patterns
  - **Cumulative** spending over time
- 💾 Exports category and monthly summaries as CSV files
- 🎯 Supports a configurable monthly budget (default: ₹30,000)

---

## 📋 Prerequisites

- [R](https://www.r-project.org/) (version 4.0 or higher recommended)
- [RStudio](https://posit.co/download/rstudio-desktop/) *(optional but recommended)*

---

## 📦 Installation

**1. Install R** from [https://www.r-project.org/](https://www.r-project.org/)

**2. Install the required R packages** by running this in your R console:

```r
install.packages("dplyr")
install.packages("ggplot2")
install.packages("scales")
```

---

## 📁 CSV File Format

Your expense file must be a `.csv` with exactly **three columns**:

| Column     | Description                        | Example       |
|------------|------------------------------------|---------------|
| `Date`     | Transaction date (`YYYY-MM-DD`)    | `2026-04-01`  |
| `Category` | Type of expense                    | `Food`        |
| `Amount`   | Amount spent (numeric)             | `1500`        |

**Sample CSV:**

```csv
Date,Category,Amount
2026-04-01,Food,850
2026-04-02,Transport,200
2026-04-03,Shopping,3200
2026-04-05,Food,650
2026-04-07,Utilities,1800
```

> **Tips:**
> - Use consistent, uniform category names (e.g., always `Food`, not sometimes `food` or `Groceries`)
> - Dates must strictly follow the `YYYY-MM-DD` format
> - The `Amount` column must contain only numeric values (no currency symbols)

---

## 🚀 Usage

1. Open `run_analysis.R` in RStudio (or any R environment)
2. Run the script using the **Run** button or execute in the console:
   ```r
   source("run_analysis.R")
   ```
3. A file picker dialog will appear — select your `.csv` expense file
4. Enter your **monthly budget** when prompted (press Enter to use the default of ₹30,000)

The program will automatically:

- Print your **total spending** and **top transactions** in the console
- Display **four graphs** (category-wise, monthly, daily, cumulative)
- Save two CSV exports in the same directory as the script:
  - `category_summary.csv` — spending totals by category
  - `monthly_summary.csv` — spending totals by month

---

## 📤 Output

| Output                   | Type        | Description                              |
|--------------------------|-------------|------------------------------------------|
| Console summary          | Text        | Totals, averages, and top transactions   |
| Category-wise chart      | Plot        | Bar chart of spending by category        |
| Monthly trend chart      | Plot        | Line/bar chart of month-over-month spend |
| Daily trend chart        | Plot        | Day-by-day spending over time            |
| Cumulative spend chart   | Plot        | Running total of expenses                |
| `category_summary.csv`   | CSV file    | Category totals exported to disk         |
| `monthly_summary.csv`    | CSV file    | Monthly totals exported to disk          |

---

## 🗂️ Project Structure

```
personal-expense-analysis/
├── run_analysis.R        # Main script — run this
├── README.md             # Project documentation
└── sample_expenses.csv   # (Optional) Sample data to get started
```

---

## 🛠️ Troubleshooting

| Problem | Solution |
|---|---|
| File picker doesn't open | Make sure you're running in an interactive R session (not via `Rscript` in terminal) |
| `Error: package not found` | Run `install.packages("package_name")` for the missing package |
| Date parsing errors | Ensure all dates are in `YYYY-MM-DD` format with no blanks |
| Charts not displaying | Check that a graphics device is available; try running in RStudio |

---

## 📄 License

This project is open-source and free to use under the [MIT License](LICENSE).

---

## 🙌 Contributing

Contributions, suggestions, and bug reports are welcome! Feel free to open an issue or submit a pull request.
