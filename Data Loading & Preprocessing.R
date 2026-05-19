# DATA LOADING & PREPROCESSING

data <- read.csv("student_mental_health_burnout_1M.csv")

set.seed(123)

# Convert categorical variables
data$gender <- as.factor(data$gender)
data$academic_year <- as.factor(data$academic_year)
data$risk_level <- as.factor(data$risk_level)

# Remove missing values
data <- na.omit(data)

# Remove outcome / derived and Discrete variables
remove_vars <- c("mental_health_index", "dropout_risk","age")
remove_vars <- remove_vars[remove_vars %in% colnames(data)]
data <- data[, !(colnames(data) %in% remove_vars)]

# Numeric subset
student_num <- data[, sapply(data, is.numeric), drop = FALSE]

# Outlier detection using numeric variables
z_scores <- scale(student_num)
outlier_rows <- apply(abs(z_scores) > 3, 1, any)
outlier_count <- sum(outlier_rows)
cat("Number of outlier rows:", outlier_count, "\n")

# Remove outliers from BOTH full data and numeric data
data <- data[!outlier_rows, ]
student_num <- data[, sapply(data, is.numeric), drop = FALSE]
