require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
require 'mina/rvm'    # for rvm support. (https://rvm.io)
require 'mina/puma'

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'lottery'
set :domain, '106.12.96.28'
set :deploy_to, '/home/xiaodao/web/lottery'
set :repository, 'git@github.com:Liu-XiaoDao/lottery.git'
set :branch, 'mina'
set :rails_env, 'production'
# Optional settings:
set :user, 'xiaodao'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
set :forward_agent, true     # SSH forward_agent.

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
# set :shared_dirs, fetch(:shared_dirs, []).push('public/assets')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')
set :shared_files, fetch(:shared_files, []).push('db/production.sqlite3')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use', '2.3.1'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0 --skip-existing}
  command %(mkdir -p "#{fetch(:deploy_to)}/shared/tmp/pids")
  command %(mkdir -p "#{fetch(:deploy_to)}/shared/tmp/sockets")
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
        invoke :'puma:start'
      end
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

task :docker_exec do
  command %{docker exec -i -t lottery /bin/zsh}
end

namespace :docker do
  task build_image: :environment do
    # command %{docker build -t mina_docker_deploy .}
  end

  task start: :environment do
    command %{docker run -d --rm --name lottery -p 3000:3000 lottery}
  end

  task stop: :environment do
    command %{docker stop mina_docker_deploy || echo 'stop docker'}
  end

  task exec: :environment do
    command %{docker exec -i -t lottery /bin/zsh}
  end

  task deploy: :environment do
    deploy do
      invoke :'git:clone'
      # invoke :'deploy:link_shared_paths'
      # invoke :'bundle:install'
      # invoke :'rails:db_migrate'
      # invoke :'rails:assets_precompile'
      invoke :'deploy:cleanup'

      on :launch do
        invoke :'docker:build_image'
        invoke :'docker:stop'
        invoke :'docker:stop'
        invoke :'docker:start'
      end
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
