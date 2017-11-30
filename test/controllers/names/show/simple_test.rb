# frozen_string_literal: true

require 'json'
require 'ostruct'

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
class NamesShowTest < ActionController::TestCase
  tests NamesController
  setup do
    Setting.any_instance.stubs(:name_label).returns('APNI')
    Setting.any_instance.stubs(:taxonomy_label).returns('APC')
    Setting.any_instance.stubs(:tree_label).returns('APC')
    NamesController::Show::GraphqlRequest.any_instance
                                         .stubs(:result)
                                         .returns(raw_result)
    Application::Names::Results::Name::Usage::Synonym.any_instance
                                                     .stubs(:name_id)
                                                     .returns(2)
  end

  test 'show name' do
    get(:show, id: 1, search_form: 'names')
    assert_response :success
    assert_select 'h3', true, 'should find a heading level 3'
    assert_select('h3') do
      assert_select("span.family-name[title = 'family name']",
                    'Myrtaceae Juss.',
                    'Wrong family name')
    end
  end

  def raw_result
    hash = {
      data:
      {
        name: name_hash
      }
    }
    json = hash.to_json
    rr = JSON.parse(json, object_class: OpenStruct)
    rr
  end

  def name_hash
    {
      id: '91755', simple_name: 'Angophora costata',
      full_name: 'Angophora costata (Gaertn.) Britten',
      full_name_html: full_name_html, family_name: 'Myrtaceae Juss.',
      name_status_name: 'legitimate', name_history:
        { name_usages: name_usages }
    }
  end

  def full_name_html
    "scientific><name id = '91755'><scientific><name id='91714'>\
    <element class='Angophora'>Angophora</element></name></scientific>\
    <element class='costata'>costata</element>\
    <authors>(<base id='7066' title='Gaertner, J.'>Gaertn.</base>) \
    <author id='7087' title='Britten, J.'>Britten</author></authors>\
    </name></scientific>"
  end

  def synonyms
    [
      {
        id: '804816',
        full_name: 'Metrosideros costata Gaertn.',
        instance_type: 'basionym',
        label: 'basionym',
        page: '62',
        name_status_name: 'legitimate'
      }
    ]
  end

  def name_usages
    [{ instance_id: '514039', reference_id: '32778',
       citation:
       'Britten, J. (1916), Journal of Botany, British and Foreign 54',
       page: '62', page_qualifier: '', year: '1916', standalone: true,
       instance_type_name: 'comb. nov.', primary_instance: true,
       misapplied: false, misapplied_to_name: '', misapplied_to_id: '',
       misapplied_by_id: '', misapplied_by_citation: '',
       misapplied_on_page: '', synonyms: synonyms, notes: [] }]
  end
end
