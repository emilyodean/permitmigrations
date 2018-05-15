library(shiny)
library(chorddiag)

shinyServer(function(input, output) {
  
  source("loaddata.R")
  
  tol18rainbow <- c("#771155", "#AA4488", "#CC99BB", "#114477", "#4477AA", "#77AADD", "#117777", "#44AAAA", "#77CCCC", "#777711", "#AAAA44", "#DDDD77", "#774411", "#AA7744", "#DDAA77", "#771122", "#AA4455", "#000000")

  
  output$distPlot <- renderChorddiag({
    
    if (input$type == "All transfer types") {
      df_1985 = df_1985_all; df_1995 = df_1995_all; df_2005 = df_2005_all; df_2015 = df_2015_all;
    } else if (input$type == "Gifted and traded permits") {
      df_1985 = df_1985_GT; df_1995 = df_1995_GT; df_2015 = df_2015_GT; #no data for 2005
    } else if (input$type == "Migrated permits (change of address)") {
      df_1985 = df_1985_MV; df_1995 = df_1995_MV; df_2015 = df_2015_MV; #no data for 2005
    } else if (input$type == "Cancelled Permits") {
      df_1985 = df_1985_CL; df_1995 = df_1995_CL; df_2005 = df_2005_CL; df_2015 = df_2015_CL;
    }
    
    if (input$select_year == "1975-1985") {
      data = df_1985
    } else if (input$select_year == "1985-1995") {
      data = df_1995
    } else if (input$select_year == "1995-2005") {
      data = df_2005
    } else if (input$select_year == "2005-2016") {
      data = df_2015
    }
    
    if(input$bp == TRUE) {
      bpdata <- data
      diag(bpdata) <- 0
      chorddiag(bpdata, showTicks = F, groupnameFontsize = 12, groupnamePadding = 8, margin = 120, groupPadding = 4, tooltipUnit = " Permits", groupColors = tol18rainbow, clickGroupAction = "groupFade(d, fadeLevel);")
    } else if (input$bp == FALSE) {
      chorddiag(data, showTicks = F, groupnameFontsize = 12, groupnamePadding = 8, margin = 120, groupPadding = 4, tooltipUnit = " Permits", groupColors = tol18rainbow)
    }
  })
  
})
