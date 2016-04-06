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
  $('body').on('click','.needs-details-limit', (event) -> needsDetailsLimit(event,$(this)))
  $('body').on('submit','#search-form', (event) -> searchForm(event,$(this)))
  $('body').on('click','.drill-down-toggle', (event) -> drillDownToggle(event,$(this)))

$(document).ready(ready)
$(document).on('page:load', ready)

navNewSearch = (event, $element) ->
  $('#q').val('')
  $('#q').focus()
  false

# Hide/show details
# Load details if necessary
detailsToggle = (event, $element) ->
  debug("detailsToggle")
  nameId = $element.data("name-id")
  targetId = "name-#{nameId}"
  if $("##{targetId}").hasClass("hidden-xs-up")
    showTarget(targetId)
  else
    hideTarget(targetId)
  if $("#name-#{nameId}:empty").length == 0
    return false

needsDetailsLimit = (event, $element) ->
  href = $element.attr("href")
  detailsLimit = $("#details-limit-field").val()
  $element.attr("href","#{href}&details_limit=#{detailsLimit}")
  return true

searchForm = (event, $element) ->
  $("#details-limit").val($("#details-limit-field").val())
  true

drillDownToggle = (event, $element) ->
  debug("drillDownToggle")
  targetId = $element.data("target-id")
  if $("##{targetId}").hasClass("hidden-xs-up")
    showTarget(targetId)
  else
    hideTarget(targetId)
  if $("##{targetId}:empty").length == 0
    return_and_keep_going()

showTarget = (targetId) ->
  $("##{targetId}").removeClass("hidden-xs-up")
  $("##{targetId}").removeClass("hidden-print")

hideTarget = (targetId) ->
  $("##{targetId}").addClass("hidden-xs-up")
  $("##{targetId}").addClass("hidden-print")

return_and_keep_going = () ->
  return false
