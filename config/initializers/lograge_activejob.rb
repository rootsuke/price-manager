Rails.application.configure do
  config.lograge_activejob.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_activejob_#{Rails.env}.log"

  config.lograge_activejob.custom_options = lambda do |event|
    { event_time: event.time, status: event.payload[:exception_object].blank? ? 200 : 500 }
  end
end
