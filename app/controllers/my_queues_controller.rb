class MyQueuesController < ApplicationController
  before_action :require_user

  def show
    @user = current_user
    if @user.my_queue == nil
      @my_queue = MyQueue.create(user_id: @user.id)
      @user.my_queue = @my_queue
    else
      @my_queue = MyQueue.find_by(user_id:@user.id)
    end
  end

end
