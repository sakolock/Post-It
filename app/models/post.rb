class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true

  before_save :generate_slug

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).length
  end

  def down_votes
    self.votes.where(vote: false).length
  end

  def generate_slug
    str = self.title
    str.strip
    str.gsub!(/[^A-Z0-9]/i, '-')
    str.gsub!('-+', '-')
    self.slug = str.downcase
  end

  def to_param
    self.slug
  end
end
