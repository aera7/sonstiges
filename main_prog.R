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
################# CONSTANTS ##################
############################################

GLOBAL_ID <- 'EBAY-DE'
SECURITY_APPNAME <- 'Sebastia-newheave-PRD-f8e35c535-843c594f'

con <- dbConnect(RMySQL::MySQL(),
                 dbname = "retrolan_newkirk",
                 host = "ams30.siteground.eu",
                 port = 3306,
                 user =  "retrolan_gate",
                 password = "sebastian1990")

############################################
################# SOURCES ##################
############################################

source("xml_queries.R")

############################################
################ FUNCTIONS #################
############################################

dbDisconnectAll <- function(){
  ile <- length(dbListConnections(MySQL())  )
  lapply( dbListConnections(MySQL()), function(x) dbDisconnect(x) )
  cat(sprintf("%s connection(s) closed.\n", ile))
}


## XML Request via POST method
# queries in list queries from xml_queries.R
xml_request <- function(xml_query, verbose = F){
  # do the post request
  # update the body param with the body request you need.
  r <- POST("https://svcs.ebay.com/services/search/FindingService/v1", 
            body = xml_query, 
            add_headers('X-EBAY-SOA-SECURITY-APPNAME' = SECURITY_APPNAME,
                        'X-EBAY-SOA-OPERATION-NAME' =  'findCompletedItems' ,
                        'X-EBAY-SOA-GLOBAL-ID' = GLOBAL_ID,
                        'X-EBAY-SOA-RESPONSE-DATA-FORMAT' = 'XML'))
  if(status_code(r)!=200){
    warning(paste("Bad Response:", " Status Code: ", status_code(r)))
  }
  response <- as_list(content(r, as = "parsed"))[[1]]
  
  if(response$ack != "Success"){
    warning(paste("Unsuccessful Query:", " ACK: ", response$ack))
  }
  if(verbose){
    lapply(response$searchResult, function(x) print(x$title[[1]]))
    print("------------------")
  }
  return(response)
} 

############################################
########## MAIN CODE TO INITINITY ##########
############################################

# connect to DB


# do queries
responses <- lapply(queries, xml_request, verbose=F)

count <- 0
for(i in 1:length(responses)){
  SQL_inserts <- lapply(responses[[i]]$searchResult, function(x){
    paste0("INSERT INTO products VALUES (",
           "\'",x$itemId,"\',",
           "\'",x$title,"\',",
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
           "\'",x$eBayPlusEnabled,"\'",
           ")")})
  ## data entry to db
  lapply(SQL_inserts, function(q) tryCatch(dbSendQuery(con, q), error = function(e) warning(e) ))
  count = count+length(SQL_inserts)
}

RMySQL::dbDisconnect(con)



