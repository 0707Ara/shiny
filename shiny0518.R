library(shiny)

options(shiny.trace = FALSE)

  
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        fileInput("file1", "Choose CSV File", accept = ".count", multiple = TRUE),
        checkboxInput("header", "Header", FALSE)
      ),
      mainPanel(
        p("File Name"),
        uiOutput("control_checkbox"),
        textInput("control_name", "Control group name"),
        # verbatimTextOutput("value"),
        uiOutput("experiment_checkbox"),
        textInput("experiment_name", "Experiment group name"),
        # verbatimTextOutput("value"),
        # tableOutput("contents")
        textOutput("txt"),
        actionButton("createTarget", "Create Target file"),
      )
    )
  )
  
  server <- function(input, output, session) {
    # output$file_name_checkbox <- renderPrint({
    #     input$file1$name
    #     checkboxGroupInput("datasetSelector","Specify the datasets to compare:", choices = fileOptions$currentOptions)
    #   })
        print(getwd())
        output$contents <- renderTable({
          ##input$file1 structure > name, size, type, datapath.
          req(input$file1)
          ext <- tools::file_ext(file$datapath)
          file <- input$file1
          # print(input)
          print('####################')
          validate(need(ext == "count", "Please upload a csv file"))

          upload = list()
          
          # for(i in 1:length(file)){
          #   read.csv(
          #     file[i, 'datapath'],
          #     header = input$header,
          #     sep = "\t"
          #   )
          # }
          # print(upload[[1]])
          return(upload())
        })
        
        # filelist <- reactive ({
        #   filenamelist <- list()
        #   filenamelist <- input$file1$name
        #   print(filenamelist)
        #   return(filenamelist)
        # })
      
        # observeEvent(input$file1, {
        #   fileOptions$currentOptions = list.append(fileOptions$currentOptions, input$file1$datapath)
        # })
        
        output$control_checkbox<-renderUI({
          checkboxGroupInput("controlSelector","Specify the control datasets:", choices = input$file1$name)
        })
        output$value <- renderText({ input$control_name })
        output$experiment_checkbox<-renderUI({
          checkboxGroupInput("experimentSelector","Specify the experiment datasets:", choices = input$file1$name)
        })
        output$value <- renderText({ input$experiment_name })
        
        output$txt <- renderText({
          icons <- paste(input$controlSelector, collapse = ", ")
          # paste("You chose",paste(input$controlSelector, collapse = ", "))
          paste("As a experiment ", paste(input$experimentSelector, collapse = ", "))
        })
        
        targetFile <- reactiveValues(
          data.frame(matrix(ncol=length(input$file1$name),nrow=0, dimnames=list(NULL, c("label","files","condition"))))
        )
        
        # observeEvent(input$createTarget, {
        #   # targetFile <- data.frame(ncol = length(input$file1$name), nrow = 0), c("label","files","condition")
        #   # targetFile <- data.frame(matrix(ncol=length(input$file1$name),nrow=0, dimnames=list(NULL, c("label","files","condition"))))
        #   for(i in 1:length(file)){
        #     targetFile$label <- strsplit(input$file1$name[i], ".")[[1]][1]
        #     targetFile$files <- input$file1$name[i]
        #     
        #     if(input$file1$name[i] %in% input$controlSelector){
        #       targetFile$condition <- input$control_name
        #     }else{
        #       targetFile$condition <- input$experiment_name
        #     }
        #   }
        # })
        
      
    }
  
  shinyApp(ui, server)


fname <- file.choose()

source(file.choose())
