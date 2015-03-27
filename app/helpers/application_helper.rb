module ApplicationHelper

  # Returns html options to create a select tag that 
  # consists of 1 - 5 stars; for rating videos.
  def option_select_rating_drop_down
    options_for_select([5,4,3,2,1].map{|num| pluralize(num, 'Star')})
  end

end
