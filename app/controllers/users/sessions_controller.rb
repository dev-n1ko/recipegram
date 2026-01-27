class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = resource_class.new(sign_in_params)


    if sign_in_params[:email].blank?
      resource.errors.add(:email, :blank)
      render :new, status: :unprocessable_entity
      return
    end

    if sign_in_params[:password].blank?
      resource.errors.add(:password, :blank)
      render :new, status: :unprocessable_entity
      return
    end

    user = resource_class.find_by(email: sign_in_params[:email])

    if user.nil?
      resource.errors.add(:email, :not_found)
      render :new, status: :unprocessable_entity
      return
    end

    unless user.valid_password?(sign_in_params[:password])
      resource.errors.add(:password, :invalid)
      render :new, status: :unprocessable_entity
      return
    end

    self.resource = user
    super
  end

end
