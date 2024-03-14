class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new
    @friendship.asker = current_user.profile
    @friendship.receiver = Profile.find(params[:profile_id])
    @friendship.save
    redirect_to profile_path(current_user.profile)
  end

  def index
    # @profile1 = current_user.profile
    # @profile2 = Profile.find(params[:id])
    # if Friendship.between_profiles(@profile1, @profile2).exists?
    # end
  end

end
