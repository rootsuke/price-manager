class UpdateAllProductPriceJob < ApplicationJob
  queue_as :update_price

  def perform(*args)
    # Do something later
  end
end
