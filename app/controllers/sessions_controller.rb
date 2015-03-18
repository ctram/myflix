class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # TODO: check that the user trying to log in is an existing user in the db. If not, show error message. If so, create a new session ID.
  end

  def destroy
  end

end
