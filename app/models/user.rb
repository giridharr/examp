class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:async, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  enum roles: [:admin,:super_admin]
  has_many :books

end
