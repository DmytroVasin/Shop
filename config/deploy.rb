# sudo su - deploy

require 'bundler/capistrano'
require 'delayed/recipes'
#require "rvm/capistrano"

server "188.226.157.249", :web, :app, :db, primary: true

set :application, "shop"
set :user, "deploy"
set :port, 22
set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:DemitriyDN/Shop.git"
set :branch, "master"
#set :rvm_ruby_string, 'ruby-2.0.0-p451'
set :default_environment, 'PATH' => '$HOME/.rbenv/shims:$PATH'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "sudo /etc/init.d/unicorn #{command}"
    end
  end

  task :setup_config, roles: :app do
#    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
#    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  # Delay Job:
  # after "deploy:stop", "delayed_job:stop"
  # after "deploy:start", "delayed_job:start"
  after "deploy:restart", "delayed_job:restart"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end