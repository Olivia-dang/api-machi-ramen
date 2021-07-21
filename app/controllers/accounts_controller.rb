class AccountsController < ApplicationController
    before_action :authenticate_user!

    def show
        render json: { id: current_user.id, email: current_user.email, first_name: current_user.first_name }, status: :ok
    end
end
