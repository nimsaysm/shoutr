class FollowedUsersController < ApplicationController
    def index
        @user = find_user
        @followed_users = @user.followed_users
    end
    
    def create 
        user_to_follow = find_user
        current_user.follow(user_to_follow)
        redirect_to user_to_follow
    end

    def destroy
        user_to_unfollow = find_user
        current_user.unfollow(user_to_unfollow)
        redirect_to user_to_unfollow
    end

    private

    def find_user
        # _user or _user = find (if _user is nil or false: set _user to be the value of find_by).
        @_user ||= User.find_by(username: params[:id])
    end
end