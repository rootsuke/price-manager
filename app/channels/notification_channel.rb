class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_channel_#{current_user.id}" if current_user.present?
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def update_all
    UpdatePriceWorker.perform_async(current_user.id, broadcast: true) if current_user.present?
  end
end
