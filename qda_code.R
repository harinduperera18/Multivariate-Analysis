# QUADRATIC DISCRIMINANT ANALYSIS (QDA)

qda_data <- data
qda_data$risk_level <- as.factor(qda_data$risk_level)

# Numeric predictors 
qda_num <- qda_data[, sapply(qda_data, is.numeric), drop = FALSE]

# Standardize predictors
qda_num <- scale(qda_num)

qda_df <- data.frame(qda_num, risk_level = qda_data$risk_level)

cat("\nDimensions of QDA dataset:\n")
print(dim(qda_df))

cat("\nClass distribution:\n")
print(table(qda_df$risk_level))


# Assumption check : Equality of covariance matrices

library(biotools)

boxm_result <- boxM(qda_num, qda_df$risk_level)

cat("\nBox's M Test for Homogeneity of Covariance Matrices:\n")
print(boxm_result)


# Fit QDA model

library(MASS)

qda_model <- qda(risk_level ~ ., data = qda_df)

cat("\nQDA Model:\n")
print(qda_model)

# Prior probabilities

cat("\nPrior probabilities of groups:\n")
print(round(qda_model$prior, 4))

# Cross validation

qda_cv <- qda(risk_level ~ ., data = qda_df, CV = TRUE)

# Confusion matrix

conf_mat_qda <- table(Predicted = qda_cv$class,Actual = qda_df$risk_level)

cat("\nConfusion Matrix:\n")
print(conf_mat_qda)

# Overall accuracy

qda_accuracy <- mean(qda_cv$class == qda_df$risk_level)
cat("\nQDA Cross-validated Accuracy:", round(qda_accuracy, 4), "\n")

# Class-wise metrics

actual <- qda_df$risk_level
pred <- qda_cv$class
cm <- conf_mat_qda

classes <- levels(actual)

metrics <- data.frame(Class = classes,Precision = NA,Recall = NA,F1 = NA)

for (i in seq_along(classes)) {
  cls <- classes[i]
  
  tp <- cm[cls, cls]
  fp <- sum(cm[cls, ]) - tp
  fn <- sum(cm[, cls]) - tp
  
  precision <- ifelse((tp + fp) == 0, NA, tp / (tp + fp))
  recall    <- ifelse((tp + fn) == 0, NA, tp / (tp + fn))
  f1        <- ifelse(is.na(precision) | is.na(recall) | (precision + recall) == 0,
                      NA,
                      2 * precision * recall / (precision + recall))
  
  metrics$Precision[i] <- precision
  metrics$Recall[i] <- recall
  metrics$F1[i] <- f1
}

metrics[, 2:4] <- round(metrics[, 2:4], 4)

cat("\nClass-wise Precision, Recall, and F1:\n")
print(metrics)

# Balanced accuracy

balanced_accuracy <- mean(metrics$Recall, na.rm = TRUE)
cat("\nBalanced Accuracy:", round(balanced_accuracy, 4), "\n")