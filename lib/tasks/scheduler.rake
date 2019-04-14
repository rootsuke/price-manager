desc "This task is called by the Heroku scheduler add-on"
task :test_task => :environment do
  puts "done test."
end
