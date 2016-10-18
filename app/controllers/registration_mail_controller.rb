class RegistationMailController < Devise::RegistrationsController
  def create 
    super
    if @user.persisted?
      EmailDeliverWorker.User
    end
  end 
end