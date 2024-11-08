class Comment < ApplicationRecord
  # Associations
  belongs_to :article
  belongs_to :user

  # Validations
  validates :body, presence: true
end
