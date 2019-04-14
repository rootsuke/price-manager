desc "This task is called by the Heroku scheduler add-on"
task :test_task => :environment do
  puts "done test."
end

task :update_all => :environment do
  users = User.all
  users.each do |user|
    user.update_all_product
  end
  puts "done updating price."
end
