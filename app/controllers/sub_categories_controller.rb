class SubCategoriesController < ApplicationController
  before_action :set_cities
  before_action :set_categories

  def show
    @category = Category.find_by slug: params[:category_id]
    @sub_category = SubCategory.find_by slug: params[:id]
    @count = (params[:count] || 1).to_i
    @page = (params[:page] || [])

    if params[:city_id]
      @city = City.find_by slug: params[:city_id]
      @city_name = @city.name + ", " + @city.state.name
    else
      @city = nil
      @city_name = "All Cities"
    end

    @pages = @sub_category.number_of_business_pages(@page, @city)
    @businesses = @sub_category.paginate(@page, @count, @city)

    respond_to do |format|
      format.js
      format.html
    end
  end
end
