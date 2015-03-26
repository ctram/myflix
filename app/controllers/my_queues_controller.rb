class MyQueuesController < ApplicationController
  before_action :require_user

  def index
  end

  def destroy
  end

  def show
    @user = current_user
    if @user.my_queue == nil
      redirect_to action: 'destroy'
      binding.pry
    else
      @my_queue = MyQueue.find_by(user_id:@user.id)
    end
  end

  # FIXME: not able to reach my_queue#create with a redirect from #show
  def create
    @user = current_user
    @user.my_queue = MyQueue.create(user_id: @user.id)
    binding.pry
    redirect_to my_queue_path
  end
end
