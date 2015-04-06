class RelationshipsController < ApplicationController
  def index
    @relationships = current_user.following_relationshops
  end

end
