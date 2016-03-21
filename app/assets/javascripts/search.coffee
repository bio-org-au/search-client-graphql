window.debug = (s) ->
  try
    console.log('debug: ' + s) if debugSwitch == true
  catch error

window.notice = (s) ->
  try
    console.log('notice: ' + s)
  catch error

ready = ->
  debug('Start of search.js document ready')
  debug('jQuery version: ' + $().jquery)
  $('body').on('click','.nav-new-search', (event) -> navNewSearch(event,$(this)))
  $('body').on('click','a.name-type-switch-link', (event) -> nameTypeSwitchLink(event,$(this)))

$(document).ready(ready)
$(document).on('page:load', ready)

navNewSearch = (event, $element) ->
  $('#q').val('')
  $('#q').focus()
  false

nameTypeSwitchLink = (event, $element) ->
  debug('ntslink')
  if $('#search-form').length > 0
    switchForm(event,$element)
  else
    debug('no search form so follow link')
    true

switchForm = (event, $element) ->
  debug('switch')
  switchTo = $element.data("switch-to")
  debug("switchTo: #{switchTo}")
  oldAction = $('#search-form').attr('action')
  debug("oldAction: #{oldAction}")
  newAction = oldAction.replace(/\/[^\/]+$/,"/#{switchTo}")
  debug("newAction: #{newAction}")
  $('#search-form').attr('action',newAction)
  debug($('#search-form').attr('action'))
  $('#search-form').submit()
