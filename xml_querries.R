queries = list()



queries["paper_mario"] <-
  paste(
    '<?xml version="1.0" encoding="UTF-8"?>',
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
    sep = ""
  )


queries["diddy_kong_racing"] <-
  paste(
    '<?xml version="1.0" encoding="UTF-8"?>',
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
    sep = ""
  )
