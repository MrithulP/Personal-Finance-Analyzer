library(dplyr)
library(ggplot2)
library(scales)

get_script_path <- function() {
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    return(dirname(rstudioapi::getActiveDocumentContext()$path))
  } else {
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- "--file="
    script_path <- sub(file_arg, "", args[grep(file_arg, args)])
    return(dirname(normalizePath(script_path)))
  }
}

output_dir <- get_script_path()

theme_modern <- function() {
  theme_minimal() +
    theme(
      plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
      plot.subtitle = element_text(size = 10, hjust = 0.5, color = "gray50"),
      axis.text = element_text(size = 10),
      axis.title = element_text(size = 12, face = "bold"),
      panel.grid.minor = element_blank()
    )
}

load_data <- function() {
  file_path <- file.choose()
  data <- read.csv(file_path, stringsAsFactors = FALSE)
  data$Date <- as.Date(data$Date)
  
  if (any(is.na(data$Date))) {
    stop("Invalid Date format in CSV")
  }
  
  data$Amount <- as.numeric(data$Amount)
  data
}

monthly_summary <- function(data, budget) {
  data$Month <- format(data$Date, "%Y-%m")
  
  monthly <- data %>%
    group_by(Month) %>%
    summarise(Total = sum(Amount))
  
  monthly$Budget <- budget
  monthly$Remaining <- budget - monthly$Total
  monthly$Status <- ifelse(monthly$Remaining < 0, "Over Budget", "Within Budget")
  
  print(monthly)
  monthly
}

category_analysis <- function(data) {
  data %>%
    group_by(Category) %>%
    summarise(Total = sum(Amount)) %>%
    arrange(desc(Total))
}

plot_category <- function(data) {
  df <- category_analysis(data)
  
  ggplot(df, aes(x = reorder(Category, Total), y = Total, fill = Category)) +
    geom_col(width = 0.7) +
    coord_flip() +
    theme_modern() +
    theme(legend.position = "none") +
    scale_y_continuous(labels = comma) +
    labs(title = "Spending by Category", x = "", y = "Amount")
}

plot_monthly <- function(data, budget) {
  data$Month <- format(data$Date, "%Y-%m")
  
  monthly <- data %>%
    group_by(Month) %>%
    summarise(Total = sum(Amount))
  
  ggplot(monthly, aes(x = Month, y = Total, group = 1)) +
    geom_line(size = 1.2) +
    geom_point(size = 3) +
    geom_hline(yintercept = budget, linetype = "dashed") +
    theme_modern() +
    scale_y_continuous(labels = comma) +
    labs(title = "Monthly Spending vs Budget", x = "", y = "Amount") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

plot_daily <- function(data) {
  daily <- data %>%
    group_by(Date) %>%
    summarise(Total = sum(Amount))
  
  ggplot(daily, aes(x = Date, y = Total)) +
    geom_line(size = 1.2) +
    geom_point(size = 2) +
    theme_modern() +
    scale_y_continuous(labels = comma) +
    labs(title = "Daily Spending Trend", x = "", y = "Amount")
}

plot_cumulative <- function(data) {
  data <- data %>% arrange(Date)
  data$Cumulative <- cumsum(data$Amount)
  
  ggplot(data, aes(x = Date, y = Cumulative)) +
    geom_line(size = 1.2) +
    geom_area(alpha = 0.2) +
    theme_modern() +
    scale_y_continuous(labels = comma) +
    labs(title = "Cumulative Spending", x = "", y = "Total")
}

export_category <- function(data) {
  summary <- category_analysis(data)
  write.csv(summary, file.path(output_dir, "category_summary.csv"), row.names = FALSE)
}

export_monthly <- function(data, budget) {
  monthly <- monthly_summary(data, budget)
  write.csv(monthly, file.path(output_dir, "monthly_summary.csv"), row.names = FALSE)
}

run_analysis <- function(budget = 30000) {
  data <- load_data()
  
  cat("\nSummary\n")
  cat("Total Spending:", sum(data$Amount), "\n")
  cat("Transactions:", nrow(data), "\n")
  
  cat("\nMonthly\n")
  monthly_summary(data, budget)
  
  cat("\nTop Expenses\n")
  print(head(arrange(data, desc(Amount)), 5))
  
  print(plot_category(data))
  print(plot_monthly(data, budget))
  print(plot_daily(data))
  print(plot_cumulative(data))
  
  export_category(data)
  export_monthly(data, budget)
  
  cat("\nSaved in:", output_dir, "\n")
}

run_analysis(30000)