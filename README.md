# Multivariate Analysis of Student Mental Health and Burnout

This project analyzes a large student lifestyle, mental health, and burnout dataset using multivariate statistical techniques. The main goal is to identify important patterns in student well-being, reduce dimensionality, uncover latent structures, and classify students into mental health risk groups based on academic, psychological, lifestyle, and behavioral variables.

## Features

- Handles a large dataset with 1,000,000 observations and 20 features
- Performs data preprocessing and missing value handling
- Removes outcome-type and unsuitable categorical variables
- Detects and removes outliers using Z-scores
- Standardizes numerical variables before analysis
- Applies Principal Component Analysis for dimensionality reduction
- Applies Factor Analysis to identify latent structures
- Applies Quadratic Discriminant Analysis for risk-level classification
- Evaluates classification performance using accuracy, precision, recall, F1-score, and balanced accuracy
- Provides visualizations such as correlation plots, scree plots, factor loading heatmaps, and factor diagrams

## Methods Used

### Principal Component Analysis

PCA was used to reduce dimensionality and identify the main directions of variation in the dataset. The results showed that the data contains several important dimensions, including psychological distress, digital behavior, academic pressure, social support, and sleep-related well-being.

### Factor Analysis

Factor Analysis was used to identify hidden factors underlying the observed variables. The extracted factors represented meaningful dimensions such as psychological and financial distress, digital behavior, academic pressure, burnout and recovery, social-emotional adjustment, and academic performance.

### Quadratic Discriminant Analysis

QDA was used to classify students into High, Medium, and Low risk groups. Since the covariance matrices differed across groups, QDA was suitable for the classification task. The model achieved strong classification performance, including high overall accuracy and balanced accuracy.

## Tools Used

- R programming language
- PCA using `prcomp()`
- Factor Analysis using maximum likelihood extraction and varimax rotation
- QDA using the `MASS` package
- Visualizations using R plotting libraries

## Key Findings

The analysis showed that psychological distress is one of the most important dimensions influencing student mental health and burnout. Stress, anxiety, depression, burnout, sleep, and social support played important roles in explaining student risk levels. PCA and Factor Analysis provided consistent insights into the structure of the data, while QDA showed strong predictive performance for classifying student risk groups.

## Project Outcome

The final outcome is a complete multivariate statistical analysis that combines dimensionality reduction, latent factor identification, and supervised classification. This project demonstrates how multivariate methods can be used to understand complex student mental health and lifestyle data and identify key factors associated with student risk levels.
