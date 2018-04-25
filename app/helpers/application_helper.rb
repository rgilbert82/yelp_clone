module ApplicationHelper
  def format_phone_number(num)
    if num.size > 0
      '(' + num[0..2] + ') ' + num[3..5] + '-' + num[6..9]
    end
  end

  def price_range_info(range)
    if range == "$"
      "low"
    elsif range == "$$"
      "moderate"
    elsif range == "$$$"
      "high"
    else
      "expensive"
    end
  end

  def format_date(dt)
    dt.strftime("%b %d %Y")
  end

  def format_date_2(dt)
    dt.strftime("%m/%d/%y")
  end

  def format_date_3(dt)
    dt.strftime("%A, %b %d %Y")
  end

  def format_time(dt)
    dt.strftime("%l:%M %p")
  end

  def day_name(day)
    case day
    when "1"
      "Mon"
    when "2"
      "Tue"
    when "3"
      "Wed"
    when "4"
      "Thu"
    when "5"
      "Fri"
    when "6"
      "Sat"
    when "7"
      "Sun"
    end
  end

  def star_color(rating)
    if rating == 5
      "star-box-starred-5"
    elsif rating >= 4
      "star-box-starred-4"
    elsif rating >= 3
      "star-box-starred-3"
    elsif rating >= 2
      "star-box-starred-2"
    elsif rating >= 0
      "star-box-starred-1"
    else
      ""
    end
  end

  def nested_categories_sub_categories
    Category.all.map do |category|
      [
        category.name,
        category.sub_categories.collect { |sc| [sc.name, sc.id] }
      ]
    end
  end

  def show_limited_text(text)
    if text.length > 60
      text[0...60] + "..."
    else
      text
    end
  end

  def how_long_ago(dt)
    current_time = DateTime.now
    compare_time = dt.to_datetime
    secs = ((current_time - compare_time)*24*60*60).to_i
    mins = secs / 60
    hours = mins / 60
    days = hours / 24

    if days > 5
      format_date_2(dt)
    elsif days > 0
      "#{days} day#{days > 1 ? 's' : ''} ago"
    elsif hours > 0
      "#{hours} hour#{hours > 1 ? 's' : ''} ago"
    elsif mins > 0
      "#{mins} minute#{mins > 1 ? 's' : ''} ago"
    else
      "#{secs} seconds ago"
    end
  end

  def business_index(index, count)
    (index + 1) + (count - 1) * Business::PER_PAGE
  end

  def user_index(index, count)
    (index + 1) + (count - 1) * User::PER_PAGE
  end

  def filter_toggle(page)
    new_page = @page.slice(0..-1)
    @page.include?(page) ? new_page.delete(page) : new_page.push(page)
    new_page
  end

  def btn_select_toggle(page)
    @page.include?(page) ? 'btn-selected' : ''
  end
end
