############################################
################# PACKAGES #################
############################################
rm(list = ls())

library(RODBC)
library(RMySQL)
library(ggplot2)
library(zoo)
library(data.table)

############################################
################# CONSTANTS ##################
############################################

source("util.R")



############################################
########## MAIN CODE TO INITINITY ##########
############################################

#q <- "SELECT * FROM `products_open`"
q <- "SELECT * FROM `products_open` JOIN products_properties ON products_open.itemId = products_properties.ItemId"
data_open <- dbGetQuery(con,q)
data_open <- data.table(data_open)

platforms <- unique(data_open$globalId)
prices_l <- setNames(data.frame(matrix(ncol = ncol(data_open), nrow = 0)), names(data_open))
prices_ovp <- setNames(data.frame(matrix(ncol = ncol(data_open), nrow = 0)), names(data_open))
prices_l_a <- setNames(data.frame(matrix(ncol = ncol(data_open), nrow = 0)), names(data_open))


for(i in 1:length(platforms)){
  d <-data_open[globalId==platforms[[i]] & listingType != "Auction" & query=="paper mario" & matching == "a" ]
  d_l <- d[type == "l"]
    prices_l[i,] <- d_l[which.min(d_l$convertedCurrentPrice)]
  
  d_ovp <- d[type == "ovp"]
    prices_ovp[i,] <- d_ovp[which.min(d_ovp$convertedCurrentPrice)]
  
  d_l_a <- d[type == "l_a"]
    prices_l_a[i,] <- d_l_a[which.min(d_l_a$convertedCurrentPrice)]
  }

prices[ ,c("globalId", "convertedCurrentPrice", "itemId")]



### calculated price from history
q <- "SELECT * FROM product_price" 
data_price_history <- data.table(dbGetQuery(con,q))

# ### history
# 
# q_history <- "SELECT * FROM `products` JOIN products_properties ON products.itemId = products_properties.ItemId"
# data_history <- data.table(dbGetQuery(con,q_history))
 #

RMySQL::dbDisconnect(con)
