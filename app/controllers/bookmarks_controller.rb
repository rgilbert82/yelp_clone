class BookmarksController < ApplicationController
  before_action :require_user
  before_action :set_business

  def status
    if current_user.has_bookmark?(@business)
      Bookmark.where(user: current_user, business: @business).first.destroy
    else
      Bookmark.create(user: current_user, business: @business)
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def set_business
    @business = Business.find_by slug: params[:id]
  end
end
