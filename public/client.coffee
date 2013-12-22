intToTwoDigitHex = (i)->
  hex = i.toString(16)
  if hex.length == 1 then "0"+hex else hex

hexFromRGB = (r, g, b)->
  [
    intToTwoDigitHex(r),
    intToTwoDigitHex(g),
    intToTwoDigitHex(b)
  ].join("")

updateSwatch = (hex)->
  hashHex = "#"+hex
  $( "#swatch" )
    .css( "background-color", hashHex )
    .text(hashHex)

updateAphex = (color)->
  $.post( "/change-color/#{color}" )
    .done( -> console.log( 'successful color update to ', color ) )
    .fail( -> console.log( 'failed to change color to ', color ) )

updateSliderNumber = ($sliderNumber,val)->
  percentage = ((val/255)*100).toFixed()
  $sliderNumber.text(percentage+"%")

colorSelected = ->
  red = $( "#red .slider" ).slider( "value" )
  green = $( "#green .slider" ).slider( "value" )
  blue = $( "#blue .slider" ).slider( "value" )

  hex = hexFromRGB( red, green, blue )
  updateSliderNumber( $("#red .number"), red )
  updateSliderNumber( $("#green .number"), green )
  updateSliderNumber( $("#blue .number"), blue )

  updateSwatch(hex)
  updateAphex(hex)

# based on http://jqueryui.com/slider/#colorpicker

$ ->
  $( "#sliders .slider" ).slider(
    orientation: "horizontal"
    range: "min"
    max: 255
    slide: colorSelected
    change: colorSelected
  )
  $( "#red .slider" ).slider( "value", 255 )
  $( "#green .slider" ).slider( "value", 140 )
  $( "#blue .slider" ).slider( "value", 60 )
