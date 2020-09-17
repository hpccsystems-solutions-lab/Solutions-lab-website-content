# HPCC Systems Machine Learning Library

HPCC Systems Machine Learning Library provides a wide range of High Performance Machine Learning (ML) algorithms by utilizing the distributed parallel computing capabilities of Big Data processing platform HPCC Systems. Each ML algorithms is packaged as an independent bundle that can be easily installed and imported to the local environment.

# Algorithms

Currently supported Machine Learning algorithms include:

- Classification: Logistic Regression, Support Vector Machines(SVM) classifier, General Linear Model classifier
- Regression: Linear Regression, Support Vector Machines(SVM) regressor, General Linear Model regressor
- Tree-based algorithms: Decision Trees, Random Forests, Gradient-boosted Trees and Boosted Forest
- Clustering: K-Means, DBSCAN
- Deep Learning: Generalized Neural Networks (GNN), 
- Nature Language Processing: TextVectors

Other supported Machine Learning utilities include:

<!-- - Preprocessing -->
- Model Evaluation
- Summray Statistics

# Using HPCC Systems Machine Learning Library

Below are the general steps to use HPCC Systems Machine Learning Library.

## STEP 1 : INSTALLATION

Be sure [HPCC Systems Clienttools](https://hpccsystems.com/download#Downloads) is installed on your system.

1. Install HPCC Systems ML_Core
From your clienttools/bin directory run: 

  ```shell
  ecl bundle install https://github.com/hpcc-systems/ML_Core.git
  ```

2. Install the HPCC Systems Machine Learning bundle(s). 
For example, Run below code to install LearningTrees Bundle:

  ```shell
  ecl bundle install https://github.com/hpcc-systems/LearningTrees.git
  ```

> Note that for PC users, ecl bundle install must be run as Admin.  Right click on the command icon and select "Run as administrator" when you start your command window.

## STEP 2 : DATA PREPRATION

[NumericField](https://github.com/hpcc-systems/ML_Core/blob/master/Types.ecl) is the standard training data format for most Bundles.

Below is an example of how to transform your data to NumericField format before feeding into Machine Learning Bundles:

```java
IMPORT ML_Core.Types;

// Transform data Raw_with_id to training dataset ML_data in NumericField format
ML_Core.ToField(Raw_with_id, ML_data);

```

> Note: id is a reqired field in the data to use ML_Core.ToField() Function. 

## STEP 3 : MODEL TRAINING

Now the training data is ready. It's time to train a machine learning model.
Here is an example to train K-Means model.

```java

//Setup the model
Pre_Model := KMeans.KMeans(Max_iterations, Tolerance);
//Train the model
Model := Pre_Model.Fit( ML_Data, Centroids);

```









