desc "This task is called by the Heroku scheduler add-on"
task :check_the_watchers => :environment do
  puts "Checking on the watchers..."
  Watcher.check_all
  puts "done."
end