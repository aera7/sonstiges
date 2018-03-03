connection <- function() {
  con <- dbConnect(RMySQL::MySQL(),
                   dbname = "retrolan_newkirk",
                   host = "ams30.siteground.eu",
                   port = 3306,
                   user =  "retrolan_gate",
                   password = "sebastian1990")
  return(con)
}