# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'plataforma-web'
set :repo_url, 'https://github.com/abmti/colaeleitoral-web'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/plataforma-web'

# Default value for :scm is :git
set :scm, :git
#set :scm_user, "xxxx"
#set :scm_passphrase, "xxxx"

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5˜

#set :ssh_options, :forward_agent => true

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, "#{release_path}/tmp/restart.txt"
      execute :cp, "#{deploy_to}/mongoid.yml", "#{release_path}/config/mongoid.yml"
      execute :mkdir, '-p', "#{release_path}/tmp"
      execute :touch, "#{release_path}/tmp/restart.txt"
    end
  end

  desc "Create links dir uploads"
  task :create_links_dir_uploads do
    on release_roles :all do
      target = "#{release_path}/public/system"
      source = "#{shared_path}/system"
      execute :rm, '-rf', target
      execute :ln, '-s', source, target
    end
  end

  after :log_revision, :create_links_dir_uploads
  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end


end