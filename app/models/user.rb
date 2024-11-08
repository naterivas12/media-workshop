class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :username, uniqueness: true, presence: true

  # Enums
  enum role: { contributor: 0, admin: 1 }

  # Associations
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_secure_token
end
