server <-function(input, output, session) {
  
  shinyjs::hide(id = "Sidebar")
  shinyjs::hide(id = "Sidebar2")
  
  Diff_scores<-reactive({
    
    
    z_test<-prop.test(x = c(round(input$Sample_1*input$Proportion_1,0), round(input$Sample_2*input$Proportion_2,0)),
                      n = c(input$Sample_1,input$Sample_2),conf.level = 1-as.numeric(input$significance))
  })
  
  output$p_value<-renderText({
    
    results<-Diff_scores()
    Z_score<-qnorm(1-(as.numeric(input$significance)/2))
    p_hat<-(input$Proportion_1*input$Sample_1+input$Proportion_2*input$Sample_2)/(input$Sample_1+input$Sample_2)
    required_difference<-Z_score*sqrt(p_hat*(1-p_hat))*sqrt((1/input$Sample_1) + (1/input$Sample_2))
    
    if (results$p.value<as.numeric(input$significance)) {
      msg<-paste0('With a P-value of ',round(results$p.value,4),' proportions are statistically different with a confidence interval from ',
                  round(results$conf.int[1],4),' to ',round(results$conf.int[2],4),' and a margin error of ',
                  abs(round((results$estimate[1]-results$estimate[2])-results$conf.int[2],4)),' units')
    }
    
    
    
    if (results$p.value>as.numeric(input$significance)) {
      msg<-paste0('With a P-value of ',round(results$p.value,4),' proportions are not statistically different, the required difference to be statistically
                  different is at least ',round(required_difference,4))
    }
    
    return(msg)
    
  })
  
  Diff_means<-reactive({
    
    t_value<-abs(input$Mean_1-input$Mean_2)/sqrt((input$SD_1*input$SD_1/input$sampleMean_1) + ((input$SD_2*input$SD_2)/input$sampleMean_2))
    
  })
  
}