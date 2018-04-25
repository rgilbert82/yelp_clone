module Paginator
  def per_page
    if self.class == Class
      self::PER_PAGE
    else
      self.class::PER_PAGE
    end
  end

  def paginate(list, count)
    list.limit(per_page).offset((count - 1) * per_page)
  end

  def paginate_array(arr, count)
    arr.slice((count - 1) * per_page, per_page)
  end
end
