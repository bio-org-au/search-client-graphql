# frozen_string_literal: true

#   Copyright 2017 Australian National Botanic Gardens
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
require 'test_helper'

# Single controller test.
class SimpleCountTest < ActionController::TestCase
  tests NamesController
  setup do
    Setting.any_instance.stubs(:name_label).returns('APNI')
    Setting.any_instance.stubs(:taxonomy_label).returns('APC')
    Setting.any_instance.stubs(:tree_label).returns('APC')
    stub_rank_options
    hash = { data: { name_search: { count: 6 } } }
    json = hash.to_json
    NamesController::Index::GraphqlRequest.any_instance
                                          .stubs(:result)
                                          .returns(JSON.parse(json,
                                                              object_class:
                                                              OpenStruct))
  end

  test 'simple count' do
    get(:index, q: 'angophora costata',
                name_type: 'scientific', limit: '100', format: 'html',
                list_or_count: 'count')
    assert_response :success
    assert_select 'form', true, 'should find a form'
    assert_select("form[action='/names/search']") do
      assert_select("input[name='q']", true,
                    'Form should have a query field.')
      assert_select("input[type='submit']", true,
                    'Form should have a submit button.')
    end
    assert_select('div#search-result-summary') do |e|
      assert_match(/.*6 matching records.*/m,
                   e.text,
                   "Results should say '6 matching records'")
    end
  end
end
