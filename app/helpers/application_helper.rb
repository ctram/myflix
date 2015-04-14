module ApplicationHelper

  # Returns html options to create a select tag that
  # consists of 1 - 5 stars; for rating videos.
  def option_select_rating_drop_down(selected=nil)
    options_for_select(
                        {
                          '5 stars' => 5,
                          '4 stars' => 4,
                          '3 stars' => 3,
                          '2 stars' => 2,
                          '1 star' => 1
                        },
                        selected
                      )
  end

end
