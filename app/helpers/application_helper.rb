module ApplicationHelper

  def full_title(page_title = '')
    base_title = 'Online Web Store'
    if page_title.empty?
      base_title
    else
      page_title +  ' | ' + base_title
    end
  end

  def get_sort_name(sort)
    if !sort
      nil
    else
      case sort.downcase
        when 'lastsold'
          'Last Sold'
        when 'datenewest'
          'Most Recent'
        when 'dateoldest'
          'Least Recent'
        when 'pricelowest'
          'Price (Lowest First)'
        when 'pricehighest'
          'Price (Highest First)'
        else
          nil
      end
    end
  end

end
