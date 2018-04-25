module EventMethods
  def set_event
    @event = Event.find_by slug: params[:id]
  end
end
