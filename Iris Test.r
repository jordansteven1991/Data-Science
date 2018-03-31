library(caret)
##hist(iris$Sepal.Width,xlab = "Width", main = "Iris Petals")
# Split the data
sample <- createDataPartition(iris$Species, p=0.80, list=FALSE)

# Create training data
iris_train <- iris[sample,]

# Create test data
iris_test <- iris[-sample,]

# Summarize the class distribution
percentage <- prop.table(table(iris_train$Species))*100

control <- trainControl(method='cv', number=10)
metric <- 'Accuracy'

# Linear Discriminant Analysis (LDA)
set.seed(101)
fit.lda <- train(Species~., data=iris_train, method='lda', 
                  trControl=control, metric=metric)
				  
# Classification and Regression Trees (CART)
set.seed(101)
fit.cart <- train(Species~., data=iris_train, method='rpart', 
                  trControl=control, metric=metric)

# k-Nearest Neighbors (KNN)
set.seed(101)
fit.knn <- train(Species~., data=iris_train, method='knn', 
                  trControl=control, metric=metric)

# Support Vector Machines (SVM) with a radial kernel
set.seed(101)
fit.svm <- train(Species~., data=iris_train, method='svmRadial', 
                  trControl=control, metric=metric)
				  
set.seed(101)
fit.rf <- train(Species~., data=iris_train, method='ranger', 
                  trControl=control, metric=metric)
				  
# Compare the results of these algorithms
iris.results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))

# Table Comparison
summary(iris.results)

bwplot(iris.results)

iris_prediction <- predict(fit.lda, iris_test)
confusionMatrix(iris_prediction, iris_test$Species)
write.csv(iris_prediction,file = "C:\\Users\\The Ledgend\\Desktop\\R\\iris-output.csv")

