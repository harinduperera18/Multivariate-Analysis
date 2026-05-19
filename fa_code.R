
# FACTOR ANALYSIS (FA)

# FA uses the same student_num
fa_data <- student_num

# KMO test

cat("\nKMO Test:\n")
kmo_result <- KMO(fa_data)
print(kmo_result)

# Bartlett's test

cat("\nBartlett Test:\n")
bartlett_result <- cortest.bartlett(cor(fa_data), n = nrow(fa_data))
print(bartlett_result)

# Parallel analysis

fa.parallel(fa_data, fa = "fa", main = "Parallel Analysis for Factor Retention")

# Fit factor model

fa_model <- fa(fa_data,nfactors = 7,rotate = "varimax",fm = "ml")

cat("\nFactor Analysis Summary:\n")
print(fa_model)

# Factor loadings

loadings_df <- as.data.frame(unclass(fa_model$loadings))
cat("\nFactor Loadings:\n")
print(round(loadings_df, 4))

# Top variables per factor

result <- data.frame()

for (f in colnames(loadings_df)) {
  temp <- data.frame(
    Factor = f,
    Variable = rownames(loadings_df),
    Loading = loadings_df[[f]]
  )
  temp <- temp[abs(temp$Loading) > 0.4, ]
  temp <- temp[order(abs(temp$Loading), decreasing = TRUE), ]
  result <- rbind(result, temp)
}

result$Loading <- round(result$Loading, 4)

cat("\nTop Variables per Factor (|loading| > 0.4):\n")
print(result)

# Communalities

cat("\nCommunalities:\n")
print(round(fa_model$communality, 4))

# Variance accounted 

cat("\nVariance Accounted For:\n")
print(round(fa_model$Vaccounted, 4))

# Factor diagram

fa.diagram(fa_model)

# Factor loadings heatmap

load_matrix <- round(as.matrix(loadings_df), 2)

load_df <- melt(load_matrix)
colnames(load_df) <- c("Variable", "Factor", "Loading")

ggplot(load_df, aes(x = Factor, y = Variable, fill = Loading)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
  theme_minimal() +
  labs(title = "Factor Loadings Heatmap",
       x = "Factors",
       y = "Variables") +
  theme(
    axis.text.y = element_text(size = 8),
    axis.text.x = element_text(angle = 0, size = 10),
    plot.title = element_text(hjust = 0.5)
  )

library(dplyr)
library(knitr)
library(kableExtra)

result_clean <- result %>%
  arrange(Factor, desc(abs(Loading)))

kable(result_clean,
      caption = "Strong factor loadings for the rotated 7-factor solution",
      digits = 4) %>%
  kable_styling(full_width = FALSE)