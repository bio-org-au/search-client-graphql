window.debug = (s) ->
  try
    console.log('debug: ' + s) if debugSwitch == true
  catch error

window.notice = (s) ->
  try
    console.log('notice: ' + s)
  catch error

loadDetailsIfRequired = () ->
  debug('loadDetailsIfRequired')
  if $('#retrieve_details_on_load').val()
    if $('#retrieve_details_on_load').val().match(/true/)
      $('#retrieve-details-control').click()
      showFirstMoreDetailsWidget()

stopRetrieveDetails = (event, $element) ->
  debug("stopRetrieveDetails")
  $('#stop-retrieve-details-control').addClass('hidden-xs-up')
  $('#resume-retrieve-details-control').removeClass('hidden-xs-up')
  window.retrieveDetailsBoolean = false
  event.preventDefault()
  event.stopPropagation()

retrieveDetails = (event, $element) ->
  debug('retrieveDetails')
  links = $(".drill-down-toggle.no-details")
  if window.retrieveDetailsBoolean == true && links.length > 0
    retrieveOneDetail(links[0])
    setTimeout(retrieveDetails,800)
    $('#stop-retrieve-details-control').removeClass('hidden-xs-up')
    $('#retrieve-details-control').addClass('hidden-xs-up')
  unless typeof event == "undefined"
    event.preventDefault()
    event.stopPropagation()

resumeRetrieveDetails = (event, $element) ->
  debug('resumeRetrieveDetails')
  window.retrieveDetailsBoolean = true
  $('#resume-retrieve-details-control').addClass('hidden-xs-up')
  retrieveDetails(event, $element)

retrieveOneDetail = (link) ->
  debug("retrieveOneDetail")
  if window.retrieveDetailsBoolean == true
    link.click()
    resetNameControls()

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
    debug('not querying details')
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
    $element.addClass("showing-details")
    $element.removeClass("no-details").removeClass("hiding-details")
    showTarget(targetId)
    $element.find('i.fa-caret-right').removeClass('fa-caret-right').addClass('fa-caret-down')
    resetNameControls()
    if $("##{targetId}:empty").length == 0
      keep_going()
    else
      stop()
  else
    debug('hiding...')
    hideTarget(targetId)
    $element.addClass("hiding-details")
    $element.removeClass("showing-details")
    $element.find('i.fa-caret-down').removeClass('fa-caret-down').addClass('fa-caret-right')
    resetNameControls()
    event.preventDefault()
    event.stopPropagation()

showTarget = (targetId) ->
  $("##{targetId}").removeClass("hidden-xs-up")
  $("##{targetId}").removeClass("hidden-print")
  $(".#{targetId}").removeClass("hidden-xs-up")
  $(".#{targetId}").removeClass("hidden-print")

hideTarget = (targetId) ->
  $("##{targetId}").addClass("hidden-xs-up")
  $("##{targetId}").addClass("hidden-print")
  $(".#{targetId}").addClass("hidden-xs-up")
  $(".#{targetId}").addClass("hidden-print")

keep_going = () ->
  return false

stop = () ->
  return true

hideAllDetails = (event, $element) ->
  debug("hideAllDetails")
  $(".drill-down-toggle.showing-details").click()

collapseAll = (event, $element) ->
  debug("collapseAll")
  $(".drill-down-toggle.showing-details").click()
  resetNameControls()

expandAll = (event, $element) ->
  debug("expandAll")
  $(".drill-down-toggle.hiding-details").click()
  resetNameControls()

alwaysShowHideAllToggle = (event, $element) ->
  debug("alwaysShowHideAllToggle")
  if $('#retrieve_details_on_load').val() == 'false'
    $('#retrieve_details_on_load').val('true')
    $element.text("Always get details").append(" &nbsp;<i class='fa fa-check'></i>")
  else
    $('#retrieve_details_on_load').val('false')
    $element.text("Always get details")

