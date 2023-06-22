# Generate data
x = rnorm(1000)

# plot x
plot(density(x))

# Read the documenttion of the "t.test" function
?t.test

# On sample t test (H_0: x=0)
t.test(x)

# On sample t test (H_0: x=1)
t.test(x, mu = 1)

# Generate data
y = 1+rnorm(1000)

# plot both variables
plot(density(y))
lines(density(x))

# On sample t test (H_0: x=0)
t.test(y)

# On sample t test (H_0: x=1)
t.test(y, mu = 1)

# two-sided t test (H_0: x=y)
t.test(x,y)

# save the results of the test
ttest <- t.test(x,y)

# what is saved
names(ttest)

# just look at the t statistic
ttest$statistic



