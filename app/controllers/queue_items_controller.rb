class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

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

  def queue_video(video)
    QueueItem.create(video: video, user: current_user, position: new_queue_item_position) unless current_user_queued_video?(video)
  end

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def current_user_queued_video?(video)
    current_user.queue_items.map{|queue_item| queue_item.video}.include?(video)
  end

  def update_queue_items_positions
    queue_items = current_user.queue_items
    queue_items = queue_items.sort_by{|queue_item| queue_item.position}
    queue_items.each_with_index do |queue_item, i|
      queue_item.position = i + 1
      queue_item.save
    end
  end
end
