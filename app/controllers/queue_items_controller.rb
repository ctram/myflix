class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def update_index
    queue_items_in_params = {}
    # Filter params for only queue_items and their updated positions
    params.each do |k,v|
      if k.include?('queue_item') and k.include?('position')
        queue_items_in_params[k] = v
      end
    end

    @queue_items = []
    # Build @queue_items ivar incase a render of :index is required
    queue_items_in_params.each do |k,v|
      queue_item_id = k.split('_')[2].to_i
      @queue_items << QueueItem.find(queue_item_id)
    end

    if queue_items_in_params.select{|k,v| v.include?('.')}.count > 0
      flash[:error] = "You may only enter integers for queue positions"
      render :index
    else
      queue_items_in_params.each do |k,v|
        queue_item_id = k.split('_')[2].to_i
        new_position = v.to_i
        QueueItem.find(queue_item_id).position = new_position
      end
      redirect_to(my_queue_path)
    end
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
end
