class SearchesController < ApplicationController
  before_action :set_categories
  before_action :set_count

  def show
    @search_term = params[:find].strip
    @location_id = params[:location].to_i

    if @search_term.empty?
      search_results = []
    elsif @location_id == 0
      search_results = Business.all.to_a
    else
      search_results = City.find(@location_id).businesses.to_a
    end

    search_results.select! { |b| b.name.match(/#{@search_term}/i) }
    @pages = number_of_pages(search_results)
    @businesses = Business.paginate_array(search_results, @count)

    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def number_of_pages(list)
    (list.size / Business::PER_PAGE.to_f).ceil
  end
end
