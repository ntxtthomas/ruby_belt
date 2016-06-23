class User < ActiveRecord::Base
  belongs_to :location
  has_secure_password
  has_many :events, through: :joins
  has_many :comments
  has_many :joins
end
