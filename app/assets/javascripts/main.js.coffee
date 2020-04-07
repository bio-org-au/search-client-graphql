jQuery ->
  console.log("jQuery: #{jQuery.fn.jquery}")
  #$('body').on('click',"input.left-aligned-form-button", (event) -> submitClick(event,$(this)))
  $('body').on('submit','form', (event) -> submitForm(event,$(this)))
  $('body').on('click','#form-help-link', (event) -> showFormHelp(event,$(this)))
  $('body').on('click','#general-help-link', (event) -> toggleGeneralHelp(event,$(this)))
  $('body').on('click','.general-help-link', (event) -> toggleGeneralHelp(event,$(this)))
  $('body').on('click','.hide-this-help-link', (event) -> hideOneHelpElement(event,$(this)))
  $('body').on('change','.search-samples', (event) -> runSampleSearch(event,$(this)))
  $(document).on('turbolinks:load',goToSearchResults())
  $('body').on('change','#colour-scheme-picker', (event) -> changeBackground(event,$(this)))
  $('body').on('click','#show-unused-fields', (event) -> showUnusedFields(event,$(this)))
  $('body').on('click','#hide-unused-fields', (event) -> hideUnusedFields(event,$(this)))


submitForm = (event,$element) ->
  $('#search-result-summary').html('<h4>Searching....</h4>')
  $('#search-results').html('')
  $('#timing-summary').html('')

showFormHelp = (event,$element) ->
  toggleVisibility('.field-help')
  toggleHtml('#form-help-link', 'Help', 'Hide Help')
  false

toggleGeneralHelp = (event,$element) ->
  if $('#general-help-link').html() == 'help'
    showGeneralHelp()
  else
    hideGeneralHelp()
  false

showGeneralHelp = () ->
  $('.general-help').removeClass('hidden')
  $('#general-help-link').html('hide help')

hideGeneralHelp = () ->
  $('.general-help').addClass('hidden')
  $('#general-help-link').html('help')

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
    
hideOneHelpElement = (event,$element) ->
  hideElement(event,$element)
  if $('.general-help:visible').length == 0
    $('#general-help-link').html('help')
  false

runSampleSearch = (event,$element) ->
  window.location.href = $element.val() if $element.val()

hideElement = (event,$element) ->
  hideTargets('#'+$element.data('target-id'))
  false

changeBackground = (event,$element) ->
  $('body').removeClass('dark')
  $('body').removeClass('light')
  $('body').addClass($element.val())
  $.post window.relative_url_root  + '/background?background=' + encodeURIComponent($element.val())
  false
    
showUnusedFields = (event,$element) ->
  $('.not-used-in-search').removeClass('hidden')
  $('#show-unused-fields-link-container').addClass('hidden')
  $('#hide-unused-fields-link-container').removeClass('hidden')
  false
    
hideUnusedFields = (event,$element) ->
  $('.not-used-in-search').addClass('hidden')
  $('#hide-unused-fields-link-container').addClass('hidden')
  $('#show-unused-fields-link-container').removeClass('hidden')
  false
