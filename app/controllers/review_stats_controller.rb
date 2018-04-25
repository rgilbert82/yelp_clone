class ReviewStatsController < ApplicationController
  include ReviewMethods

  before_action :require_user
  before_action :set_review

  def status
    user_review_stats = ReviewStat.where(user_id: current_user.id, review_id: @review.id).first
    @stat = params[:stat]

    unless user_review_stats
      user_review_stats = ReviewStat.new(user_id: current_user.id, review_id: @review.id)
    end

    case @stat
    when "useful"
      @selected = !user_review_stats.useful
      user_review_stats.update(useful: @selected)
    when "funny"
      @selected = !user_review_stats.funny
      user_review_stats.update(funny: @selected)
    when "cool"
      @selected = !user_review_stats.cool
      user_review_stats.update(cool: @selected)
    end

    respond_to do |format|
      format.js
    end
  end
end
