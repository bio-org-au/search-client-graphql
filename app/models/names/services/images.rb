# frozen_string_literal: true
#   Copyright 2015 Australian National Botanic Gardens
#
#   This file is part of the NSL Editor.
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

#  Service to query APII for a name
class Names::Services::Images
  ADDRESS = "http://www.anbg.gov.au/"
  PATH = "cgi-bin/apiiName"
  attr_reader :url

  def initialize(name_string)
    @name_string = name_string
    raise "NoNameString" if name_string.blank?
    @url = "#{ADDRESS}#{PATH}?name=#{name_string}"
    request
  end

  def request
    Rails.logger.debug("Start apii request")
    @request = RestClient.get('http://www.anbg.gov.au/cgi-bin/apiiName', {params: {name: @name_string}})
    Rails.logger.debug("End apii request")
  end

  def exist?
    !@request.body.match(/No Records Found/)
  end
end
