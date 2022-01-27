class UsersController < ApplicationController
        before_action :authorized, only: [:auto_login, :index ]

        def index
            user = User.all
            if user
                render json: {user: user}, status: 200
            else
                render json: {error: "User not found"}, status: 401
            end
        end


        # Register
        def create
            @user = User.create(user_params)

            if @user.valid?
                token = encode_token({user_id: @user.id})
                render json: {user: @user, token: token}
            else
                render json: {error: "Invalid username or password"}, status: :unauthorized
            end
        end

        # Log in
        def login
            @user = User.find_by(username: params[:username])
            if @user && @user.authenticate(params[:password])
                token = encode_token({user_id: @user.id})
                render json: {user: @user, token: token}
            else
                render json: {error: "Invalid username or password"}, status: :unauthorized
            end
        end

        def auto_login
            render json: @user
        end

        private

        def user_params
            params.permit(:username, :password, :age)
        end

end
