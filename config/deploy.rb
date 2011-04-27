set :application, "stuinfo"
set :deploy_to, "/stuinfo"
set :scm, :git
set :repository, "."
set :branch, "master"
set :deploy_via, :copy

set :user,'root'
set :ssh_options, {:forward_agent=>true}

server "192.168.145.253", :app, :web, :db, :primary => true
set :user,'root'
set :use_sudo, false

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => {:no_release=>true} do
    run "touch #{current_path}/tmp/restart.txt"
  end
  [:start, :stop].each do |t|
      desc "#{t} task is a no-op with mod_rails"
      task t, :roles => :app do ; end
  end
end

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
