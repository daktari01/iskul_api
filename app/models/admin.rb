class Admin < ApplicationRecord
  devise :database_authenticatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  validates :username, presence: true
  validates :email, presence: true, :email_format => { :message => 'is not looking good'}
  validates :password, presence: true
end