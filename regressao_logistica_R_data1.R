require(ggplot2)
require(caret)
require(predict3d)
require(hnp)

temperatura=c(53,56,57,63,66,67,67,67,68,69,70,70,70,70,72,73,75,75,76,76,78,79,80,81)
y=factor(c(1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,0,0,0))
dados=cbind.data.frame(temperatura,y)

modelo = train(
  form = y ~ .,
  data = dados,
  trControl = trainControl(method = "cv", number =3 ),
  method = "glm",
  family = "binomial"
)
modelo$results[c(2,4)]

modelo=glm(y~temperatura,family=binomial(link=logit))
(ggplot(dados)+aes(temperatura,as.numeric(as.character((y))))+geom_point()
  +geom_smooth(color="blue",method=glm, method.args = list(family = binomial(link="logit")),se=F)
  +labs(y="probabily estimated",x="temperature"))

summary(modelo)
modelo$coefficients

hnp(modelo,residuals=deviance)
