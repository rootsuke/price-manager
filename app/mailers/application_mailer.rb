class ApplicationMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  default from: 'noreply@price-manager.herokuapp.com'
  layout 'mailer'
end
