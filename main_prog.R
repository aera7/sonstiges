############################################
################# PACKAGES #################
############################################
rm(list = ls())

library(httr)
library(XML)
library(xml2)
library(RODBC)
library(RMySQL)
library(DBI)
library(jsonlite)


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

source("xml_querries.R")
# source("http_querries.R")

############################################
################ FUNCTIONS #################
############################################


## XML Request via POST method
# queries in list queries from xml_queries.R
xml_request <- function(xml_query, query_name, verbose = F){
  # do the post request
  # update the body param with the body request you need.
  r <- POST("https://svcs.ebay.com/services/search/FindingService/v1", 
            body = xml_query, 
            add_headers('X-EBAY-SOA-SECURITY-APPNAME' = SECURITY_APPNAME,
                        'X-EBAY-SOA-OPERATION-NAME' =  'findCompletedItems' ,
                        'X-EBAY-SOA-GLOBAL-ID' = GLOBAL_ID,
                        'X-EBAY-SOA-RESPONSE-DATA-FORMAT' = 'XML'))
  if(status_code(r)!=200){
    warning(paste("Bad Response:", query_name, " Status Code: ", status_code(r)))
  }
  response <- as_list(content(r, as = "parsed"))[[1]]
  
  if(response$ack != "Success"){
    warning(paste("Unsuccessful Query:", query_name, " ACK: ", response$ack))
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
responses <- lapply(queries, xml_request, verbose=T)



myconn <-odbcConnect("mydsn", uid="gametopia37@gmail.com", pwd="aardvark")

SQL_inserts <- lapply(response$searchResult, function(x){
  paste0("INSERT INTO products VALUES (",
         "`",x$itemId,"`,",
         "`",x$title,"`,",
         "`",x$globalId,"`,",
         "`",x$primaryCategory$categoryId,"`,",
         "`",x$primaryCategory$categoryName,"`,",
         "`",x$galleryURL,"`,",
         "`",x$viewItemURL,"`,",
         "`",x$paymentMethod,"`,",
         "`",x$autoPay,"`,",
         "`",x$postalCode,"`,",
         "`",x$location,"`,",
         "`",x$country,"`,",
         "`",x$shippingInfo$shippingServiceCost,"`,",
         "`",x$shippingInfo$shippingType,"`,",
         "`",x$shippingInfo$shipToLocations,"`,",
         "`",x$sellingStatus$currentPrice,"`,",
         "`",x$sellingStatus$convertedCurrentPrice,"`,",
         "`",x$sellingStatus$bidCount,"`,",
         "`",x$sellingStatus$sellingState,"`,",
         "`",x$listingInfo$bestOfferEnabled,"`,",
         "`",x$listingInfo$buyItNowAvailable,"`,",
         "`",x$listingInfo$startTime,"`,",
         "`",x$listingInfo$endTime,"`,",
         "`",x$listingInfo$listingType,"`,",
         "`",x$listingInfo$gift,"`,",
         "`",x$condition$conditionId,"`,",
         "`",x$condition$conditionDisplayName,"`,",
         "`",x$isMultiVariationListing,"`,",
         "`",x$topRatedListing,"`,",
         "`",x$eBayPlusEnabled,"`",
         ")")})

lapply(list, function)
## tables to be updated
## iterating through all itimes taking sorting out most important fields
## to be defined which field of the reponse should be dropped

dbListTables(con)
dbReadTable(con, "")
dbDisconnect(con)
dbGetQuery(con, "SELECT * FROM mtcars")

add_headers(a = 1, b = 2)
add_headers(.headers =  c(a = "1", b = "2"))
GET("http://httpbin.org/headers")
# Add arbitrary headers
GET("http://svcs.ebay.com/services/search/FindingService/v1",
    add_headers(version = version$version.string))


#add_headers(add_headers(.headers = c('X-EBAY-SOA-SECURITY-APPNAME' ='Sebastia-newheave-PRD-f8e35c535-843c594f',X-EBAY-SOA-OPERATION-NAME = "findCompletedItems")))










r <- GET(url)
s$searchResult[[37]]$pricingTreatment[[1]]


crimedat <- sqlFetch(myconn, "Crime")
pundat <- sqlQuery(myconn, "select * from Punishment")
close(myconn)
