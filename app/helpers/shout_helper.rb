module ShoutHelper 
    def shout_form_for(content_type)
        form_for(Shout.new, url: content_type.new) do |form|
            form.fields_for(:content) { |content_form| yield(content_form) } +
            form.submit("Shout!", class: "btn btn-dark")
        end
    end

    def like_button(shout)
        if current_user.liked?(shout)
            button_to "Unlike", unlike_shout_path(shout), method: :delete, class: "btn btn-dark"
        else
            button_to "Like", like_shout_path(shout), method: :post, class: "btn btn-dark"
        end
    end

    def autolink(text)
        #mention will hold the text after @ (username)
        text.
        gsub(/@\w+/) { |mention| link_to mention, user_path(mention[1..-1]) }.
        gsub(/#\w+/) { |hashtag| link_to hashtag, hashtag_path(hashtag[1..-1]) }.
        html_safe
    end
end