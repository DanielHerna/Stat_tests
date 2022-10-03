
ui <- fluidPage(
  useShinyjs(),
  navbarPage("",
             tabPanel("Difference in proportions",
                      div(id ="Sidebar",sidebarPanel(
                      )),
                      
                      mainPanel(numericInput(inputId = 'Proportion_1',label = 'First proportion',min = 0,
                                             max = 1,value = 0.231),
                                numericInput(inputId = 'Sample_1',label = 'Sample 1 size',min = 1,
                                             value = 1000),
                                numericInput(inputId = 'Proportion_2',label = 'Second proportion',min = 0,
                                             max = 1,value = 0.146),
                                numericInput(inputId = 'Sample_2',label = 'Sample 2 size',min = 1,
                                             value = 1200),
                                radioButtons(inputId="significance", label="Level of significance", 
                                             choices=c(0.1,0.05,0.01),selected = 0.05),
                                textOutput(outputId = 'p_value'))
             ),
             
             tabPanel("Difference in means",
                      div(id ="Sidebar2",sidebarPanel(
                      )),
                      
                      mainPanel(numericInput(inputId = 'Mean_1',label = 'First Mean',value = 46.31),
                                numericInput(inputId = 'SD_1',label = 'First deviation',value = 6.44),
                                numericInput(inputId = 'sampleMean_1',label = 'Sample 1 size',value = 120),
                                numericInput(inputId = 'Mean_2',label = 'Second Mean',value = 42.79),
                                numericInput(inputId = 'SD_2',label = 'Second deviation',value = 7.52),
                                numericInput(inputId = 'sampleMean_2',label = 'Sample 2 size',value = 100),
                                radioButtons(inputId="significanceMean", label="Level of significance", 
                                             choices=c(0.1,0.05,0.01),selected = 0.05))
             )
  )
)