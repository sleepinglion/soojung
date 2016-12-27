set :application, 'soojung'
set :repo_url, 'git@github.com:sleeping-lion/soojung.git'
set :branch, 'master'
set :deploy_to, '/home/deploy/soojung'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
set :pty, true
set :linked_files, %w{config/database.yml .env}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets public/assets}

#set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  
  desc 'Refresh sitemap'
  task :refresh_sitemap do
    on roles(:app), in: :sequence, wait: 1 do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'sitemap:refresh'
        end
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:refresh_sitemap'
  after :finishing, 'deploy:cleanup'
end


