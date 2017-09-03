class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true

  before_save :generate_slug

  def to_param
    self.slug
  end

  def generate_slug
    str = self.username.strip
    self.slug = str.gsub!(/[^A-Z0-9]/i, "-").gsub!('-+', '-').downcase
  end
end
