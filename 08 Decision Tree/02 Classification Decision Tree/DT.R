# importing Dataset
df <- read.csv('Movie_classification.csv')
View(df)

### Data Pre-processing
summary(df)

# missing value imputation
df$Time_taken[is.na(df$Time_taken)] <- mean(df$Time_taken,na.rm = TRUE)


# Train Test Split
library(caTools)
set.seed(0)
split =sample.split(df,SplitRatio = 0.8)
trainc = subset(df,split == TRUE)
testc = subset(df,split == FALSE)


library(rpart)
library(rpart.plot)


# Classification tree model on train set
classtree <- rpart(formula = Start_Tech_Oscar~., data = trainc, method = 'class', control = rpart.control(maxdepth = 3))

#Plot the decision Tree
rpart.plot(classtree, box.palette="RdBu", digits = -3)

#Predict value at any point
testc$pred <- predict(classtree, testc, type = "class")

table(testc$Start_Tech_Oscar,testc$pred)

# overall accuracy
56/106