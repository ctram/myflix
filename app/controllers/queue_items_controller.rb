class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  # TODO: code update_index()
  def update_index
    # Assigns new positions for each queue_item
    if num_queue_items_of_current_user < params[:queue_items].count
      @queue_items = previous_queue_items
      flash[:error] = "You cannot modify another user's data."
      render :index
    elsif params_queue_items_position_invalid_type?
      @queue_items = previous_queue_items
      flash[:error] = "Updated positions must be an integer (not a float or letter or symbol, etc.)"
      render :index
    else
      params[:queue_items].each do |queue_item|
        QueueItem.find(queue_item[:id]).update(position: queue_item[:position])
      end

      # Ensures that all position numbers are consecutive.
      current_user.queue_items.each_with_index do |queue_item, i|
        queue_item.update(position: i + 1)
      end

      redirect_to my_queue_path
    end
  end


Source: show | on GitHub
update_attributes(attributes)
Link
Alias for: update
update_attributes!(attributes)
  def create
    video = Video.find(params[:video_id])
    queue_video(video)
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.delete unless queue_item.user != current_user
    update_queue_items_positions()
    redirect_to my_queue_path
  end

  private

  def update_queue_items

  end

  def queue_video(video)
    QueueItem.create(video: video, user: current_user, position: new_queue_item_position) unless current_user_already_queued_this_video?(video)
  end

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def current_user_already_queued_this_video?(video)
    current_user.queue_items.map(&:video).include?(video)
  end

  def update_queue_items_positions
    queue_items = current_user.queue_items
    queue_items.each_with_index do |queue_item, i|
      queue_item.position = i + 1
      queue_item.save
    end
  end

  def num_queue_items_of_current_user
    params[:queue_items].select{|queue_item| QueueItem.find(queue_item[:id]).user == current_user}.count
  end

  # Returns true if the new position is NOT an integer.
  def params_queue_items_position_invalid_type?
    num = %w(1 2 3 4 5 6 7 8 9 0)
    params[:queue_items].each do |queue_item|
      chars = queue_item[:position].split('')
      chars.each do |char|
        return true if char == '.'
        return true if !num.include?(char)
      end
    end
    false
  end

  # Returns array of queue_items as they were BEFORE the call of the current action.
  def previous_queue_items
    params[:queue_items].map do |queue_item|
      QueueItem.find(queue_item[:id])
    end
  end

  def normalize_queue_item_positions

  end

end
