
get_query <- function(keyword, category_id){
  paste0("<?xml version='1.0' encoding=\"UTF-8\"?>",
         "<findCompletedItemsRequest xmlns=\"http://www.ebay.com/marketplace/search/v1/services\">",
         "<categoryId>",category_id,"</categoryId>",
         "<keywords>",keyword,"</keywords>",
         "<itemFilter>",
         "<name>LocatedIn</name>",
         "<value>DE</value>",
         "</itemFilter>",
         "<itemFilter>",
         "<name>Condition</name>",
         "<value>4000</value>",
         "</itemFilter>",
         "<itemFilter>",
         "<name>SoldItemsOnly</name>",
         "<value>true</value>",
         "</itemFilter>",
         "<sortOrder>PricePlusShippingHighest</sortOrder>",
         "<paginationInput>",
         "<entriesPerPage>10</entriesPerPage>",
         "<pageNumber>1</pageNumber>",
         "</paginationInput>",
         "</findCompletedItemsRequest>")
}


keywords <- list("paper,mario -OVP", "paper,mario,anleitung -OVP", "paper,mario,OVP",
                 "diddy,kong,racing -OVP")

queries <- lapply(keywords, function(keyword) get_query(keyword, category_id = 139973))
names(queries) <- keywords

