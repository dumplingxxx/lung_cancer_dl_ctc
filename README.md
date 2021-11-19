## Integration of deep learning radiomics and counts of circulating tumor cells (CTC) improves prediction of outcomes of early stage NSCLC patients 

### 1. Survival curves and log-rank test. The analysis and curve plot are based on a MatLab package named MatSurv (https://github.com/aebergl/MatSurv)

### 1) Use **plot_km_curves_final.m** to show the Kaplan-Meier (K-M) curves built on our fusion recurrence prediction model, CTC measures, and the combination of them. They are group-level recurrence risk stratification;
### 2) Use **plot_the_ctc_false_negative_survival_curves_final.m** to show the patient-level survival curves of all patients and the 6 CTC false negative (FN) patients; 

### 2. Deep learning recurrence prediction

### 1) The network structure of our image-based model is **prediction_model.py**;
### 2) And the trained parameters of this model is saved as **trained_model.pth**; 
### 3) If you want to train a clinical feature based model, can build one using several fully connected layers;
### 4) Loss function for the recurrence prediction is detailed in **loss_surv.py** (can refer to https://github.com/havakv/pycox, it's a great deep learning survival analysis project);
### 5) If you want to build an fusion model, can send the image-based and clinical-based risk scores to a classic Cox regression model. Can use this Python package to do more survival analysis tasks (https://scikit-survival.readthedocs.io/en/stable/index.html);

### Reference
[1] Kaplan, Edward L., and Paul Meier. "Nonparametric estimation from incomplete observations." Journal of the American statistical association 53.282 (1958): 457-481.

[2] Breslow, Norman E. "Analysis of survival data under the proportional hazards model." International Statistical Review/Revue Internationale de Statistique (1975): 45-57.

[3] Paszke, Adam, et al. "Automatic differentiation in pytorch." (2017).

[4] Aerts, H. J. W. L., Wee, L., Rios Velazquez, E., Leijenaar, R. T. H., Parmar, C., Grossmann, P., … Lambin, P. (2019). Data From NSCLC-Radiomics [Data set]. The Cancer Imaging Archive. https://doi.org/10.7937/K9/TCIA.2015.PF0M9REI.

[5] Creed, Jordan H., Travis A. Gerke, and Anders E. Berglund. "MatSurv: Survival analysis and visualization in MATLAB." Journal of Open Source Software 5.46 (2020): 1830.

[6] Kvamme, Håvard, Ørnulf Borgan, and Ida Scheel. "Time-to-Event Prediction with Neural Networks and Cox Regression." Journal of Machine Learning Research 20.129 (2019): 1-30.

[7] Li, Hongming, et al. "Unsupervised machine learning of radiomic features for predicting treatment response and overall survival of early stage non-small cell lung cancer patients treated with stereotactic body radiation therapy." Radiotherapy and Oncology 129.2 (2018): 218-226
