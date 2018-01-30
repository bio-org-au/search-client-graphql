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
class AdvancedNamesNoSearchIndexTest < ActionController::TestCase
  tests AdvancedNamesController
  setup do
    Setting.any_instance.stubs(:name_label).returns('APNI')
    Setting.any_instance.stubs(:taxonomy_label).returns('APC')
    Setting.any_instance.stubs(:tree_label).returns('APC')
    Rank.any_instance.stubs(:options).returns(['regio', 'reg.', 'div.', 'cl.', 'subcl.', 'superordo', 'ordo', 'subordo', 'fam.', 'subfam.', 'trib.', 'subtrib.', 'gen.', 'subg.', 'sect.', 'subsect.', 'ser.', 'subser.', 'supersp.', 'sp.', 'subsp.', 'var.', 'nothovar.', 'subvar.', 'f.', 'subf.', '[n/a]', '[infrafamily]', '[infragenus]', '[unranked]', '[infrasp.]'])
  end

  test 'no search name index' do
    get(:index, params: { search: 'Search' })
    assert_response :success
    assert_select 'form', true, 'should find a form'
    assert_select("form[action='/names/advanced']") do
      # assert_select("input[name='q']", true, 'Form should have a query field.')
      assert_select("input[name='genus']", true, 'Form should have a genus field.')
      assert_select("input[name='species']", true, 'Form should have a species field.')
      assert_select("input[name='taxon_name_author_abbrev']", true, 'Form should have a taxon_name_author_abbrev field.')
      assert_select("input[name='basionym_author_abbrev']", true, 'Form should have a basionym_author_abbrev field.')
      assert_select("input[type='submit']", true,
                    'Form should have a submit button.')
    end
  end
end