showSelector = (selector) -> 
  # Check non-empty array of hidden elements to avoid ugly error
  # search:1SyntaxError: Unexpected identifier 'Object'. 
  # Expected either a closing ']' or a ',' following an array element.
  hiddenSelector = "#{selector}.hidden-xs-up"
  $(hiddenSelector).removeClass('hidden-xs-up') if $(hiddenSelector).length > 0

hideSelector = (selector) -> 
  $(selector).addClass('hidden-xs-up')

window.showAsExpanded = (targetId) ->
  debug('showAsExpanded')
  $('a.'+targetId).removeClass("no-details").removeClass("hiding-details")
  $('a.'+targetId).addClass("showing-details")
  showTarget(targetId)
  $('a.'+targetId).find('i.fa-caret-right').removeClass('fa-caret-right').addClass('fa-caret-down')

window.showDetailsRetrieved = (targetId) ->
  debug('showDetailsRetrieved')
  $("##{targetId}").addClass('retrieved')

window.resetNameControls = () ->
  return unless $('.name-results').length > 0
  debug('resetNameControls')
  debug('=================')
  name_count = $('.name-heading').length
  debug("name_count: #{name_count}")
  drill_down_toggles_retrieved_count = $('.drill-down-toggle.retrieved').length
  debug("drill_down_toggles_retrieved_count: #{drill_down_toggles_retrieved_count}")
  details_retrieved_count = $('.details.retrieved').length
  debug("details_retrieved_count: #{details_retrieved_count}")
  expanded_details_count = Math.min(details_retrieved_count, $('a.showing-details').length)
  debug("expanded_details_count: #{expanded_details_count}")
  collapsed_details_count = $('.hiding-details').length
  debug("collapsed_details_count: #{collapsed_details_count}")
  debug("window.retrieveDetailsBoolean: #{window.retrieveDetailsBoolean}")
  $('.details-retrieved-entry').text("#{details_retrieved_count}")
  if name_count == 0
    hideSelector('.control')
  else
    if expanded_details_count > 0
      $('#expanded-details-count').text("(#{expanded_details_count})")
      showSelector('#collapse-details-control')
    else
      hideSelector('#collapse-details-control')
    if collapsed_details_count > 0
      $('#collapsed-details-count').text("(#{collapsed_details_count})")
      showSelector('#expand-details-control')
    else
      hideSelector('#expand-details-control')
  debug('End resetNameControls')
 
window.resetTaxonomyControls = () ->
  return unless $('.taxonomy-results').length > 0
  debug('resetTaxonomyControls')
  taxonomy_count = $('.taxonomy-heading').length
  debug(taxonomy_count)
  details_retrieved_count = $('.details.retrieved').length
  debug(details_retrieved_count)

switchNameType = (event, $element) ->
  debug("switchNameType")
  switchTo = $element.data("switch-to")
  hideAbout()
  $('#name_type').val(switchTo)
  $('.name-type-switch-item').removeClass('active')
  $element.closest('.name-type-switch-item').addClass('active')
  if $('#q').val().length > 0
    $('#search-button').click()
  event.preventDefault()
  event.stopPropagation()

window.changeEditorSwitch = (bool) ->
  if bool 
    $('#editor-toggle-switch-indicator').removeClass('hidden-xs-up')
    $('.for-editor').removeClass('hidden-xs-up')
  else
    $('#editor-toggle-switch-indicator').addClass('hidden-xs-up')
    $('.for-editor').addClass('hidden-xs-up')

window.changeCitationsSwitch = (bool) ->
  if bool 
    $('#citations-toggle-switch-indicator').removeClass('hidden-xs-up')
    $('.for-citations').removeClass('hidden-xs-up')
  else
    $('#citations-toggle-switch-indicator').addClass('hidden-xs-up')
    $('.for-citations').addClass('hidden-xs-up')

