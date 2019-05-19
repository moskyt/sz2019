# -*- encoding : utf-8 -*-
require "bundler/capistrano"
require 'capistrano/mysqldump'
load 'deploy/assets'

default_run_options[:pty] = true
default_run_options[:shell] = '/bin/bash --login'
ssh_options[:forward_agent] = true
ssh_options[:verify_host_key] = :never

set :repository,  "gitosis@siven.onesim.net:sz2019.git"
set :scm, :git
set :branch, "master"
set :scm_verbose, true
set :deploy_via, :remote_cache

set :user, "moskyt"
set :application, "sz2019"
set :keep_releases, 2
set :use_sudo, false

set :mysqldump_bin, "/usr/bin/mysqldump"
set :deploy_to, "/home/moskyt/sz2019"

role :app, "siven.onesim.net"
role :web, "siven.onesim.net"
role :db,  "siven.onesim.net", :primary => true

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  #desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
     run("cd #{current_path}/public; rm -rf uploads ; ln -sf #{shared_path}/uploads ./uploads")
  end

  # task :gems do
  #   shared_dir = File.join(shared_path, 'bundle')
  #   release_dir = File.join(current_release, 'vendor', 'bundle')
  #   run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  #   run("cd #{release_path}; bundle install --deployment")
  # end

  task :migrate do
    run("cd #{current_path}; bundle exec rake db:migrate RAILS_ENV=production")
  end

  task :flush do
    run("cd #{current_path}; bundle exec rake data:flush RAILS_ENV=production")
  end

  task :kwikfix do
    run "cd #{current_path}; rm -f db/data.yml; git pull origin master; touch #{current_path}/tmp/restart.txt"
  end

  # before "deploy:update_code", "maintenance:backup"
  after "deploy:update", "deploy:symlink_shared"
  after "deploy:update", "deploy:cleanup", "deploy:migrate"
  before "deploy:assets:precompile", "bundle:install"

end

task :pull do
end

task :download_system do
  download "#{shared_path}/system", "./public/", :recursive => true, :via => :scp
end

before "pull", "mysqldump", "download_system"

namespace :maintenance do
  desc "print out production log"
  task :log do
    run("cd #{deploy_to}/current; tail -n 500 log/production.log")
  end
end

namespace :rails do
  desc "Open the rails console on one of the remote servers"
  task :console, :roles => :app do
    hostname = find_servers_for_task(current_task).first
    exec "ssh -l #{user} #{hostname} -t 'source /etc/profile && source ~/.profile && cd #{current_path} && bin/rails c #{rails_env}'"
  end
end

