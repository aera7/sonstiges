library(httr)
link <- "http://www.ebay.de/itm/Paper-Mario-Nintendo-64-N64-Top-/112754779347"


whitespace <- " \t\n\r\v\f" # space, tab, newline, 
# carriage return, vertical tab, form feed
x <- c(
  " x y ",           # spaces before, after and in between
  " \u2190 \u2192 ", # contains unicode chars
  paste0(            # varied whitespace     
    whitespace, 
    "x", 
    whitespace, 
    "y", 
    whitespace, 
    collapse = ""
  ),   
  NA                 # missing
)

r <- GET(link)
r


doc2<- gsub("[[:space:]]", "", html)

<td class="img img140">
  
pos = regexpr('tdclass="imgimg140">', doc2)
x2<-substr(doc2, pos[1]+attr(pos, "match.length")+8, nchar(doc2))
pos = regexpr('style="display', x2)
link2<-substr(x2, 1,pos[1]-2)
html2 <- getURL(link2, followlocation = TRUE)
 
 
# load packages
library(RCurl)
library(XML)

# download html
html <- getURL(link, followlocation = TRUE)

# parse html
doc = htmlParse(doc2, asText=TRUE)
plain.text <- xpathSApply(doc, "//div[@id='mainContent']", xmlValue)
plain.text <- xpathSApply(doc, "//div[contains(@id, 'PicturePanel')]", xmlValue)


plain.text <- xpathSApply(doc, "//*[contains(text(),'Originalangebot aufrufen')]", xmlValue)
//div[contains(@id, 'PicturePanel')]
plain.text <- xpathSApply(doc, "//*[text()='Originalangebot aufrufen']/parent::*", xmlValue)
cat(paste(plain.text, collapse = "\n"))

write(html, file = "data",append = FALSE, sep = " ")
write(doc2, file = "data2",append = FALSE, sep = " ")
write(x2, file = "data3",append = FALSE, sep = " ")

write(html2, file = "data",append = FALSE, sep = " ")
write(doc2, file = "data2",append = FALSE, sep = " ")
write(x2, file = "data3",append = FALSE, sep = " ")

mainImgHldr

https://www.ebay.de/itm/Paper-Mario-Nintendo-64-N64-Top-/112754779347?nma=true&si=a57MVtptO64J8JkUqfKfNw9Dssc%253D&orig_cvip=true&rt=nc&_trksid=p2047675.l2557


pos = regexpr('pattern', x)