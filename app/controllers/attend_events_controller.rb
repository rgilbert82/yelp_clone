class AttendEventsController < ApplicationController
  include EventMethods

  before_action :require_user
  before_action :set_event

  def status
    if current_user.is_attending?(@event)
      UserEvent.where(user: current_user, event: @event).first.destroy
    else
      UserEvent.create(user: current_user, event: @event)
    end

    respond_to do |format|
      format.js
    end
  end
end
