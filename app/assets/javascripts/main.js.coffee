jQuery ->
  console.log("jQuery: #{jQuery.fn.jquery}")
  #$('body').on('click',"input.left-aligned-form-button", (event) -> submitClick(event,$(this)))
  $('body').on('submit','form', (event) -> submitForm(event,$(this)))
  $('body').on('click','#form-help-link', (event) -> showFormHelp(event,$(this)))
  $('body').on('click','#general-help-link', (event) -> showGeneralHelp(event,$(this)))
  $(document).on('turbolinks:load',goToSearchResults())


submitForm = (event,$element) ->
  $('#search-result-summary').html('<h4>Searching....</h4>')
  $('#search-results').html('')
  $('#timing-summary').html('')

showFormHelp = (event,$element) ->
  toggleVisibility('.field-help')
  toggleHtml('#form-help-link', 'Help', 'Hide Help')
  false

showGeneralHelp = (event,$element) ->
  toggleVisibility('.general-help')
  toggleHtml('#general-help-link', 'help', 'hide help')
  false

toggleVisibility = (selector) ->
  if $(selector).hasClass('hidden')
    showTargets(selector)
  else
    hideTargets(selector)

showTargets = (selector) -> 
  $(selector).removeClass('hidden').addClass('visible')

hideTargets = (selector) -> 
  $(selector).removeClass('visible').addClass('hidden')

goToSearchResults = () ->
  if $("#top-of-search-results").length == 1
    location.href = "#top-of-search-results"

toggleHtml = (selector, textA, textB) ->
  if $(selector).html() == textA
    $(selector).html(textB)
  else
    $(selector).html(textA)

