# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "transactions"
set :repo_url, "https://github.com/art29/TransactionTracker-Rails.git"

set :rbenv_type, :user
set :rbenv_ruby, '3.1.2'
set :rbenv_prefix, '/usr/bin/rbenv exec'
set :linked_files, %w{config/master.key}
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'node_modules', 'public/packs')
set :default_env,
    { "PASSENGER_INSTANCE_REGISTRY_DIR" => "/var/passenger_instance_registry" }