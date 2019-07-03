App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (msg) ->
    $('#update_all_btn').prop('disabled', false)
    $('#loading').remove()
    alert msg

  update_all: ->
    @perform 'update_all'

$(document).on 'click', '[data-behavior~=update_all]', ->
  $('#update_all_btn').prop('disabled', true)
  $('#update_all_products').append('<h4 id="loading">Loading...</h4>')
  App.notification.update_all()
