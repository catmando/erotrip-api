# config/initializers/hyperloop.rb
# If you are not using ActionCable, see http://ruby-hyperloop.io/docs/models/configuring-transport/
Hyperloop.configuration do |config|

  # for normal use
  config.transport = :action_cable
  config.import 'client_and_server'
  config.import 'client_only', client_only: true

  config.prerendering = :off

  # for speed up css development
  # config.transport = nil



  # legacy
  # config.import 'reactrb/auto-import'
  # config.transport = :simple_poller
end

# module Hyperloop
#   module AutoCreate
#     def needs_init?
#       true
#     end
#   end

#   def self.on_server?
#     true
#   end
# end