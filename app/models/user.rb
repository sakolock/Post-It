class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 3}

  before_save :generate_slug

  def to_param
    self.slug
  end

  def generate_slug
    str = self.name.strip
    self.slug = str.gsub!(/[^A-Z0-9]/i, "-").gsub!('-+', '-').downcase
  end
end
