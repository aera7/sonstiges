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

q_ids <- "SELECT DISTINCT query FROM `products`"
r_ids <- dbGetQuery(con,q_ids)

weight_time <- function(days_passed){
  1/(1+exp(-(3.5-0.1*days_passed)))
}

prices <- data.frame("id", "rating", "calculated_price")

price_calc <- function(id){
  q <- paste0("SELECT * FROM `products` WHERE `query` = '", id,"'")
  
  r <- dbGetQuery(con,q)
  
  r$endTime <- as.Date(r$endTime)
  r$startTime <- as.Date(r$startTime)
  r$dfromnow <- Sys.Date()-r$endTime
  r$weight <- weight_time(as.numeric(r$dfromnow))
  
  insert_query <- "INSERT INTO product_price (query, condition_own, price, 0_quant, 20_quant, 90_quant, 100_quant, amount) VALUES "
  for(i in (10:2)){
    
    idx <- which(r$condition_own>=i-1 & r$condition_own <= i+1 & r$matching != "b")
    data <- r[idx,]
    
    if(nrow(data)<1){
      next
    }
    quants <- quantile(data$currentPrice, c(0, 0.2, 0.9, 1))
    weighted_price <- round(sum(data$weight*data$currentPrice)/sum(data$weight),2)
    insert_query <- paste0(insert_query," (\'",id,"\',",i,",",weighted_price,",", quants[1],",", quants[2],",", quants[3],",",quants[4],",", nrow(data),"),")
  }
  insert_query <- paste0(substr(insert_query, 1, nchar(insert_query)-1), ";")
  tryCatch(dbSendQuery(con, insert_query), error = function(e) warning(e))
} 


lapply(r_ids, price_calc)
# 
# par(mfrow=c(2,2))
# hist(r$currentPrice, xlab="Price in Euro")
# boxplot(r$currentPrice, ylab="Price in Euro")
# plot(r$endTime, r$currentPrice, xlab = "date", ylab="price in Euro")
# title("Paper Mario", outer=TRUE)
# par(mfrow=c(1,1))

# browseURL(r[which.max(r$currentPrice), "viewItemURL"])


##############################





RMySQL::dbDisconnect(con)
