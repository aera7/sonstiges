condition <- list();
condition["New"] <- 1000
condition["New_other"] <-1500
condition["New_defect"] <-1750
condition["New_refurb"] <-2000
condition["Man_refurb"] <-2500
condition["used"] <-3000
condition["verygood"] <-4000
condition["good"] <-5000
condition["Acceptable"] <- 6000
condition["NotWorking"] <- 7000


get_query <- function(keyword, category_id){
  paste0("<?xml version='1.0' encoding=\"UTF-8\"?>",
         "<findCompletedItemsRequest xmlns=\"http://www.ebay.com/marketplace/search/v1/services\">",
         "<categoryId>",category_id,"</categoryId>",
         "<keywords>",keyword,"</keywords>",
         # "<aspectFilter>
         #   <aspectName>Regionalcode</aspectName>
         #   <aspectValueName>PAL</aspectValueName>
         # </aspectFilter>",
         "<aspectFilter>
          <aspectName>Plattform</aspectName>
          <aspectValueName>Nintendo 64</aspectValueName>
          </aspectFilter>",
         "<itemFilter>",
         "<name>LocatedIn</name>",
         "<value>DE</value>",
         "</itemFilter>",
         # "<itemFilter>",
         # "<name>Condition</name>",
         # "<value>4000</value>",
         # "<value>",condition["verygood"],"</value>",
         # "<value>",condition["good"],"</value>",
         # "<value>",condition["acceptable"],"</value>",
         # "</itemFilter>",
         "<itemFilter>",
         "<name>SoldItemsOnly</name>",
         "<value>true</value>",
         "</itemFilter>",
         "<sortOrder>PricePlusShippingHighest</sortOrder>",
         "<paginationInput>",
         "<entriesPerPage>200</entriesPerPage>",
         "<pageNumber>1</pageNumber>",
         "</paginationInput>",
         "</findCompletedItemsRequest>")
}


keywords <- list(c("paper mario","paper,mario"),
                 c("banjo tooie","banjo,tooie -(kazooie)"),
                  c("conker", "Conker"),
                  c("mario party 3","mario,party,3 -(1,2)")
                 # "mario,party,2 -(1,3,OVP)"
                 )

queries <- lapply(keywords, function(keyword) get_query(keyword[[2]], category_id = 139973))
names(queries) <- keywords
names_q <-lapply(keywords, function(keyword) keyword[[1]])

