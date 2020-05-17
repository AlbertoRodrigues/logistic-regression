require(ggplot2)
require(caret)
require(hnp)

volume=c(3.7,3.5,1.25,0.75,0.8,0.7,0.6,1.1,0.9,0.9,0.8,0.55,0.6,1.1,0.75,2.3,3.2
         ,0.85,1.7,1.8,0.4,0.95,1.35,1.5,1.6,0.6,1.8,0.95,1.9,1.6,2.7,2.35
         ,1.1,1.1,1.2,0.8,0.95,0.75,1.3)
razao=c(0.825,1.09,2.5,1.5,3.2,3.5,0.75,1.7,0.75,0.45,0.57,2.75,3,2.33,3.75,1.64,1.6,1.415
        ,1.06,1.8,2,1.36,1.35,1.36,1.78,1.5,1.5,1.9,0.95,0.4,0.75,0.03,1.83,2.2,2,3.33
        ,1.9,1.9,1.625)

logvolume=log(volume)
lograzao=log(razao)

y=factor(c(1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,0,0,1,1,1,0,0,1))
resp=cbind(y,1-y)
dados=data.frame(y,volume,razao,logvolume,lograzao)


modelo = train(
  form = y ~ logvolume+lograzao,
  data = dados,
  trControl = trainControl(method = "cv", number =3 ),
  method = "glm",
  family = "binomial"
)
modelo$results[c(2,4)]

ggplot(dados)+aes(volume)+geom_histogram(fill="blue",color="black")
ggplot(dados)+aes(razao)+geom_histogram(fill="blue",color="black")
ggplot(dados)+aes(y,razao)+geom_boxplot(fill="blue",color="black")
ggplot(dados)+aes(y,volume)+geom_boxplot(fill="blue",color="black")

modelo=glm(as.numeric(as.character(y))~logvolume+lograzao,family=binomial(link="logit"))


summary(modelo)
anova(modelo,test="Chisq")
hnp(modelo,residuals=deviance)

(ggplot(dados)+aes(lograzao,as.numeric(as.character((y))))+geom_point()
  +geom_smooth(color="blue",method=glm, method.args = list(family = binomial(link="logit")),se=F)
  +labs(y="probabily estimated",x="temperature"))

(ggplot(dados)+aes(logvolume,as.numeric(as.character((y))))+geom_point()
  +geom_smooth(color="blue",method=glm, method.args = list(family = binomial(link="logit")),se=F)
  +labs(y="probabily estimated",x="temperature"))

predict3d(modelo,radius=0.05)
