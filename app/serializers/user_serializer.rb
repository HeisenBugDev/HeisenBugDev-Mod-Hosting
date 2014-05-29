class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :authentication_token, :sign_in_count,
    :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
    :last_sign_in_ip, :created_at, :updated_at

  def filter(keys)
    unless can? :edit, object
      keys - [:email, :sign_in_count, :current_sign_in_at, :last_sign_in_at,
        :current_sign_in_ip, :last_sign_in_ip]
    end

    unless scope == object
      keys - [:authentication_token]
    end

    keys
  end
end
