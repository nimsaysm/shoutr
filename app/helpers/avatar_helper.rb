module AvatarHelper
    def avatar(user)
        email_digest = Digest::MD5.hexdigest user.email
        gravatar_url = "//www.gravatar.com/avatar/#{ email_digest }"
        
        image_tag(gravatar_url, class: "rounded-circle", style:"max-height: 50px; max-width: 50px")
    end
end