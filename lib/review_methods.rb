module ReviewMethods
  def set_review
    @review = Review.find(params[:id])
  end
end
