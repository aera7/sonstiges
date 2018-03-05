library(httr)
library(RCurl)
library(XML)

link <- "http://www.ebay.de/itm/Paper-Mario-Nintendo-64-N64-Top-/112754779347"

html <- getURL(link, followlocation = TRUE)
doc2<- gsub("[[:space:]]", "", html)

pos = regexpr('tdclass="imgimg140">', doc2)
x2<-substr(doc2, pos[1]+attr(pos, "match.length")+8, nchar(doc2))
pos = regexpr('style="display', x2)
link2<-substr(x2, 1,pos[1]-2)

link2

html2 <- getURL(link2, followlocation = TRUE)

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