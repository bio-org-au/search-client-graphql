# frozen_string_literal: true
require "test_helper"

# Controller test
class TaxonomyControllerTest < ActionController::TestCase
  test "show" do
    name = names(:angophora)
    get :show, id: name.id
  end
end
