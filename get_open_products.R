############################################
################# PACKAGES #################
############################################
rm(list = ls())

library(httr)
library(XML)
library(xml2)
library(RODBC)
library(RMySQL)


############################################
################# SOURCES ##################
############################################

source("util.R")
source("xml_queries.R")


############################################
########## MAIN CODE TO INITINITY ##########
############################################

# connect to DB

# do queries
for(global_id in GLOBAL_IDS){
  
  responses <- lapply(GLOBAL_QUERIES[[global_id]], xml_request, verbose=F, API_type = 'findItemsAdvanced', GLOBAL_ID = global_id)
  
  count <- 0
  for(i in 1:length(responses)){
    SQL_inserts <- lapply(responses[[i]]$searchResult, function(x){
      paste0("INSERT INTO products_open VALUES (",
             "\'",x$itemId,"\',",
             "\'",gsub("'","''", GLOBAL_QUERIES_NAMES[[global_id]][[i]]),"\',",
             "\'",gsub("'","''",x$title),"\',",
             "\'",x$globalId,"\',",
             "\'",x$primaryCategory$categoryId,"\',",
             "\'",x$primaryCategory$categoryName,"\',",
             "\'",x$galleryURL,"\',",
             "\'",x$viewItemURL,"\',",
             "\'",x$paymentMethod,"\',",
             "\'",x$autoPay,"\',",
             "\'",x$postalCode,"\',",
             "\'",x$location,"\',",
             "\'",x$country,"\',",
             "\'",x$shippingInfo$shippingServiceCost,"\',",
             "\'",x$shippingInfo$shippingType,"\',",
             "\'",x$shippingInfo$shipToLocations,"\',",
             "\'",x$sellingStatus$currentPrice,"\',",
             "\'",x$sellingStatus$convertedCurrentPrice,"\',",
             "\'",x$sellingStatus$bidCount,"\',",
             "\'",x$sellingStatus$sellingState,"\',",
             "\'",x$listingInfo$bestOfferEnabled,"\',",
             "\'",x$listingInfo$buyItNowAvailable,"\',",
             "\'",x$listingInfo$startTime,"\',",
             "\'",x$listingInfo$endTime,"\',",
             "\'",x$listingInfo$listingType,"\',",
             "\'",x$listingInfo$gift,"\',",
             "\'",x$condition$conditionId,"\',",
             "\'",x$condition$conditionDisplayName,"\',",
             "\'",x$isMultiVariationListing,"\',",
             "\'",x$topRatedListing,"\',",
             "\'",x$eBayPlusEnabled,"\',",
             "\'\'",
             ")" )})
    ## data entry to db
    lapply(SQL_inserts, function(q) tryCatch(dbSendQuery(con, q), error = function(e) warning(e) ))
    count = count+length(SQL_inserts)
  }
}

RMySQL::dbDisconnect(con)



