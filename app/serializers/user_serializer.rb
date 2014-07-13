class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :authentication_token, :sign_in_count,
    :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
    :last_sign_in_ip, :created_at, :updated_at, :slug

  def attributes
    hash = super
    remove_list = []
    unless Ability.new(scope).can?(:edit, object)
      (remove_list << [
        :email, :sign_in_count, :current_sign_in_at,
        :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
      ]).flatten!
    end

    unless scope == object
      remove_list << :authentication_token
    end

    hash.except(*remove_list)
  end
end
