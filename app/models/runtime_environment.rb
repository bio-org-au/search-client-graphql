# frozen_string_literal: true

# Get Runtime Environment info from the server.
class RuntimeEnvironment
  DATA_SERVER = Rails.configuration.data_server

  def database
    results['database']
  end

  def ruby_version
    results['ruby_version']
  end

  def ruby_platform
    results['ruby_platform']
  end

  def rails_version
    results['rails_version']
  end

  def rails_env
    results['rails_env']
  end

  def app_version
    results['app_version']
  end

  private

  def body
    { query: graphql_query_string }
  end

  def graphql_query_string
    <<~HEREDOC
        {runtime_environment()
          {database,
           ruby_version,
           ruby_platform,
           rails_version,
           rails_env,
           app_version}
        }
    HEREDOC
  end

private
  def results
    json = HTTParty.post("#{DATA_SERVER}/v1",
                         body: body,
                         timeout: 10)
    a = []
    JSON.parse(json.to_s, object_class: Hash)['data']['runtime_environment']
  rescue => e
    Rails.logger.error("Error finding setting")
    Rails.logger.error(e.message)
    {}
  end
end
