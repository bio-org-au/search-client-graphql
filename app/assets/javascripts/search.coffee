window.debug = (s) ->
  try
    console.log('debug: ' + s) if debugSwitch == true
  catch error

window.notice = (s) ->
  try
    console.log('notice: ' + s)
  catch error

# Turbolinks
ready = ->
  debug('Start of search.js document ready')
  debug('jQuery version: ' + $().jquery)
  $('body').on('click','.nav-new-search', (event) -> navNewSearch(event,$(this)))
  $('body').on('click','.details-toggle', (event) -> detailsToggle(event,$(this)))

$(document).ready(ready)
$(document).on('page:load', ready)

navNewSearch = (event, $element) ->
  $('#q').val('')
  $('#q').focus()
  false

# If details, clear them.
# Else let processing continue.
detailsToggle = (event, $element) ->
  nameId = $element.data("name-id")
  if $("#name-#{nameId}:empty").length == 0
    $("#name-#{nameId}").empty()
    return false
