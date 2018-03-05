rsconnect::setAccountInfo(name='roadrunner', token='95A63E11F736DDBEEE82D8CFB3950EC3', secret='LQDOXUcvUcqjU73Pip1y3CgGKFFjjaSD0nR+IHl0')


library(shiny)

# Define UI with external image call
ui <- fluidPage(
  titlePanel("Look at the image below"),
  
  sidebarLayout(sidebarPanel(),
                
                mainPanel(htmlOutput("picture"))))

# Define server with information needed to hotlink image
server <- function(input, output) {
  
  # con <- dbConnect(RMySQL::MySQL(),
  #                  dbname = "retrolan_newkirk",
  #                  host = "ams30.siteground.eu",
  #                  port = 3306,
  #                  user =  "retrolan_gate",
  #                  password = "sebastian1990")
  
  output$picture <-
    renderText({
      c(
        '<img src="',
        "http://thumbs4.ebaystatic.com/m/mZTkk5z4okGZIQ1PvovLeIA/140.jpg",
        '">'
      )
    })
}

shinyApp(ui = ui, server = server)
r <- GET("http://httpbin.org/get")
# 
# 
# 
# ############################################
# ################# PACKAGES #################
# ############################################
# rm(list = ls())
# 
# library(RODBC)
# library(RMySQL)
# 
# 
# 
# ############################################
# ################# CONSTANTS ##################
# ############################################
# 
# 
# 
# 
# ############################################
# ########## MAIN CODE TO INITINITY ##########
# ############################################
# 
# q <- "SELECT * FROM `products` WHERE `title` LIKE '%PAPER%%'"
# r <- dbGetQuery(con,q)
# 
# for(i in 1:nrow(r))){
#   r$galleryURL[[i]]
#   
#   
# }
# 
# library(rsconnect)
# rsconnect::deployApp('path/to/your/app')