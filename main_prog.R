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


############################################
################# SOURCES ##################
############################################

source("function_holder.R")
source("xml_querries.R")
source("http_querries.R")

############################################
########## MAIN CODE TO INITINITY ##########
############################################


## XML Request via POST method

ss = paste('<?xml version="1.0" encoding="UTF-8"?>',
           '<findCompletedItemsRequest xmlns=\"http://www.ebay.com/marketplace/search/v1/services\">',
           "<keywords>iPhone</keywords>",
           "<categoryId>9355</categoryId>",
           "<itemFilter>",
           "<name>Condition</name>",
           "<value>1000</value>",
           "</itemFilter>",
           "<itemFilter>",
           "<name>FreeShippingOnly</name>",
           "<value>true</value>",
           "</itemFilter>",
           "<itemFilter>",
           "<name>SoldItemsOnly</name>",
           "<value>true</value>",
           "</itemFilter>",
           "<sortOrder>PricePlusShippingLowest</sortOrder>",
           "<paginationInput>",
           "<entriesPerPage>2</entriesPerPage>",
           "<pageNumber>1</pageNumber>",
           "</paginationInput>",
           "</findCompletedItemsRequest>",
           sep = "")

# update the body param with the body request you need.
r <- POST("https://svcs.ebay.com/services/search/FindingService/v1", 
          body = paper_mario, 
          add_headers('X-EBAY-SOA-SECURITY-APPNAME' = 'Sebastia-newheave-PRD-f8e35c535-843c594f',
                      'X-EBAY-SOA-OPERATION-NAME' =  'findCompletedItems' ,
                      'X-EBAY-SOA-GLOBAL-ID' = 'EBAY-DE' ))


status_code(r)
headers(r)
node= xmlTreeParse(content(r, "text"),  asTree = TRUE)
# loading time related error => exec line by line ??
m = node$doc$children$findCompletedItemsResponse
s =xmlToList(m)
########## overview STAART ##########
View(s)
s$searchResult[[15]]$pricingTreatment[[1]]
########## OVERVIEW END ##########






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


myconn <-odbcConnect("mydsn", uid="gametopia37@gmail.com", pwd="aardvark")
crimedat <- sqlFetch(myconn, "Crime")
pundat <- sqlQuery(myconn, "select * from Punishment")
close(myconn)
