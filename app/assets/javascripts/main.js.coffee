jQuery ->
  console.log("jQuery: #{jQuery.fn.jquery}")
  #$('body').on('click',"input.left-aligned-form-button", (event) -> submitClick(event,$(this)))
  $('body').on('submit','form', (event) -> submitForm(event,$(this)))
  location.href = "#bottom-of-search-form"


submitForm = (event,$element) ->
  console.log("submitForm")
  $('#search-result-summary').html('<h4>Searching....</h4>')
  $('#search-results').html('')
  $('#timing-summary').html('')

