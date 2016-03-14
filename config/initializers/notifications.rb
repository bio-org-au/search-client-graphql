METRICS = Statsd.new('127.0.0.1', 8125)

def send_event_to_statsd(name, payload)
  action = payload[:action] || :increment
  measurement = payload[:measurement]
  value = payload[:value]
  #key_name = ::Statsd.clean_name("#{name.to_s.capitalize}.#{measurement}")
  #MyApp.statsd.__send__ action.to_s, key_name, (value || 1)
  #METRICS.__send__ action.to_s, key_name, (value || 1)
  METRICS.increment action.to_s
end

ActiveSupport::Notifications.subscribe do |name, start, finish, id, payload| 
  Rails.logger.debug(["notification:", name, start, finish, id, payload].join(" "))
  send_event_to_statsd(name, payload)
end
