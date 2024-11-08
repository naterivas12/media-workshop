class Article < ApplicationRecord
  # Associations
  belongs_to :user
  has_one_attached :cover
  has_many :comments, dependent: :destroy

  # Validations
  validates :title, :body, :cover, presence: true
  validates :title, uniqueness: true

  def to_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)
    markdown.render(body)
  end
end
