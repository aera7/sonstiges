library(httr)
library(RCurl)
library(XML)

link <- "http://www.ebay.de/itm/Paper-Mario-Nintendo-64-N64-Top-/112754779347"

html <- getURL(link, followlocation = TRUE)
doc<- gsub("[[:space:]]", "", html)
#doc = htmlParse(doc, asText=TRUE)

pos = regexpr('tdclass="imgimg140">', doc)
x2<-substr(doc, pos[1]+attr(pos, "match.length")+8, nchar(doc))
pos = regexpr('style="display', x2)
link2<-substr(x2, 1,pos[1]-2)

html2 <- getURL(link2, followlocation = TRUE)
doc2<- gsub("[[:space:]]", "", html2)

pos =  regexpr('ebay.viewItem.imageCarousel', doc2)
pos2 = regexpr('ebay.viewItem.enlargeLayerv2', doc2)

temp_str=  substr(doc2,pos[1],pos2[1])

link_list = c('')
repeat{
  posi = regexpr('s-l1600', temp_str)
  if(posi[1]==-1){
    break
  }
  link_list = c(link_list, substr(temp_str, posi[1]-17,posi[1]-2) )
  temp_str = substr(temp_str, posi[1]+20, nchar(temp_str))
}

lapply(link_list, function(x) print(paste0("https://i.ebayimg.com/images/g/",x,"/s-l1600.jpg")))
#### TO BE UPLOADED INTO DB RUNNING FUNCTION WHILE IMPORTING?
### HOW to make sure no connection issue raises.


#pos = regexpr('ebay.viewItem.imageCarousel', temp_str)

  
  
  

write(temp_str, file = "data",append = FALSE, sep = " ")

x2<-substr(doc2, pos[1]+attr(pos, "match.length")+8, nchar(doc2))
pos = regexpr('style="display', x2)
link2<-substr(x2, 1,pos[1]-2)



yn8AAOSwi4laW2Dq


# to be implemented => for loop for remaining pictures
 
 
############ FAILED XML APPROACH ############

# parse html
doc = htmlParse(doc2, asText=TRUE)
plain.text <- xpathSApply(doc, "//div[@id='mainContent']", xmlValue)
plain.text <- xpathSApply(doc, "//div[contains(@id, 'PicturePanel')]", xmlValue)


plain.text <- xpathSApply(doc, "//*[contains(text(),'Originalangebot aufrufen')]", xmlValue)
//div[contains(@id, 'PicturePanel')]
plain.text <- xpathSApply(doc, "//*[text()='Originalangebot aufrufen']/parent::*", xmlValue)
cat(paste(plain.text, collapse = "\n"))


############ write down for analysis purposes ############

write(html, file = "data",append = FALSE, sep = " ")
write(doc2, file = "data2",append = FALSE, sep = " ")
write(x2, file = "data3",append = FALSE, sep = " ")

write(html2, file = "data",append = FALSE, sep = " ")
write(doc2, file = "data2",append = FALSE, sep = " ")
write(x2, file = "data3",append = FALSE, sep = " ")

https://www.ebay.de/itm/Paper-Mario-Nintendo-64-N64-Top-/112754779347?nma=true&si=a57MVtptO64J8JkUqfKfNw9Dssc%253D&orig_cvip=true&rt=nc&_trksid=p2047675.l2557


pos = regexpr('pattern', x)