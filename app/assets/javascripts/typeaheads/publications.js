// constructs the suggestion engine
var publications = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
    url:  window.relative_url_root + '/publications/suggestions/%QUERY',
    wildcard: '%QUERY'
  },
  limit: 100
});

function setUpPublicationTA() {
  $('#publication.typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 2
  },
  {
    name: 'publications',
    source: publications,
    limit: 50
  });
}
