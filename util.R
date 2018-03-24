############################################
################# CONSTANTS ##################
############################################

GLOBAL_IDS <- c("EBAY-DE", "EBAY-FR", "EBAY-GB", "EBAY-AU")
SECURITY_APPNAME <- 'Sebastia-newheave-PRD-f8e35c535-843c594f'

con <- dbConnect(RMySQL::MySQL(),
                 dbname = "retrolan_newkirk",
                 host = "ams30.siteground.eu",
                 port = 3306,
                 user =  "retrolan_gate",
                 password = "sebastian1990")


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
xml_request <- function(xml_query, verbose = F, API_type, GLOBAL_ID = 'EBAY-DE'){
  # do the post request
  # update the body param with the body request you need.
  r <- POST("https://svcs.ebay.com/services/search/FindingService/v1", 
            body = xml_query, 
            add_headers('X-EBAY-SOA-SECURITY-APPNAME' = SECURITY_APPNAME,
                        'X-EBAY-SOA-OPERATION-NAME' =  API_type,
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
