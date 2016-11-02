class User < ApplicationRecord
  has_secure_password

  has_many :campaigns, dependent: :destroy
  has_many :pledge, dependent: :nullify

end
