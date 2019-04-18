class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_price.subject
  #
  def notify_price(user)
    @user = user
    @products = user.products
    mail to: user.email, subject: "登録されている商品の価格のお知らせ"
  end
end
