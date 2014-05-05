# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default("")
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#  authentication_token   :string(255)
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token)
#  index_users_on_name                  (name)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  BETA_USERS = %w(hunterboerner forkk sammko k2b6s9j eydamos abrarsyed jadar
    trainerguy22 matalcdev xelitexirish orochimarufan viliml dodolend endershadow)
  before_validation :beta_user?
  has_and_belongs_to_many :projects
  rolify
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable,
  :omniauthable, :omniauth_providers => [:github]
  validates_presence_of :name
  validates_uniqueness_of :name

  def email_required?
    false
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def beta_user?
    unless Rails.env.test?
      unless BETA_USERS.include?(name.downcase)
        errors.add :name, 'Not on the beta list'
      end
    end
  end

  def self.find_for_github_oauth(auth)
    where(auth.slice(:provider, :uid, :email)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email unless auth.info.email.nil?
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.nickname # assuming the user model has a name
    end
  end
end
