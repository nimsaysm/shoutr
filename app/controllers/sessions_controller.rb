class SessionsController < Clearance::SessionsController
    private

    #extend or modify the authenticate method
    def authenticate(_)
        super(session_params)
    end

    def session_params
        ActionController::Parameters.new(session: session_params_with_email)
    end

    def session_params_with_email
        params.
            require(:session).
            permit(:password).
            merge(email: user.email)
    end

    #search the user by the username or email, if it does not exist creates a new Guest object
    def user
        User.where(email: email_or_username).or(User.where(username: email_or_username)).first || Guest.new
    end

    def email_or_username
        params[:session][:email_or_username]
    end
end