############################################
################# PACKAGES #################
############################################
rm(list = ls())

library(RODBC)
library(RMySQL)
library(ggplot2)
library(zoo)

############################################
################# CONSTANTS ##################
############################################

con <- dbConnect(RMySQL::MySQL(),
                 dbname = "retrolan_newkirk",
                 host = "ams30.siteground.eu",
                 port = 3306,
                 user =  "retrolan_gate",
                 password = "sebastian1990")



############################################
########## MAIN CODE TO INITINITY ##########
############################################

q <- "SELECT * FROM `products` WHERE `title` LIKE '%PAPER%%'"
r <- dbGetQuery(con,q)

r$endTime <- as.Date(r$endTime)
r$startTime <- as.Date(r$startTime)

par(mfrow=c(2,2))
hist(r$currentPrice, xlab="Price in Euro")
boxplot(r$currentPrice, ylab="Price in Euro")
plot(r$endTime, r$currentPrice, xlab = "date", ylab="price in Euro")
title("Paper Mario", outer=TRUE)
par(mfrow=c(1,1))

browseURL(r[which.max(r$currentPrice), "viewItemURL"])


RMySQL::dbDisconnect(con)
