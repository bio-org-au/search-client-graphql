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

$(document).ready(ready)
$(document).on('page:load', ready)

navNewSearch = (event, $element) ->
  $('#q').val('')
  $('#q').focus()
  false
