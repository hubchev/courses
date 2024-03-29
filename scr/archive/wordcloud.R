install.packages("wordcloud")
library(wordcloud)

#Create a list of words (Random words concerning my work)
a <- c("Cereal","WSSMV","SBCMV","Experimentation","Talk","Conference","Writing", 
       "Publication","Analysis","Bioinformatics","Science","Statistics","Data", 
       "Programming","Wheat","Virus","Genotyping","Work","Fun","Surfing","R", "R",
       "Data-Viz","Python","Linux","Programming","Graph Gallery","Biologie", "Resistance",
       "Computing","Data-Science","Reproductible","GitHub","Script")

#I give a frequency to each word of this list 
b <- sample(seq(0,1,0.01) , length(a) , replace=TRUE) 

#The package will automatically make the wordcloud ! (I add a black background)
par(bg="black") 
wordcloud(a , b , col=terrain.colors(length(a) , alpha=0.9) , rot.per=0.3 )
