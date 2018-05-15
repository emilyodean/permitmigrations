library(shiny)
library(chorddiag)
library(shinyWidgets)

shinyUI(fluidPage(
  
  tags$style("
             span { font-size: 15px; line-height: 20px; }
             h2 { font-size: 25px; }
             .control-label { font-size:16px; }
             .box-class {background-color: #f9f9f9; border:1px solid #e3e3e3; padding:13px; border-radius:4px;}
             "),
  
  br(),
  titlePanel("Alaska Salmon Permit Flows Between Regions of Permit Holder Residence, 1975-2016"),
  tags$hr(),
  
  fluidRow(
    column(2,
           tags$div(class="box-class",
                    radioButtons('select_year',"Select Year",
                                 choices = c("1975-1985","1985-1995","1995-2005","2005-2016"),
                                 selected = "1975-1985"),
                    radioButtons('type',"Type of transfer",
                                 choices = c("All transfer types", "Gifted and traded permits","Migrated permits (change of address)","Cancelled Permits"),
                                 selected = "All transfer types"),
                    checkboxInput("bp", "Only inter-regional transfers", FALSE)
           )
    ),
    
    column(8,
           chorddiagOutput("distPlot", height = 600))),
  
  tags$div(class="box-class",
           tags$span(class="control-label", "How to read figure:"),
           tags$p("The circle's segments represent the regions where permit holders reside. Each region has its own color. The size of each segment/region represents the number of permits, issued and calcelled by CFEC, transferred (by gift, sale, or trade) to other residents,  and migrated (a permit holder moving) to/from/within that region.
Select different time periods to  see changes in magnitude of permit migration over time. Move the mouse across the figure to investigate flows for specific regions. The number of permits changing owners between regions is represented by the size of the connector and within a region by the width of the parabola. 
                  The color of the connector is determined by the region with positive netflow, an overall gain in permits. The CFEC is shown as a segment of the circle where in period 1975-1985 the initially issued permits in 1975 are shown. 
                  Also, the figure shows permit cancellations administered by the CFEC. Cancellations occur when owners decease, voluntarily relinquish permits through buybacks, or do not renew permits. Buybacks occured in 2008 and 2012 for S01A Southeast Alaska purse seine permits. For annual permit renewal, permit owners are required to pay a fee that varies by fishery and in 2018 ranged between $75 and $825 per permit. Permit owners dependent on public assistance can apply for a 50% fee reduction."),
           tags$hr(),
           p("By Tobias Schwoerer and Emily O'Dean, State of Alaska Salmon and People project. Source: CFEC")
           
  ),
  tags$br()
  ))