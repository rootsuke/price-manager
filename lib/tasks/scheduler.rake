desc "This task is called by the Heroku scheduler add-on"
task :test_task => :environment do
  puts "done test."
end

task :update_all => :environment do
  puts "start updating price."
  users = User.all
  users.each do |user|
    user.update_all_product
    UserMailer.notify_price(user).deliver_now
  end
  puts "finish updating price."
end
