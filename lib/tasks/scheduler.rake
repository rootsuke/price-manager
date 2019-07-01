desc "This task is called by the Heroku scheduler add-on"
task :test_task => :environment do
  puts "done test."
end

task :update_all => :environment do
  puts "start updating price."
  users = User.all
  users.each do |user|
    UpdatePriceWorker.perform_async(user.id)
  end
  puts "finish updating price."
end
