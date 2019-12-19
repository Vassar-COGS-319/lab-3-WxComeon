# model selection ####

# suppose we have data from an experiment like this:
# mean RT correct = 250ms
# mean RT incorrect = 246ms
# accuracy = 0.80

# try to fit this data with both models by adjusting the parameters of the model
# HINT: you can speed up your parameter search by using a small number of samples
# initially, and then increasing the samples as you get closer to a viable set
# of parameters.
# 2nd HINT: Don't adjust the sdrw parameter of the random.walk.model or the criterion
# paramter of the accumulator model.

# Testing the random walk model
rdn.walk.test <- random.walk.model(1000,drift=0.02,sdrw=0.48,criterion=7.9)
walk.correct.data <- rdn.walk.test %>% filter(correct==TRUE)
mean(correct.data$rt)
walk.incorrect.data <- rdn.walk.test %>% filter(correct==FALSE)
mean(incorrect.data$rt)
sum(rdn.walk.test$correct) / length(rdn.walk.test$correct)

# Testing the accumulator model
acc.test <- accumulator.model(1000, rate.1=47, rate.2=43,criterion=5.3)
acc.correct.data <- acc.test %>% filter(correct==TRUE)
mean(correct.data$rt)
acc.incorrect.data <- acc.test %>% filter(correct==FALSE)
mean(incorrect.data$rt)
sum(acc.test$correct) / length(acc.test$correct)

# You don't need to get a perfect match. Just get in the ballpark. 

# Can both models do a reasonable job of accounting for the mean RT and accuracy? Report the
# results of your efforts:

# random walk model: (run a couple of times) and a pretty fit prediction
# mean RT correct = 252.6ms
# mean RT incorrect = 243.9ms
# accuracy = 0.797

# the accumulator model: (run a couple of times) and a pretty fit prediction
# mean RT correct = 252.6ms
# mean RT incorrect = 243.9ms
# accuracy = 0.847

# Using the parameters that you found above, plot histograms of the distribution of RTs
# predicted by each model. Based on these distributions, what kind of information could
# we use to evaluate which model is a better descriptor of the data for the experiment?
# Describe briefly how you might make this evaluation.

hist(walk.correct.data$rt, xlab="Decision time", xlim=c(0,max(walk.correct.data$rt)))
hist(walk.incorrect.data$rt, xlab="Decision time",xlim=c(0,max(walk.incorrect.data$rt)))
hist(acc.correct.data$rt, xlab="Decision time", xlim=c(0,max(acc.correct.data$rt)))
hist(acc.incorrect.data$rt, xlab="Decision time",xlim=c(0,max(acc.incorrect.data$rt)))

# These two models are both able to fit the data pretty well. The random walk model
# predicts that people's decision time both in correct and incorrect trials would 
# be skewed to the left. People are fast in responding to most trials, but in some 
# trials they are slow.The RW model also predicts a higher variability/standard deviation.
# On the other hand, the accumulator model predicts that people's 
# response time is normally distributed, centered around an average point. The accumulator
# model with the rate parameter that uses exponential seems to sample and gain a fairly 
# steady evidence each time compared to the random walk model.

# In order to evaluate which model is a better descriptor, we need behavioral data on 
# whether people tend to have a right skewed distribution or a normal distribution
# of response time. 
