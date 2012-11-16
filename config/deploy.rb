set :application, "demo_app"

set :repository,  "ssh://git@github.com:yuanquan74/#{application}.git"
set :deploy_to, "/home/ec2-user/deployed/#{application}"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#this is the server address to ssh to for deloy
role :web, "test.ottomom.com"                          # Your HTTP server, Apache/etc
role :app, "test.ottomom.com"                          # This may be the same as your `Web` server
role :db,  "test.ottomom.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

#This is the username to ssh into server
set :user, "ec2-user"
#my guess is this scm user name is not needed as it's specified in repository URI
#set :scm_username, "yuanquan74" 
#I don't think we need to use sudo as all files should be under /home/user
set :use_sudo, false

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

#If you are using Passenger mod_rails uncomment this:
namespace :deploy do
	task :start, :roles => :app do 
		run "touch #{current_release}/tmp/restart.txt"
	end
	task :stop, :roles => :app do 
		#do nothing
	end
	
	desc "Restart Application"
  	task :restart, :roles => :app do
    	run "touch #{current_release}/tmp/restart.txt"
  	end

	#task :restart, :roles => :app, :except => { :no_release => true } do
	#	run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
	#end
end