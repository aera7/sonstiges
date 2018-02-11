############################################
################# PACKAGES #################
############################################

library(httr)
library(XML)
library(xml2)
library(RODBC)
library(RMySQL)
library(DBI)

############################################
########## MAIN CODE TO INITINITY ##########
############################################


url = paste("http://svcs.ebay.com/services/search/FindingService/v1?"
            ,"OPERATION-NAME=findItemsByCategory&"
            ,"SERVICE-VERSION=1.0.0&"
            ,"SECURITY-APPNAME=Sebastia-newheave-PRD-f8e35c535-843c594f&"
            ,"RESPONSE-DATA-FORMAT=XML&"
            ,"REST-PAYLOAD&"
            ,"categoryId=10181&"
            ,"paginationInput.entriesPerPage=2&"
            ,"outputSelector=CategoryHistogram"
            ,sep="") 


con <- dbConnect(RMySQL::MySQL(),
                 dbname = "retrolan_newkirk",
                 host = "ams30.siteground.eu",
                 port = 3306,
                 user =  "retrolan_gate",
                 password = "sebastian1990")



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


st = "<?xml version="1.0" encoding="UTF-8"?>"


add_headers(add_headers(.headers = c('X-EBAY-SOA-SECURITY-APPNAME' ='Sebastia-newheave-PRD-f8e35c535-843c594f',X-EBAY-SOA-OPERATION-NAME = "findCompletedItems")))

r <- POST("https://svcs.ebay.com/services/search/FindingService/v1", body = rr, add_headers('X-EBAY-SOA-SECURITY-APPNAME' = 'Sebastia-newheave-PRD-f8e35c535-843c594f', 'X-EBAY-SOA-OPERATION-NAME' =  'findCompletedItems' ))

#X-EBAY-SOA-SECURITY-APPNAME:Sebastia-newheave-PRD-f8e35c535-843c594f
#X-EBAY-SOA-OPERATION-NAME:findCompletedItems


rr = paste('<?xml version="1.0" encoding="UTF-8"?>',
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



r <- GET(url)
status_code(r)
headers(r)
node= xmlTreeParse(content(r, "text"),  asTree = TRUE)


m = node$doc$children$findItemsByCategoryResponse
s =xmlToList(m)

s$searchResult[[37]]$pricingTreatment[[1]]


myconn <-odbcConnect("mydsn", uid="gametopia37@gmail.com", pwd="aardvark")
crimedat <- sqlFetch(myconn, "Crime")
pundat <- sqlQuery(myconn, "select * from Punishment")
close(myconn)
