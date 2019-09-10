# installing packages
install.packages("ggplot2")
library("ggplot2")

data(iris)

set.seed(42)

indexes <- sample(
  x = 1:150,
  size = 100
)

#inspect the random indexes
print(indexes)

train <- iris[indexes,]

test <- iris[-indexes,]

install.packages("tree")
library(tree)

model <- tree(
  formula = Species ~ .,
  data = train
)

summary(model)

plot(model)
text(model)

install.packages("RColorBrewer")
library(RColorBrewer)

palette <- brewer.pal(3, "Set2")

plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  pch = 19,
  col = palette[as.numeric(iris$Species)],
  main = "Iris Petal Length vs Width",
  xlab = "Petal Length (cm)",
  ylab = "Petal Width (cm)"
)

partition.tree(
  tree = model,
  label = "Species",
  add = TRUE
)

predictions <- predict(
  object = model,
  newdata = test, 
  type = "class"
)

table(
  x = predictions,
  y = test$Species
)

install.packages("caret")
library(caret)
install.packages("lattice")
library(ggplot2)
library(lattice)
library(caret)
install.packages("e1071")
library(e1071)

confusionMatrix(
  data = predictions,
  reference = test$Species
)

save(model, file = "Tree.RData")

