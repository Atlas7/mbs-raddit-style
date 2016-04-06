class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_owner!, except: [:index, :show]

  def show
    @mode = 'show'
    @entries = @user.entries.all.order(:cached_votes_score => :desc)
    @upvoted_entries = @user.find_up_voted_items
    @downvoted_entries = @user.find_down_voted_items
  end

  def edit
    @mode = 'edit'
  end

  def update
    if @user.update(user_params)
      redirect_to user_profile_path(@user)
    else
      render 'edit'
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
      @profile = @user.profile
      #@user.build_profile if @user.profile.nil?
    end

    def user_params
      params.require(:user).permit(profile_attributes: [:id, :name, :birthday, :sex, :tel, :address, :tagline, :introduction, :avatar])
    end

    def authenticate_owner!
      redirect_to root_path unless user_signed_in? && current_user.to_param == params[:id]
    end
    
end
