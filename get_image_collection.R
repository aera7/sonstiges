library(httr)
library(RCurl)
library(XML)
############################################
################# CONSTANTS ##################
############################################

con <- dbConnect(RMySQL::MySQL(),
                 dbname = "retrolan_newkirk",
                 host = "ams30.siteground.eu",
                 port = 3306,
                 user =  "retrolan_gate",
                 password = "sebastian1990")
dbDisconnectAll <- function(){
  ile <- length(dbListConnections(MySQL())  )
  lapply( dbListConnections(MySQL()), function(x) dbDisconnect(x) )
  cat(sprintf("%s connection(s) closed.\n", ile))
}


#############################################

links <- dbGetQuery(con, "SELECT viewItemURL, itemId FROM products where images = ''")
# link <- "http://www.ebay.de/itm/Paper-Mario-Nintendo-64-N64-Top-/112754779347"

idx <- 1:nrow(links)

getImages <- function(i){
  viewItemURL = links[i, 1]
  itemID = links[i, 2]
  
  html <- getURL(viewItemURL, followlocation = TRUE)
  doc<- gsub("[[:space:]]", "", html)
  #doc = htmlParse(doc, asText=TRUE)
  
  pos = regexpr('tdclass="imgimg140">', doc)
  if(pos == -1){
    return("")
  }
  x2<-substr(doc, pos[1]+attr(pos, "match.length")+8, nchar(doc))
  pos = regexpr('style="display', x2)
  link2<-substr(x2, 1,pos[1]-2)
  
  html2 <- getURL(link2, followlocation = TRUE)
  doc2<- gsub("[[:space:]]", "", html2)
  
  pos =  regexpr('ebay.viewItem.imageCarousel', doc2)
  pos2 = regexpr('ebay.viewItem.enlargeLayerv2', doc2)
  
  temp_str=  substr(doc2,pos[1],pos2[1])
  
  link_list = list()
  repeat{
    posi = regexpr('s-l1600', temp_str)
    if(posi[1]==-1){
      break
    }
    link_list = c(link_list, substr(temp_str, posi[1]-17,posi[1]-2) )
    temp_str = substr(temp_str, posi[1]+20, nchar(temp_str))
  }
  
  #insert to DB
  q = paste0("UPDATE products SET images = '", paste(link_list, collapse=';'),"' WHERE itemId = ", itemID)
  tryCatch(dbSendQuery(con, q), error = function(e) warning(e) )
  # lapply(link_list, function(x) print(paste0("https://i.ebayimg.com/images/g/",x,"/s-l1600.jpg")))
}


tmp <- lapply(idx, getImages)
### HOW to make sure no connection issue raises.

# write(temp_str, file = "data",append = FALSE, sep = " ")

dbDisconnectAll()
