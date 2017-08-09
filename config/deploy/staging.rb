set :branch, :staging
set :rails_env, 'staging'

role :app, %w{deployer@batman.enginearch.com}
role :web, %w{deployer@batman.enginearch.com}
role :db,  %w{deployer@batman.enginearch.com}

set :nginx_server_name, "erotrip.enginearch.com"

set :nvm_type, :user
set :nvm_node, 'v8.2.1'
set :nvm_map_bins, %w{node npm yarn}

set :puma_plugins,            []
set :puma_init_active_record, true
set :puma_threads,            [1, 3]
set :puma_workers,            1
set :puma_worker_timeout,     30
set :puma_env,                :staging

set :rbenv_type, :system
set :rbenv_ruby, '2.4.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

server 'batman.enginearch.com', user: 'deployer', roles: %w{web app}
