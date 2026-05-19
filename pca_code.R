# PRINCIPAL COMPONENT ANALYSIS (PCA)

# Correlation matrix
cor_matrix <- cor(student_num, method = "spearman")

cat("\nCorrelation Matrix:\n")
print(round(cor_matrix, 2))

corrplot(cor_matrix,method = "color",type = "upper",tl.col = "black",tl.cex = 0.7,addCoef.col = "black",number.cex = 0.5)

# Apply PCA
pca_result <- prcomp(student_num, scale. = TRUE)

cat("\nObjects in PCA result:\n")
print(names(pca_result))

cat("\nVariable means used for centering:\n")
print(pca_result$center)

cat("\nVariable scales used for standardization:\n")
print(pca_result$scale)

# PCA loadings

cat("\nPCA Loadings:\n")
print(round(pca_result$rotation, 4))

# PCA scores

cat("\nFirst 6 PCA scores:\n")
print(head(pca_result$x))

# Standard deviations, eigenvalues

cat("\nStandard deviations of PCs:\n")
print(pca_result$sdev)

VE <- pca_result$sdev^2
cat("\nEigenvalues:\n")
print(VE)

PVE <- VE / sum(VE)
cat("\nProportion of variance explained:\n")
print(round(PVE, 3))

cat("\nCumulative variance explained:\n")
print(round(cumsum(PVE), 3))

cat("\nPCs with eigenvalue > 1 (Kaiser criterion):\n")
print(which(VE > 1))

# Eigenvalue table

eig.val <- get_eigenvalue(pca_result)
cat("\nEigenvalue Table:\n")
print(eig.val)

# Scree plot

fviz_eig(pca_result,addlabels = TRUE,ylim = c(0, 50),xlab = "Principal Components (PCs)",ylab = "Percentage of Variance Explained",main = "Scree Plot of Principal Components")

# Quality of representation 

var <- get_pca_var(pca_result)

cat("\nQuality of representation:\n")
print(head(var$cos2, ncol(student_num)))

corrplot(var$cos2,is.corr = FALSE)

# Top contributing variables to first 7 PCs

loadings_df <- as.data.frame(pca_result$rotation)

for (pc in colnames(loadings_df)[1:min(7, ncol(loadings_df))]) {
  cat("\nTop variables for", pc, ":\n")
  temp <- data.frame(
    Variable = rownames(loadings_df),
    Loading = loadings_df[[pc]]
  )
  temp <- temp[order(abs(temp$Loading), decreasing = TRUE), ]
  temp$Loading <- round(temp$Loading, 4)
  print(head(temp, 8))
}