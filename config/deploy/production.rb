# frozen_string_literal: true

role :app, %w[arthur@new.afetiveau.com]
role :web, %w[arthur@new.afetiveau.com]
role :db,  %w[arthur@new.afetiveau.com]

set :branch, 'main'
set :deploy_to, '/var/www/transactions'
set :keep_releases, 3
set :rbenv_ruby, '3.1.2'
