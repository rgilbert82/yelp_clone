module CategorySorting
  def paginate(options_arr, count, city=nil)
    self.filter_by_option(options_arr, city).slice((count -1) * Business::PER_PAGE, Business::PER_PAGE)
  end

  def number_of_business_pages(options_arr, city=nil)
    (self.filter_by_option(options_arr, city).size / Business::PER_PAGE.to_f).ceil
  end

  def filter_by_option(options_arr, city=nil)
    price_options = options_arr.select {|a| a.match(/\bprice_range_/)}
    non_price_options = options_arr.select {|a| !a.match(/\bprice_range_/)}
    unfiltered_businesses = city ? self.city_businesses(city) : self.all_businesses
    businesses = price_options.empty? ? unfiltered_businesses.slice(0..-1) : []

    price_options.each do |option|
      range = "$" * (option.gsub("price_range_", "").to_i)
      businesses.concat(unfiltered_businesses.select { |b| b.price_range == range }).uniq!
    end

    non_price_options.each do |option|
      if option == "open_now"
        businesses.select! { |b| b.open_now? }
      else
        businesses.select! { |b| b.has_option?(option) }
      end
    end

    businesses
  end
end
