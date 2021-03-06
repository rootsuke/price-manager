# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/notify_price
  def notify_price
    user = User.first
    UserMailer.notify_price(user)
  end
end
