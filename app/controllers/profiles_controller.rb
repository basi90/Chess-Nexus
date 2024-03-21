class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    @user = current_user
    @profile = Profile.new(profile_params)
    @profile.user = @user
    @profile.save
    redirect_to profile_path(@profile)
  end

  def show
    @profile = Profile.find(params[:id])
    if Profile.where(user: current_user).exists?
      @friendships = Friendship.where(asker: current_user.profile)
    end

    if @profile.user == current_user
      @games = Game.where(white: current_user, finished: false).or(Game.where(black: current_user, finished: false))
      @games.reject { |game| game.black.nil? }
    end
  end

  def index
    @profiles = Profile.all
    if params[:query].present?
      @profiles = @profiles.where("username ILIKE ?", "%#{params[:query]}%")
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:username, :bio, :profile_picture)
  end
end
