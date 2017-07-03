#************************************************
#                                                    
#  Trevor Yau
#  
#  Last Revision: 06/18/17
#                                                    
#
#*****************************************************


rm(list=ls())
library(ggplot2)
library(plyr)
library(R2jags)
library(ggthemes)
library(reshape2)
#install.packages('Rcpp')
library(Rcpp)
#install.packages('gganimate')
library(gganimate)
library(devtools)
#install.packages('RCurl')
library(RCurl)
#install.packages('httr')
library(httr)



#Reading in Data
setwd("C:/Users/Trevor/Desktop/R Programs/Personal Projects/Basketball/NBA Scoring")
score.dat<-read.csv('NBA-Scoring.csv', header=TRUE, as.is=TRUE, strip.white=TRUE)
colnames(score.dat)[1]<-'Team'
head(score.dat)

count(score.dat$Team) #verifying teams names over course of 10 years

score.dat$Win_condition <- NA
score.dat$Win_condition[score.dat$Wins >= 10 & score.dat$Wins <= 30] <- '10 - 30'
score.dat$Win_condition[score.dat$Wins >= 31 & score.dat$Wins <= 50] <- '31 - 50'
score.dat$Win_condition[score.dat$Wins >= 51 & score.dat$Wins <= 70] <- '51 - 70'
score.dat$Win_condition[score.dat$Wins >= 71 & score.dat$Wins <= 82] <- '71 - 82'


#graph<-ggplot(data=score.dat,
#              aes(x=Points.Allowed, y=Points.Scored, color=Division))+
#  ggtitle("Comparison of Points Allowed vs Scored")+
#  xlab("Points Allowed")+ylab("Points Scored")+
#  facet_grid(~ Year)+
#  scale_colour_manual(name='Division', values=c('Blue','Green','Red','Yellow','Violet','Orange'))+
#  geom_point()+ #geom_point adds the points to the graph
#  theme_fivethirtyeight()
#graph

count(score.dat$Division)

unique(score.dat$Year)

#for(j in unique(score.dat$Year)){
# dev.new()
#  print(ggplot(score.dat[score.dat$Year==j,], aes(x=Points.Allowed, y=Points.Scored, color=Division))
#         + geom_point()+
#         ggtitle("Comparison of Points Allowed vs Scored")+
#         xlab("Points Allowed")+xlim(5500,10000)+
#         ylab("Points Scored")+ylim(5500,10000)+
#         scale_colour_manual(name='Division', values=c('Blue','Green','Red','Yellow','Violet','Orange'))+
#         theme_fivethirtyeight()
#         )
#}


score.plot<-ggplot(score.dat, aes(Points.Allowed, Points.Scored, size=Win_condition, color = Division, frame = Year)) +
  geom_point() +
  xlab("Points Allowed")+xlim(7000,10000)+
  ylab("Points Scored")+ylim(7000,10000)+
  ggtitle("Points Scored v Points Allowed Season: ")+
  scale_colour_manual(name='Division', values=c('dodgerblue4','red1','chartreuse4','orchid2','yellow1','orange1'))+
  theme(axis.title=element_text(size=10))+
  theme(plot.title = element_text(face="bold", size=16)) +
  theme_minimal()

#theme_fivethirtyeight()
score.plot
#installing necessary packages for animation
#install.packages("installr")
library(installr)
#install.ImageMagick()
  
imconvertstring<-"\"C:\\Program Files\\ImageMagick-7.0.6-Q16\\convert.exe\" -delay 1x%d %s*.png %s.%s" #specifies path for R to find convert.exe program
gganimate(score.plot,width=800, height=616,"NBA Scoring Years.gif")

