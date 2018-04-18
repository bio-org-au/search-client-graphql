

hideOneHelpElement = (event,$element) ->
  hideElement(event,$element)
  if $('.general-help:visible').length == 0
    $('#general-help-link').html('help')
  false


hideElement = (event,$element) ->
  hideTargets('#'+$element.data('target-id'))
  false
