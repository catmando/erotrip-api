# config/initializers/hyperloop.rb
# If you are not using ActionCable, see http://ruby-hyperloop.io/docs/models/configuring-transport/
Hyperloop.configuration do |config|
  config.transport = :action_cable
  # config.transport = :simple_poller
  # config.import 'reactrb/auto-import'
  # config.transport = :simple_poller
  config.import 'client_and_server'
  config.import 'client_only', client_only: true
end

