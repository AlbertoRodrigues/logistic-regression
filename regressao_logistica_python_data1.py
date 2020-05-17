from sklearn.model_selection import KFold,cross_val_score,cross_validate
from sklearn.linear_model import LogisticRegression
from plotnine import *
import numpy as np
import pandas as pd

temperatura=np.array([53,56,57,63,66,67,67,67,68,69,70,70,70,70,72,73,75,75,76,76,78,79,80,81]).reshape(-1,1)
y=np.array([1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,0,0,0])
dados=pd.DataFrame({"temperatura":temperatura.flatten(),"y":y})
modelo=LogisticRegression()

part=KFold(n_splits=3)
resultados=cross_validate(modelo,temperatura,y,cv=part,scoring=["accuracy","roc_auc"])
resultados["test_accuracy"]
resultados["test_roc_auc"]
modelo.fit(temperatura,y)
modelo.intercept_
modelo.coef_
