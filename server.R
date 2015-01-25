# CO2 data server.R script

library(forecast)

shinyServer(function(input, output, session) {

   co2trim <- reactive({
     co2a <- window(co2, input$firstYear, c(1997,12))
   })

    cotwo <- reactive({
     co2b <- stl(co2trim(), s.window = "per")
   })

  output$plot1 <- renderPlot({
    plot(cotwo())
  })
  output$plot2 <- renderPlot({
    monthsPred <- input$yearsPred * 12
    plot(forecast(cotwo(), method = "rwdrift",
                  level = c(60,90), h=monthsPred))
    abline(h = input$refLev)
    abline(v = input$refYear)
  })

  output$text1 <- renderUI({
    n <- "Mauna Loa Monthly Carbon Dioxide Measurements in ppm"
  })

  output$text2 <- renderUI({
    n1 <- "Top Graphic is result of stl model to separate"
    n2 <- " seasonal effect, trend, and residuals."
    n3 <- "Bottom Graphic shows forecasts in blue using rwdrift method
     along with 60% and 90% confidence bounds"
    HTML(paste(paste(n1, n2), n3, sep = '<br/><br/>'))
  })

  output$doc1 <- renderUI({
    blk1 <- "Data Source: Keeling, C. D. and Whorf, T. P., Scripps Institution of Oceanography (SIO),
    University of California, La Jolla, California USA 92093-0220,<br/>
    in cooperation with NOAA Earth System Research Laboratory.<br/>
    More information available here:<br/>
    http://www.esrl.noaa.gov/gmd/ccgg/trends/<br/>
    This version of the dataset is obtained from the datasets package included 
    in Base R.<br/>"
    blk2 <- "Atmospheric concentrations of CO2 are expressed in
    parts per million (ppm) and reported in the preliminary
    1997 SIO manometric mole fraction scale.<br/>
    The monitoring station is at an elevation of about 11,150 feet
    on the slopes of Mauna Loa on the island of Hawaii.  This is
    above almost all temperature inversions that might
    produce local variations.  Measurements are adjusted to 
    account for local outgassing of CO2 from the volcano.<br/>
    This dataset covers all months of the years 1959 through 1997.
    More recent data have been collected but are not included in
    this dataset.<br/>  The measurements from February through April
    of 1964 were missing and have been imputed by linear interpolation
    between the values from January and May of that year.<br/>
    A seasonality period is very obvious, caused by the fact
    that the great majority of Earth's biomass lies in the 
    Northern Hemisphere.<br/>"
    blk3 <- "The stl( ) function of the Base R stats package is used
    to decompose the time series into seasonal, trend and irregular
    components using LOESS smoothing.<br/>
    Forecasting is done with the forecast( ) function of the forecast
    package, using the results of the decomposition, and the 
    'rwdrift' method.<br/>"
    blk4 <- "The plots are reactive to four input widgets.<br/>
    'First Year for Model' allows selection of which year to start
    with for the decomposition.  The last year for use is always
    1997.<br/>
    'Years to Predict' is the number of years beyond 1997 to make
    predictions for.  Predictions are made on a monthly basis,
    shown in blue, with 60% and 90% confidence bounds also shown.<br/>
    'Reference Level Line' and 'Reference Year Line' are used for 
    graphing only and do not affect the computations."
    HTML(paste(blk1, blk2, blk3, blk4, sep = '<br/>'))
  })

})
