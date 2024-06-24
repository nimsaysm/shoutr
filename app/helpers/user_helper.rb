module UserHelper
    def follow_button(user)
        if current_user.email != user.email && current_user.email != ""
            if current_user.following?(user)
                button_to "Unfollow", unfollow_user_path, method: :delete, class:"btn btn-dark"
            else
                button_to "Follow", follow_user_path, class:"btn btn-dark"
            end
        end
    end
end