window.changeAlwaysDetailsSwitch = (bool) ->
  if bool 
    $('#always-details-toggle-switch-indicator').removeClass('hidden-xs-up')
    $('.for-always-details').removeClass('hidden-xs-up')
  else
    $('#always-details-toggle-switch-indicator').addClass('hidden-xs-up')
    $('.for-always-details').addClass('hidden-xs-up')

window.changeIncludeTaxonomyDetailsSwitch = (bool) ->
  if bool 
    $('#include-taxonomy-details-toggle-switch-indicator').removeClass('hidden-xs-up')
  else
    $('#include-taxonomy-details-toggle-switch-indicator').addClass('hidden-xs-up')

window.showTaxonomyDetailsSwitch = (bool) ->
  if bool 
    $('.for-taxonomy-details').removeClass('hidden-xs-up')
  else
    $('.for-taxonomy-details').addClass('hidden-xs-up')

window.changeHelpSwitch = (bool) ->
  debug("changeHelpSwitch - bool: #{bool}")
  debug($('.for-help').length)
  if bool 
    $('#help-toggle-switch-indicator').removeClass('hidden-xs-up')
    $('.for-help').removeClass('hidden-xs-up')
  else
    $('#help-toggle-switch-indicator').addClass('hidden-xs-up')
    $('.for-help').addClass('hidden-xs-up')

jsonSearch = (event, $element) ->
  debug('jsonSearch')
  $('#search-output-format').val('json')
  $('#search-button').click()
  $('#search-output-format').val('html')
  event.preventDefault()
  event.stopPropagation()

csvSearch = (event, $element) ->
  $('#search-output-format').val('csv')
  $('#search-button').click()
  $('#search-output-format').val('html')
  event.preventDefault()
  event.stopPropagation()

showFirstMoreDetailsWidget = () ->
  $('more-details-widget').filter(":first").removeClass('hidden-xs-up')

altSearchLink = (event, $element) ->
  new_href = $element.attr('href').replace(/q=.*/,'q=')
  new_href = "#{new_href}#{encodeURIComponent($('#q').val())}"
  new_href = "#{new_href}&add_trailing_wildcard="
  new_href = "#{new_href}#{encodeURIComponent($('#add-trailing-wildcard').val())}"
  $element.attr('href', new_href)
  # Let the link fire, now with the new href.

switchSidebarSearch = (event, $element) ->
  hideAbout()
  switchTo = $element.data("search-type")
  $('#search-type').val(switchTo)
  $('.search-type-switch-item').removeClass('active')
  $element.closest('.search-type-switch-item').addClass('active')
  if $('#q').val().length > 0
    $('#search-button').click()
  event.preventDefault()
  event.stopPropagation()

taxonomyFormatSearch = (event, $element) ->
  debug('taxonomyFormatSearch')
  searchFormat = $element.data("search-format")
  $('#search-format').val(searchFormat)
  $('#search-button').click()
  $('#search-format').val('html')
  event.preventDefault()
  event.stopPropagation()

window.addClearButton = () ->
  $("#q").addClear({symbolClass: "fa fa-times-circle", color: "darkgray", top: 8, right: 30})
  $("#q").focus()

startSearch = (event, $element) ->
  debug('startSearch')
  if $('#q').val().length > 0
    # Need better way to show search is working
    # This doesn't behave well - have to move
    # cursor to make it go back to normal.
    # $("body").css("cursor", "wait")
  else
    alert("Please enter a search term")
    event.preventDefault()
    event.stopPropagation()

pageFetch = () ->
  debug('pageFetch')

# Hide/show details
# Load details if necessary
toggleAbout = (event, $element) ->
  #targetSelector = $element.data("target-selector")
  #$target = $("#{targetSelector}")
  if $('#about-page.hidden-xs-up').length > 0
    showAbout()
  else
    hideAbout()
  
showAbout = () ->
  $('#about-page').removeClass("hidden-xs-up")
  $('#about-link-tick.hidden-xs-up').removeClass("hidden-xs-up")
  $('.not-about-page').addClass("hidden-xs-up")

