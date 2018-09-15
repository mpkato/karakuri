# config valid only for current version of Capistrano
lock '3.4.0'
set :default_stage, "production"

set :application, 'karakuri'
set :repo_url, 'https://github.com/mpkato/karakuri.git'

set :deploy_to, '/var/www/karakuri'
set :scm, :git
set :use_sudo, false
set :log_level, :debug
set :pty, true
set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.4.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :bundle_without, [:development]

# for speed up assets:precompile
set :shared_children, ['system', 'log', 'pids', 'tmp/cache']

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