window.hideAbout = () ->
  $('#about-page').addClass("hidden-xs-up")
  $('#about-link-tick').addClass("hidden-xs-up")
  $('.not-about-page').removeClass("hidden-xs-up")

showHideTaxonomyDetails = (event, element) ->
  if element.hasClass('hiding')
    element.removeClass('hiding').addClass('showing').html('Hide details')
    $('.for-taxonomy-details').removeClass('hidden-xs-up')
  else
    element.removeClass('showing').addClass('hiding').html('Show details')
    $('.for-taxonomy-details').addClass('hidden-xs-up')
  event.preventDefault()
  event.stopPropagation()

toggleTaxonomyLoadedDetails = (event, element) ->
  div = element.closest('li').find('div.accepted-name-details')
  if div.hasClass('hidden-xs-up')
    div.removeClass('hidden-xs-up')
  else
    div.addClass('hidden-xs-up')
  event.preventDefault()
  event.stopPropagation()

# Turbolinks
turbolinksLoad = () ->
  debug('turbolinksLoad; =============')
  docReady()

docReady = ->
  debug('docReady:  jQuery version: ' + $().jquery)
  $('body').on('click','.nav-new-search', (event) -> navNewSearch(event,$(this)))
  $('body').on('click','.details-toggle', (event) -> detailsToggle(event,$(this)))
  $('body').on('click','.needs-details-limit', (event) -> needsDetailsLimit(event,$(this)))
  $('body').on('submit','#search-form', (event) -> searchForm(event,$(this)))
  $('body').on('click','.drill-down-toggle', (event) -> drillDownToggle(event,$(this)))
  $('body').on('click','#hide-all-details-link', (event) -> hideAllDetails(event,$(this)))
  $('body').on('click','.retrieve-details-control', (event) -> retrieveDetails(event,$(this)))
  $('body').on('click','#stop-retrieve-details-control', (event) -> stopRetrieveDetails(event,$(this)))
  $('body').on('click','#resume-retrieve-details-control', (event) -> resumeRetrieveDetails(event,$(this)))
  $('body').on('click','.collapse-details-control', (event) -> collapseAll(event,$(this)))
  $('body').on('click','.expand-details-control', (event) -> expandAll(event,$(this)))
  $('body').on('click','#always-retrieve-details-toggle', (event) -> alwaysShowHideAllToggle(event,$(this)))
  $('body').on('click','.name-type-switch-link', (event) -> switchNameType(event,$(this)))
  $('body').on('click','#json-search', (event) -> jsonSearch(event,$(this)))
  $('body').on('click','#csv-search', (event) -> csvSearch(event,$(this)))
  $('body').on('click','.taxonomy-search-sidebar-link', (event) -> switchSidebarSearch(event,$(this)))
  $('body').on('click','.taxonomy-format-search', (event) -> taxonomyFormatSearch(event,$(this)))
  $('body').on('click','#search-button', (event) -> startSearch(event,$(this)))
  $('body').on('click','.alt-search-link', (event) -> altSearchLink(event,$(this)))
  $('body').on('page:fetch','*', (event) -> pageFetch(event,$(this)))
  $('body').on('click','.about-link', (event) -> toggleAbout(event,$(this)))
  $('body').on('click','#show-hide-taxonomy-details', (event) -> showHideTaxonomyDetails(event,$(this)))
  $('body').on('click','.taxonomy-heading.loaded-details', (event) -> toggleTaxonomyLoadedDetails(event,$(this)))
  window.addClearButton()
  window.retrieveDetailsBoolean = true
  loadDetailsIfRequired() if typeof(loadDetailsIfRequired) == "function"
  resetNameControls() if typeof(resetNameControls) == "function"
  resetTaxonomyControls() if typeof(resetTaxonomyControls) == "function"
	

#$(document).on('turbolinks:load', turbolinksLoad())

$ ->
  docReady()

